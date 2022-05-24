#define darker  "#21222c"
#define dark    "#282a36"
#define grey    "#383c4a"
// #define lgrey   "#575268"
#define light   "#f8f8f2"
#define magenta "#ff79c6"
#define purple  "#bd93f9"
#define blue    "#6272a4"
#define cyan    "#8be9fd"
#define green   "#50fa7b"
#define yellow  "#f1fa8c"
#define orange  "#ffb86c"
#define red     "#ff5555"

#define SEP { seperator, "^b"dark"^%s", " " }

static const struct arg args[] = {
        /*
            function,
            format,
            argument
        */

        {
            datetime,
            "^c"grey"^^b"purple"^  ^c"purple"^^b"grey"^ %s ",
            "%I:%M"
        },
        SEP,
        {
            datetime,
            "^c"grey"^^b"cyan"^  ^c"cyan"^^b"grey"^ %s ",
            "%a, %b %d"
        },
        SEP,
        {
            run_command,
            "^c"yellow"^^b"grey"^ %s ",
            "cat /home/cs/.cache/weather/pyweather"
        },
        SEP,
        {
            run_command,
            "^c"grey"^^b"purple"^  ^c"purple"^^b"grey"^ %s ",
            "cat /home/cs/.cache/pac-updates-count"
        },
        SEP,
        {
            temp,
            "^c"grey"^^b"yellow"^ 﨏 ^c"yellow"^^b"grey"^ %s° ",
            "/sys/class/thermal/thermal_zone1/temp"
        },
        SEP,
        {
            run_command,
            "^c"grey"^^b"purple"^  ^c"purple"^^b"grey"^ %s ",
            "cat /home/cs/.cache/headset_percent"
        },
        SEP,
        {
            battery_icon,
            "%s",
            NULL
        },
};
