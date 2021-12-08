static const struct arg args[] = {
	/* function format          argument */

	{ run_command,     "^c#e5c07b^  %s ",        "mpdicon.sh" },
	{ run_command,     "^c#ABB3BF^  %s |",        "mpd.sh" },

	{ run_command,     "^c#61afef^ %s ",        "mailicon.sh" },
	{ run_command,     "^c#ABB3BF^ %s |",        "newmail.sh" },

	{ run_command,     "^c#c678DD^ %2s ",        "upicon.sh" },
	{ uptime,          "^c#ABB3BF^ %s |",         NULL           },
	
	{ run_command,     "^c#56b6c2^ %2s ",        "cpuicon.sh" },
	{ cpu_perc,	    "^c#ABB3BF^ %s%% |",         NULL           },
	
	{ run_command,     "^c#98c379^ %2s ",        "ramicon.sh" },
	{ ram_perc,        "^c#ABB3BF^ %s%% |",        NULL           },
	
	{ run_command,     "^c#C678DD^ %2s ",        "diskicon.sh" },
	{ disk_perc,       "^c#ABB3BF^  %s%% |",         "/"            },
	
	{ run_command,     "^c#e06C75^ %2s ",        "tempicon.sh" },
	{ run_command,     "^c#ABB3BF^ %2s |",     "tail -1 ~/.config/.temp" },

	{ run_command,     "^c#E5C07B^ %2s ",        "weathericon.sh" },
	{ run_command,     "^c#ABB3BF^ %2s |",     "tail -1 ~/.config/weather" },
	
	{ run_command,     "^c#98C379^ %s ",        "pacmanicon.sh" },
	{ run_command,     "^c#ABB3BF^ %2s |",     "tail -1 ~/.config/updates" },
	

	{ run_command,     "^c#56B6C2^ %s ",        "volumeicon.sh" },
	{ run_command,     "^c#ABB3BF^ %s |",     "volume.sh" },
        
	{ run_command,     "^c#61AFEF^ %2s ",        "timeicon.sh" },
	{ datetime,        "^c#ABB3BF^ %s",         "%a %b %d - %I:%M%p" },
};
