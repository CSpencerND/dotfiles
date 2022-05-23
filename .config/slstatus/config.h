/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 2000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

// static const char darkest[8]  = "#191A21";
// static const char darker[8]   = "#21222c";
// static const char dark[8]     = "#282a36";
// static const char grey[8]     = "#383c4a";
// static const char light[8]    = "#f8f8f2";
// static const char magenta[8]  = "#ff79c6";
// static const char purple[8]   = "#bd93f9";
// static const char blue[8]     = "#6272a4";
// static const char cyan[8]     = "#8be9fd";
// static const char green[8]    = "#50fa7b";
// static const char yellow[8]   = "#f1fa8c";
// static const char orange[8]   = "#ffb86c";
// static const char red[8]      = "#ff5555";

// #define darker             "#161320"
#define dark               "#1e1e2e"
#define grey               "#383c4a"
#define light              "#d9e0ee"
#define magenta            "#e8a2af"
#define purple             "#ddb6f2"
#define blue               "#96cdfb"
#define cyan               "#89dceb"
// #define green              "#abe9b3"
// #define yellow             "#fae3b0"
// #define orange             "#f8bd96"
#define red                "#f28fad"

static const struct arg args[] = {
        /* function       format                      argument */

        // { datetime,       "^c#383c4a^^b#bd93f9^  ^c#bd93f9^^b#383c4a^ %s ",       "%I:%M" },
        // { seperator,      "^b#282a36^%s",        " " },

        // { datetime,       "^c#383c4a^^b#8be9fd^  ^c#8be9fd^^b#383c4a^ %s ",      "%a, %b %d" },
        // { seperator,      "^b#282a36^%s",        "" },

        // { run_command,    "^c#f1fa8c^ ^b#383c4a^ %s ",        "cat /home/cs/.cache/weather/pyweather" },


        { datetime,     "^c#383c4a^^b#bd93f9^  ^c#bd93f9^^b#383c4a^ %s ",            "%I:%M" },
        // { seperator,    "^b#21222c^%s",        " " },
        { seperator,    "^b#282a36^%s",        " " },

        { datetime,     "^c#383c4a^^b#8be9fd^  ^c#8be9fd^^b#383c4a^ %s ",        "%a, %b %d" },
        // { seperator,    "^b#21222c^%s",        " " },
        { seperator,    "^b#282a36^%s",        " " },

        // { run_command,  "^c#282a36^^b#f1fa8c^ %s ",   "cat /home/cs/.cache/weather/pyweather" },
        { run_command,  "^c#f1fa8c^^b#383c4a^ %s ",   "cat /home/cs/.cache/weather/pyweather" },
        // { seperator,    "^b#21222c^%s",        " " },
        { seperator,    "^b#282a36^%s",        " " },

        { run_command,  "^c#383c4a^^b#bd93f9^  ^c#bd93f9^^b#383c4a^ %s ", "cat /home/cs/.cache/pac-updates-count" },
        // { seperator,    "^b#21222c^%s",        " " },
        { seperator,    "^b#282a36^%s",        " " },

        // { ram_perc,     "^c#383c4a^^b#8be9fd^  ^c#8be9fd^^b#383c4a^ %s%% ",    NULL },
        // { seperator,    "^b#21222c^%s",        " " },
        // { seperator,    "^b#282a36^%s",        " " },

        { temp,         "^c#383c4a^^b#f1fa8c^ 﨏 ^c#f1fa8c^^b#383c4a^ %s° ",     "/sys/class/thermal/thermal_zone1/temp" },
        // { temp,         "^c#282a36^^b#f1fa8c^ 﨏 ^c#f1fa8c^^b#282a36^ %s° ",     "/sys/class/thermal/thermal_zone1/temp" },
        // { seperator,    "^b#21222c^%s",        " " },
        { seperator,    "^b#282a36^%s",        " " },

        { run_command,  "^c#383c4a^^b#bd93f9^  ^c#bd93f9^^b#383c4a^ %s ",   "cat /home/cs/.cache/headset_percent" },
        // { seperator,    "^b#21222c^%s",        " " },
        { seperator,    "^b#282a36^%s",        " " },

        // { battery_icon, "^c#8be9fd^^b#282a36^ %s", NULL },
        { battery_icon, "%s", NULL },
};
