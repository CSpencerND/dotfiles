#!/usr/bin/env python

import requests as re
import os.path as osp
from os import makedirs as mkdir
from pprint import pformat as pf


def get_location() -> str:

    location_url: str = "https://location.services.mozilla.com/v1/geolocate?key=geoclue"

    r = re.get(location_url).json()

    lat: int = r["location"]["lat"]
    lon: int = r["location"]["lng"]

    return f"lat={lat}&lon={lon}"


def get_weather(location: str) -> dict:

    api_key: str = "appid=ef8c3512dedaf5aa46ed1ca846d4fade"
    base_url: str = "https://api.openweathermap.org/data/2.5/onecall?units=imperial"
    excludes: str = "exclude=current,minutely,alerts"
    full_url: str = f"{base_url}&{api_key}&{location}&{excludes}"

    r = re.get(full_url).json()

    return r


def get_trend(current: int, forecast: int) -> str:

    trend: str = "   "

    if current > forecast:
        trend = "   "

    elif forecast > current:
        trend = "   "

    return trend


def get_icon(code: str, moon: str, is_hot: bool = False) -> str:

    # TODO add meteorological events and possibly wind conditions

    icon: str = "   "

    # if using Nerd Fonts
    match code:

        case code if code == "01d" and is_hot:
            icon = "   "

        case "01n":
            icon = f"{moon}    "

        case "02d":
            icon = "   "

        case "02n":
            icon = f"{moon}    "

        case "03d":
            icon = "   "

        case "03n":
            icon = f"{moon}    "

        case "04d":
            icon = "   "

        case "04n":
            icon = f"{moon}    "

        case "09d":
            icon = "   "

        case "09n":
            icon = f"{moon}    "

        case "10d":
            icon = "   "

        case "10n":
            icon = f"{moon}    "

        case "11d":
            icon = "   "

        case "11n":
            icon = f"{moon}    "

        case "13d":
            icon = "   "

        case "13n":
            icon = f"{moon}    "

        case "50d":
            icon = "   "

        case "50n":
            icon = f"{moon}    "

    return icon


def get_moon(data: dict) -> str:

    code: float = data["daily"][0]["moon_phase"]
    icon: str = "  "

    if code > 0.06 and code < 0.19:  # 13
        icon = "  "

    elif code > 0.19 and code < 0.31:  # 12
        icon = "  "

    elif code > 0.31 and code < 0.44:  # 13
        icon = "  "

    elif code > 0.44 and code < 0.56:  # 12
        icon = "  "

    elif code > 0.56 and code < 0.69:  # 13
        icon = "  "

    elif code > 0.69 and code < 0.81:  # 12
        icon = "  "

    elif code > 0.81 and code < 0.94:  # 13
        icon = "  "

    return icon


# TODO: refoactor main; clean it up; might make more functions
def main() -> None:

    # location and weather data
    location: str = get_location()
    data: dict = get_weather(location)

    # current and 3 hour forecast temperature
    current: int = round(data["hourly"][0]["temp"])
    forecast: int = round(data["hourly"][2]["temp"])

    # codes for weather icons
    current_code: str = data["hourly"][0]["weather"][0]["icon"]
    forecast_code: str = data["hourly"][3]["weather"][0]["icon"]

    # moon phase icon
    moon: str = get_moon(data)

    # icons for weather and trend
    current_icon: str = get_icon(current_code, moon, current > 79)
    forecast_icon: str = get_icon(forecast_code, moon, forecast > 79)
    trend: str = get_trend(current, forecast)

    # create output string
    weather_str: str = f"{current_icon}{current}°{trend}{forecast_icon}{forecast}°"

    # create directory if it does not exist
    if not osp.isdir(osp.expanduser("~/.cache/weather/")):
        mkdir(osp.expanduser("~/.cache/weather/"))
        print("Created directory at ~/.cache/weather/")

    # write {data} to file
    with open(osp.expanduser("~/.cache/weather/data.py"), "w") as f:
        f.write(pf(data))

    # write {weather_str} to file
    with open(osp.expanduser("~/.cache/weather/pyweather"), "w") as f:
        f.write(weather_str)


if __name__ == "__main__":
    main()

    # if using Weather Icons
    # match code:
    # case "01d": icon = ""
    # case "01n": icon = moon
    # case "02d": icon = ""
    # case "02n": icon = moon
    # case "03d": icon = ""
    # case "03n": icon = moon
    # case "04d": icon = ""
    # case "04n": icon = f"{moon} "
    # case "09d": icon = ""
    # case "09n": icon = f"{moon} "
    # case "10d": icon = ""
    # case "10n": icon = f"{moon} "
    # case "11d": icon = ""
    # case "11n": icon = f"{moon} "
    # case "13d": icon = ""
    # case "13n": icon = f"{moon} "
    # case "50d": icon = ""
    # case "50n": icon = f"{moon} "
    # case _: return icon
