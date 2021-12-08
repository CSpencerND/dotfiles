static const struct arg args[] = {
	/* function format          argument */

    { run_command,     "^c#af0000^ %s ",        "yticon.sh" },
	{ run_command,     "^c#444444^ %2s |",     "tail -1 ~/.config/subs" },

	{ run_command,     "^c#0087af^  %s ",        "mpdicon.sh" },
	{ run_command,     "^c#444444^  %s |",        "mpd.sh" },

	{ run_command,     "^c#8700af^ %s ",        "mailicon.sh" },
	{ run_command,     "^c#444444^ %s |",        "newmail.sh" },

	{ run_command,     "^c#d75f00^ %2s ",        "upicon.sh" },
	{ uptime,          "^c#444444^ %s |",         NULL           },
	
	{ run_command,     "^c#005fa7^ %2s ",        "cpuicon.sh" },
	{ cpu_perc,	       "^c#444444^ %s%% |",         NULL           },
	
	{ run_command,     "^c#5f8700^ %2s ",        "ramicon.sh" },
	{ ram_perc,        "^c#444444^ %s%% |",        NULL           },
	
	{ run_command,     "^c#af0000^ %2s ",        "diskicon.sh" },
	{ disk_perc,       "^c#444444^  %s%% |",         "/"            },
	
	{ run_command,     "^c#d70087^ %2s ",        "tempicon.sh" },
	{ run_command,     "^c#444444^ %2s |",     "tail -1 ~/.config/.temp" },

	{ run_command,     "^c#008700^ %2s ",        "weathericon.sh" },
	{ run_command,     "^c#444444^ %2s |",     "tail -1 ~/.config/weather" },
	
	{ run_command,     "^c#005faf^ %s ",        "pacmanicon.sh" },
	{ run_command,     "^c#444444^ %2s |",     "tail -1 ~/.config/updates" },
	

	{ run_command,     "^c#8700af^ %s ",        "volumeicon.sh" },
	{ run_command,     "^c#444444^ %s |",     "volume.sh" },
        
	{ run_command,     "^c#d70000^ %2s ",        "timeicon.sh" },
	{ datetime,        "^c#444444^ %s",         "%a %b %d - %I:%M%p" },
};
