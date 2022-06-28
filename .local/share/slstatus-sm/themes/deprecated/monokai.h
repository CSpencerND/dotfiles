static const struct arg args[] = {
	/* function format          argument */

	{ run_command,     "^c#FFD866^  %s ",        "mpdicon.sh" },
	{ run_command,     "^c#f8f8f2^  %s |",        "mpd.sh" }, 

	{ run_command,     "^c#78DCE8^ %s ",        "mailicon.sh" },
	{ run_command,     "^c#f8f8f2^ %s |",        "newmail.sh" },

	{ run_command,     "^c#FF6188^ %2s ",        "upicon.sh" },
	{ uptime,          "^c#f8f8f2^ %s |",         NULL           }, 
	
	{ run_command,     "^c#FC9867^ %2s ",        "cpuicon.sh" },
	{ cpu_perc,	       "^c#f8f8f2^ %s%% |",         NULL           },
	
	{ run_command,     "^c#AB9DF2^ %2s ",        "ramicon.sh" },
	{ ram_perc,        "^c#f8f8f2^ %s%% |",        NULL           },
	
	{ run_command,     "^c#78DCE3^ %2s ",        "diskicon.sh" },
	{ disk_perc,       "^c#f8f8f2^  %s%% |",         "/"            },
	
	{ run_command,     "^c#FD971F^ %2s ",        "tempicon.sh" },
	{ run_command,     "^c#f8f8f2^ %2s |",     "tail -1 ~/.config/.temp" }, 

	{ run_command,     "^c#A6E22E^ %2s ",        "weathericon.sh" },
	{ run_command,     "^c#f8f8f2^ %2s |",     "tail -1 ~/.config/weather" }, 
	
	{ run_command,     "^c#E6DB74^ %s ",        "pacmanicon.sh" },
	{ run_command,     "^c#f8f8f2^ %2s |",     "tail -1 ~/.config/updates" },
	

	{ run_command,     "^c#66D9EF^ %s ",        "volumeicon.sh" },
	{ run_command,     "^c#f8f8f2^ %s |",     "volume.sh" }, 
        
	{ run_command,     "^c#FC9867^ %2s ",        "timeicon.sh" },
	{ datetime,        "^c#f8f8f2^ %s",         "%a %b %d - %I:%M%p" },
};
