/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 2000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

// #include "./themes/dracula.h" /* Importing theme */
static const struct arg args[] = {
	/* function     format                      argument */

	// { datetime,     " ^c#bd93f9^    %s",      "%H:%M" },
	{ datetime,     " ^c#bd93f9^   %s",      "%l:%M" },
        { seperator,    "^c#646682^ %s",        " | " },

	{ datetime,     "^c#8be9fd^    %s",      "%a, %b %d" },
        { seperator,    "^c#646672^ %s",        " | " },

	// { weather,      "^c#f1fa8c^ %s",        NULL },
        // { seperator,    "^c#646672^ %s",        "|" },

	{ run_command,  "^c#f1fa8c^ %s",        "cat /home/cs/.cache/weather/pyweather" },
        { seperator,    "^c#646672^ %s",        " | " },

	// { cpu_perc,     "^c#bd93f9^    %s%%",    NULL },
        { run_command,  "^c#bd93f9^    %s",    "cat /home/cs/.cache/pac-updates-count" },
        { seperator,    "^c#646672^ %s",        " | " },

	{ ram_perc,     "^c#8be9fd^    %s%%",    NULL },
        { seperator,    "^c#646672^ %s",        " | " },

	{ temp,         "^c#f1fa8c^   %s°",     "/sys/class/thermal/thermal_zone1/temp" },
        { seperator,    "^c#646672^ %s",        " | " },

	// { run_command,  "^c#bd93f9^  %s  ",   "cat /home/cs/.cache/headset_percent" },
	{ run_command,  "^c#bd93f9^   %s",   "cat /home/cs/.cache/headset_percent" },
        { seperator,    "^c#646672^ %s",        " | " },

        // { run_command, "^c#8be9fd^ %s%", "/home/cs/.local/statusbar/bat-perc.o"},
        { battery_icon, "^c#8be9fd^ %s", NULL },
        // { battery_perc, "^c#8be9fd^  %s%%", "BAT0" },
        // { seperator,    "%s",                  "  " },

	// { datetime,             " ⏱ %s ",               "%a %b %d %R" },

	// { run_command,     "^c#8be9fd^  %s ",        "mpdicon.sh" },
	// { run_command,     "^c#f8f8f2^  %s |",        "mpd.sh" },

	// { run_command,     "^c#50fa7b^ %s ",        "mailicon.sh" },
	// { run_command,     "^c#f8f8f2^ %s |",        "newmail.sh" },

	// { run_command,     "^c#ff79c6^ %2s ",        "upicon.sh" },
	// { uptime,          "^c#f8f8f2^ %s |",         NULL           },
	//
	// { run_command,     "^c#ffb86c^ %2s ",        "cpuicon.sh" },
	// { cpu_perc,	       "^c#f8f8f2^ %s%% |",         NULL           },
	//
	// { run_command,     "^c#f1fa8c^ %2s ",        "ramicon.sh" },
	// { ram_perc,        "^c#f8f8f2^ %s%% |",        NULL           },
	//
	// { run_command,     "^c#ff5555^ %2s ",        "diskicon.sh" },
	// { disk_perc,       "^c#f8f8f2^  %s%% |",         "/"            },
	//
	// { run_command,     "^c#ff79c6^ %2s ",        "tempicon.sh" },
	// { run_command,     "^c#f8f8f2^ %2s |",     "tail -1 ~/.config/.temp" },

	// { run_command,     "^c#59fa7b^ %2s ",        "weathericon.sh" },
	// { run_command,     "^c#f8f8f2^ %2s |",     "tail -1 ~/.config/weather" },
	//
	// { run_command,     "^c#bd93f9^ %s ",        "pacmanicon.sh" },
	// { run_command,     "^c#f8f8f2^ %2s |",     "tail -1 ~/.config/updates" },
	//

	// { run_command,     "^c#8be9fd^ %s ",        "volumeicon.sh" },
	// { run_command,     "^c#f8f8f2^ %s |",     "volume.sh" },

	// { run_command,     "^c#f1fa8c^ %2s ",        "timeicon.sh" },
	// { datetime,        "^c#f8f8f2^ %s",         "%a %b %d - %I:%M%p" },
};

/*
 * function            description                     argument (example)
 *
 * battery_perc        battery percentage              battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * battery_state       battery charging state          battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * battery_remaining   battery remaining HH:MM         battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * cpu_perc            cpu usage in percent            NULL
 * cpu_freq            cpu frequency in MHz            NULL
 * datetime            date and time                   format string (%F %T)
 * disk_free           free disk space in GB           mountpoint path (/)
 * disk_perc           disk usage in percent           mountpoint path (/)
 * disk_total          total disk space in GB          mountpoint path (/")
 * disk_used           used disk space in GB           mountpoint path (/)
 * entropy             available entropy               NULL
 * gid                 GID of current user             NULL
 * hostname            hostname                        NULL
 * ipv4                IPv4 address                    interface name (eth0)
 * ipv6                IPv6 address                    interface name (eth0)
 * kernel_release      `uname -r`                      NULL
 * keyboard_indicators caps/num lock indicators        format string (c?n?)
 *                                                     see keyboard_indicators.c
 * keymap              layout (variant) of current     NULL
 *                     keymap
 * load_avg            load average                    NULL
 * netspeed_rx         receive network speed           interface name (wlan0)
 * netspeed_tx         transfer network speed          interface name (wlan0)
 * num_files           number of files in a directory  path
 *                                                     (/home/foo/Inbox/cur)
 * ram_free            free memory in GB               NULL
 * ram_perc            memory usage in percent         NULL
 * ram_total           total memory size in GB         NULL
 * ram_used            used memory in GB               NULL
 * run_command         custom shell command            command (echo foo)
 * swap_free           free swap in GB                 NULL
 * swap_perc           swap usage in percent           NULL
 * swap_total          total swap size in GB           NULL
 * swap_used           used swap in GB                 NULL
 * temp                temperature in degree celsius   sensor file
 *                                                     (/sys/class/thermal/...)
 *                                                     NULL on OpenBSD
 *                                                     thermal zone on FreeBSD
 *                                                     (tz0, tz1, etc.)
 * uid                 UID of current user             NULL
 * uptime              system uptime                   NULL
 * username            username of current user        NULL
 * vol_perc            OSS/ALSA volume in percent      mixer file (/dev/mixer)
 * wifi_perc           WiFi signal in percent          interface name (wlan0)
 * wifi_essid          WiFi ESSID                      interface name (wlan0)
 */
