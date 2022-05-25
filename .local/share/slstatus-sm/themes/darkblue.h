static const struct arg args[] = {
	/* function format          argument */

	{ run_command,     "^c#60b2a8^  %s ",        "mpdicon.sh" },
	{ run_command,     "^c#9ea6ca^  %s |",        "mpd.sh" }, 

	{ run_command,     "^c#6686cc^ %s ",        "mailicon.sh" },
	{ run_command,     "^c#9ea6ca^ %s |",        "newmail.sh" },

	{ run_command,     "^c#9a7fcc^ %2s ",        "upicon.sh" },
	{ uptime,          "^c#9ea6ca^ %s |",         NULL           }, 
	
	{ run_command,     "^c#68aad2^ %2s ",        "cpuicon.sh" },
	{ cpu_perc,	       "^c#9ea6ca^ %s%% |",         NULL           },
	
	{ run_command,     "^c#ca6278^ %2s ",        "ramicon.sh" },
	{ ram_perc,        "^c#9ea6ca^ %s%% |",        NULL           },
	
	{ run_command,     "^c#60b2a8^ %2s ",        "diskicon.sh" },
	{ disk_perc,       "^c#9ea6ca^  %s%% |",         "/"            },
	
	{ run_command,     "^c#b79059^ %2s ",        "tempicon.sh" },
	{ run_command,     "^c#9ea6ca^ %2s |",     "tail -1 ~/.config/.temp" }, 

	{ run_command,     "^c#6686cc^ %2s ",        "weathericon.sh" },
	{ run_command,     "^c#9ea6ca^ %2s |",     "tail -1 ~/.config/weather" }, 
	
	{ run_command,     "^c#9a7fcc^ %s ",        "pacmanicon.sh" },
	{ run_command,     "^c#9ea6ca^ %2s |",     "tail -1 ~/.config/updates" },
	
	{ run_command,     "^c#68aad2^ %s ",        "volumeicon.sh" },
	{ run_command,     "^c#9ea6ca^ %s |",     "volume.sh" }, 
        
	{ run_command,     "^c#ca6278^ %2s ",        "timeicon.sh" },
	{ datetime,        "^c#9ea6ca^ %s",         "%a %b %d - %I:%M%p" },
};
