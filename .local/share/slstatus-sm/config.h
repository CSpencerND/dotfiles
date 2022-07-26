/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 2000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

#include "theme.h"

#define SEP { seperator, "^b"DARK"^%s", " " }
#define WSEP { seperator, "^b"WTHR"^%s", " " }

static const struct arg args[] = {
        /*
            function,
            format,
            argument
        */

        {   // clock
            datetime,
            "^c"BG"^^b"CLOCK"^  ^c"CLOCK"^^b"BG"^ %s ",
            "%I:%M"
        },
        SEP,

        {   // calendar
            datetime,
            "^c"BG"^^b"CAL"^  ^c"CAL"^^b"BG"^ %s ",
            "%a, %b %d"
        },
        SEP,

        WSEP,
        {   // weather
            run_command,
            "^c"WTHR"^^b"BG"^ %s ",
            "cat /home/cs/.cache/weather/pyweather"
        },
        SEP,

        {   // thermals
            temp,
            "^c"BG"^^b"THRML"^ 﨏 ^c"THRML"^^b"BG"^ %s° ",
            "/sys/class/thermal/thermal_zone0/temp"
        },
        SEP,

        {   // battery
            battery_icon,
            "%s",
            NULL
        },
};
