#!/usr/bin/env python


def main():
    perc: str
    charging: str
    icon: str = "  "

    # get current battery level
    with open("/sys/class/power_supply/BAT0/capacity", "r") as f:
        perc = f.read().strip()

    # get charging status
    with open("/sys/class/power_supply/AC/online", "r") as f:
        charging = f.read().strip()

    # determine icon based on battery level
    n: int = int(perc)

    if charging == "1":
        icon = " "
    else:
        if n > 10 and n < 40:
            icon = "  "
        elif n > 39 and n < 60:
            icon = "  "
        elif n > 59 and n < 90:
            icon = "  "
        elif n > 89:
            icon = "  "

    # create string to output
    bat_str: str = f"{icon} {perc}%  "
    print(bat_str)


if __name__ == "__main__":
    main()
