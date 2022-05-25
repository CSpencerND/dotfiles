static const struct arg args[] = {
	/* function format          argument */

	{ run_command,     "^c#d183e8^  %s ",        "mpdicon.sh" },
	{ run_command,     "^c#c6c6c6^  %s |",        "mpd.sh" },

	{ run_command,     "^c#36c692^ %s ",        "mailicon.sh" },
	{ run_command,     "^c#c6c6c6^ %s |",        "newmail.sh" },

	{ run_command,     "^c#ae81ff^ %2s ",        "upicon.sh" },
	{ uptime,          "^c#c6c6c6^ %s |",         NULL           },
	
	{ run_command,     "^c#85dc85^ %2s ",        "cpuicon.sh" },
	{ cpu_perc,	    "^c#c6c6c6^ %s%% |",         NULL           },
	
	{ run_command,     "^c#e3c78a^ %2s ",        "ramicon.sh" },
	{ ram_perc,        "^c#c6c6c6^ %s%% |",        NULL           },
	
	{ run_command,     "^c#79dac8^ %2s ",        "diskicon.sh" },
	{ disk_perc,       "^c#c6c6c6^  %s%% |",         "/"            },
	
	{ run_command,     "^c#80a0ff^ %2s ",        "tempicon.sh" },
	{ run_command,     "^c#c6c6c6^ %2s |",     "tail -1 ~/.config/.temp" },

	{ run_command,     "^c#bfbf97^ %2s ",        "weathericon.sh" },
	{ run_command,     "^c#c6c6c6^ %2s |",     "tail -1 ~/.config/weather" },
	
	{ run_command,     "^c#74b3ff^ %s ",        "pacmanicon.sh" },
	{ run_command,     "^c#c6c6c6^ %2s |",     "tail -1 ~/.config/updates" },
	

	{ run_command,     "^c#ff5454^ %s ",        "volumeicon.sh" },
	{ run_command,     "^c#c6c6c6^ %s |",     "volume.sh" },
        
	{ run_command,     "^c#ff5189^ %2s ",        "timeicon.sh" },
	{ datetime,        "^c#c6c6c6^ %s",         "%a %b %d - %I:%M%p" },
};
