#!/usr/bin/env python

import requests as re
import numpy as np
from pprint import pprint as pp


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

    if current > forecast:
        trend = " "
    elif forecast > current:
        trend = " "
    else:
        trend = " "

    return trend


def get_icon(code: str, moon: str) -> str:

    icon: str = " "

    # Nerd Fonts
    match code:

        case "01d":
            icon = " "

        case "01n":
            icon = moon

        case "02d":
            icon = " "

        case "02n":
            icon = moon

        case "03d":
            icon = "  "

        case "03n":
            icon = moon

        case "04d":
            icon = " "

        case "04n":
            icon = f"{moon}  "

        case "09d":
            icon = " "

        case "09n":
            icon = f"{moon}  "

        case "10d":
            icon = "  "

        case "10n":
            icon = f"{moon}  "

        case "11d":
            icon = "  "

        case "11n":
            icon = f"{moon}  "

        case "13d":
            icon = "  "

        case "13n":
            icon = f"{moon}  "

        case "50d":
            icon = "  "

        case "50n":
            icon = f"{moon}  "

        case _:
            return icon

    return icon


def get_moon(data: dict) -> str:

    code: float = data["daily"][0]["moon_phase"]
    icon: str = "  "

    match code:

        case n if n in np.arange(0.01, 0.14):  # 13
            icon = "  "

        case n if n in np.arange(0.14, 0.28):  # 14
            icon = "  "

        case n if n in np.arange(0.28, 0.42):  # 14
            icon = "  "

        case n if n in np.arange(0.42, 0.58):  # 16
            icon = "  "

        case n if n in np.arange(0.58, 0.72):  # 14
            icon = "  "

        case n if n in np.arange(0.72, 0.86):  # 14
            icon = "  "

        case n if n in np.arange(0.86, 1):  # 14
            icon = "  "

        case _:
            return icon

    return icon


def main() -> int:

    location: str = get_location()
    data: dict = get_weather(location)

    moon: str = get_moon(data)

    current: int = round(data["hourly"][0]["temp"])
    forecast: int = round(data["hourly"][2]["temp"])

    current_code: str = data["hourly"][0]["weather"][0]["icon"]
    forecast_code: str = data["hourly"][3]["weather"][0]["icon"]

    current_icon: str = get_icon(current_code, moon)
    trend: str = get_trend(current, forecast)
    forecast_icon: str = get_icon(forecast_code, moon)

    print(f"{current_icon}{current}°{trend}{forecast_icon}{forecast}°")
    pp(data)

    return 0


if __name__ == "__main__":
    main()

    # Weather Icons
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
