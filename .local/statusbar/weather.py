#!/usr/bin/env python

import requests as re
import numpy as np
from pprint import pprint as pp


def main() -> int:

    location: str = get_location()
    data: dict = get_weather(location)

    current: int = round(data["hourly"][0]["temp"])
    forecast: int = round(data["hourly"][2]["temp"])

    current_code: str = data["hourly"][0]["weather"][0]["icon"]
    forecast_code: str = data["hourly"][3]["weather"][0]["icon"]
    moon_code: int = data["daily"][0]["moon_phase"]

    trend: str = get_trend(current, forecast)
    moon: str = get_moon(moon_code)
    current_icon: str = get_icon(current_code, moon)
    forecast_icon: str = get_icon(forecast_code, moon)

    print(f"{current_icon}{current}°{trend}{forecast_icon}{forecast}°")

    return 0


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


def get_moon(code: float) -> str:

    icon: str = ""

    match code:

        # New
        case [1 | 0]:
            icon = "  "
        # Waxing Crescent
        case n if n in np.arange(0.01, 0.25):
            icon = "  "
        # First Quarter
        case 0.25:
            icon = "  "
        # Waxing Gibbous
        case n if n in np.arange(0.26, 0.5):
            icon = "  "
        # Full
        case 0.5:
            icon = "  "
        # Waning Gibbous
        case n if n in np.arange(0.6, 0.75):
            icon = "  "
        # Last Quarter
        case 0.75:
            icon = "  "
        # Waning Crescent
        case n if n in np.arange(0.76, 1):
            icon = "  "

        case _:
            return icon

    return icon


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
