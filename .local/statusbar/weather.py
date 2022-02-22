#!/usr/bin/env python

import requests as re
import os.path as osp
from os import makedirs as mkdir
from pprint import pformat as pf


def get_data() -> dict:
    def _get_location() -> str:

        location_url: str = (
            "https://location.services.mozilla.com/v1/geolocate?key=geoclue"
        )

        location: dict = re.get(location_url).json()

        lat: int = location["location"]["lat"]
        lon: int = location["location"]["lng"]

        return f"lat={lat}&lon={lon}"

    location: str = _get_location()
    api_key: str = "appid=ef8c3512dedaf5aa46ed1ca846d4fade"
    base_url: str = "https://api.openweathermap.org/data/2.5/onecall?units=imperial"
    excludes: str = "exclude=current,minutely,alerts"
    full_url: str = f"{base_url}&{api_key}&{location}&{excludes}"

    data = re.get(full_url).json()

    return data


def get_trend(current: int, forecast: int) -> str:

    trend: str = "   "

    if current > forecast:
        trend = "   "

    elif forecast > current:
        trend = "   "

    return trend


def get_icon(code: str, moon: str, is_hot: bool = False) -> str:
    # TODO: add meteorological events and possibly wind conditions

    # icons for nerd fonts
    icon: str = "   "
    icons: dict = {
        "01n": f"{moon}    ",
        "02d": "   ",
        "02n": f"{moon}    ",
        "03d": "   ",
        "03n": f"{moon}    ",
        "04d": "   ",
        "04n": f"{moon}    ",
        "09d": "   ",
        "09n": f"{moon}    ",
        "10d": "   ",
        "10n": f"{moon}    ",
        "11d": "   ",
        "11n": f"{moon}    ",
        "13d": "   ",
        "13n": f"{moon}    ",
        "50d": "   ",
        "50n": f"{moon}    ",
    }

    for k, v in icons.items():

        if code == "01d" and is_hot:
            icon = "   "

        elif code == k:
            icon = v

    return icon


def get_moon(data: dict) -> str:

    code: float = data["daily"][0]["moon_phase"]
    icon: str = " "

    if 0.06 < code < 0.19:  # 13
        icon = " "

    elif 0.19 < code < 0.31:  # 12
        icon = " "

    elif 0.31 < code < 0.44:  # 13
        icon = " "

    elif 0.44 < code < 0.56:  # 12
        icon = " "

    elif 0.56 < code < 0.69:  # 13
        icon = " "

    elif 0.69 < code < 0.81:  # 12
        icon = " "

    elif 0.81 < code < 0.94:  # 13
        icon = " "

    return icon


def write_data(data: dict, weather: str) -> None:

    # create directory if it does not exist
    if not osp.isdir(osp.expanduser("~/.cache/weather/")):
        mkdir(osp.expanduser("~/.cache/weather/"))
        print("Created directory at ~/.cache/weather/")

    # write {data} to file
    with open(osp.expanduser("~/.cache/weather/data.py"), "w") as f:
        f.write(pf(data))

    # write {weather_str} to file
    with open(osp.expanduser("~/.cache/weather/pyweather"), "w") as f:
        f.write(weather)


def main() -> None:

    # weather data
    data: dict = get_data()

    # moon phase icon
    moon: str = get_moon(data)

    # current and 3-hour forecast temperature
    current: int = round(data["hourly"][0]["temp"])
    forecast: int = round(data["hourly"][2]["temp"])

    # codes for weather icons
    current_code: str = data["hourly"][0]["weather"][0]["icon"]
    forecast_code: str = data["hourly"][2]["weather"][0]["icon"]

    # icons for weather and trend
    current_icon: str = get_icon(current_code, moon, current > 79)
    forecast_icon: str = get_icon(forecast_code, moon, forecast > 79)
    trend: str = get_trend(current, forecast)

    # create and write data
    weather: str = f"{current_icon}{current}°{trend}{forecast_icon}{forecast}°"
    write_data(data, weather)
    # print(weather)


if __name__ == "__main__":
    main()

    # icons for weather icons
    # icons: dict = {
    #     "01d": "",
    #     "01n": moon,
    #     "02d": "",
    #     "02n": moon,
    #     "03d": "",
    #     "03n": moon,
    #     "04d": "",
    #     "04n": f"{moon} ",
    #     "09d": "",
    #     "09n": f"{moon} ",
    #     "10d": "",
    #     "10n": f"{moon} ",
    #     "11d": "",
    #     "11n": f"{moon} ",
    #     "13d": "",
    #     "13n": f"{moon} ",
    #     "50d": "",
    #     "50n": f"{moon} ",
    # }
