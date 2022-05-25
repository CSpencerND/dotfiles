static const struct arg args[] = {
	/* function format          argument */

	{ run_command,     "^c#d79921^  %s ",        "mpdicon.sh" },
	{ run_command,     "^c#ebdbb2^  %s |",        "mpd.sh" }, 

	{ run_command,     "^c#83a598^ %s ",        "mailicon.sh" },
	{ run_command,     "^c#ebdbb2^ %s |",        "newmail.sh" },

	{ run_command,     "^c#d3869b^ %2s ",        "upicon.sh" },
	{ uptime,          "^c#ebdbb2^ %s |",         NULL           }, 
	
	{ run_command,     "^c#83a598^ %2s ",        "cpuicon.sh" },
	{ cpu_perc,	       "^c#ebdbb2^ %s%% |",         NULL           },
	
	{ run_command,     "^c#b8bb26^ %2s ",        "ramicon.sh" },
	{ ram_perc,        "^c#ebdbb2^ %s%% |",        NULL           },
	
	{ run_command,     "^c#b16286^ %2s ",        "diskicon.sh" },
	{ disk_perc,       "^c#ebdbb2^  %s%% |",         "/"            },
	
	{ run_command,     "^c#cc241d^ %2s ",        "tempicon.sh" },
	{ run_command,     "^c#ebdbb2^ %2s |",     "tail -1 ~/.config/.temp" }, 

	{ run_command,     "^c#689d6a^ %2s ",        "weathericon.sh" },
	{ run_command,     "^c#ebdbb2^ %2s |",     "tail -1 ~/.config/weather" }, 
	
	{ run_command,     "^c#98971a^ %s ",        "pacmanicon.sh" },
	{ run_command,     "^c#ebdbb2^ %2s |",     "tail -1 ~/.config/updates" },
	

	{ run_command,     "^c#458588^ %s ",        "volumeicon.sh" },
	{ run_command,     "^c#ebdbb2^ %s |",     "volume.sh" }, 
        
	{ run_command,     "^c#fabd2f^ %2s ",        "timeicon.sh" },
	{ datetime,        "^c#ebdbb2^ %s",         "%a %b %d - %I:%M%p" },
};
