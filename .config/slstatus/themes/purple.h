static const struct arg args[] = {
	/* function format          argument */
     

	{ run_command,     "^c#9565F1^ %s ",        "mpdicon.sh" },
	{ run_command,     "^c#ffffff^ %s |",        "mpd.sh" }, 

	{ run_command,     "^c#ffffff^ %s ",        "mailicon.sh" },
	{ run_command,     "^c#ffffff^ %s |",        "newmail.sh" },

	{ run_command,     "^c#9565F1^ %2s ",        "upicon.sh" },
	{ uptime,          "^c#ffffff^ %s |",         NULL           }, 
	
	{ run_command,     "^c#ffffff^ %2s ",        "cpuicon.sh" },
	{ cpu_perc,	   "^c#ffffff^ %s%% |",         NULL           },
	
	{ run_command,     "^c#9565F1^ %2s ",        "ramicon.sh" },
	{ ram_perc,        "^c#ffffff^ %s%% |",        NULL           },
	
	{ run_command,     "^c#ffffff^ %2s ",        "diskicon.sh" },
	{ disk_perc,       "^c#ffffff^  %s%% |",         "/"            },
	
	{ run_command,     "^c#9565F1^ %2s ",        "tempicon.sh" },
	{ run_command,     "^c#ffffff^ %2s |",     "tail -1 ~/.config/.temp" }, 

	{ run_command,     "^c#ffffff^ %2s ",        "weathericon.sh" },
	{ run_command,     "^c#ffffff^ %2s |",     "tail -1 ~/.config/weather" }, 
	
	{ run_command,     "^c#9565F1^ %s ",        "pacmanicon.sh" },
	{ run_command,     "^c#ffffff^ %2s |",     "tail -1 ~/.config/updates" },
	

	{ run_command,     "^c#ffffff^ %s ",        "volumeicon.sh" },
	{ run_command,     "^c#ffffff^ %s |",     "volume.sh" }, 
        
	{ run_command,     "^c#9565F1^ %2s ",        "timeicon.sh" },
	{ datetime,        "^c#ffffff^ %s",         "%a %b %d - %I:%M%p" },
};
