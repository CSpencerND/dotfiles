/* my custom battery module */
#include <stdio.h>
#include <string.h>

#include "../util.h"
#include "../theme.h"

const char *
battery_icon(void)
{
    int perc;
    char state[12];
    char icon[8];

    // get current battery level
    FILE *pf = fopen("/sys/class/power_supply/BAT0/capacity", "r");
    fscanf(pf, "%d", &perc);
    fclose(pf);

    // get charging status
    FILE *sf = fopen("/sys/class/power_supply/BAT0/status", "r");
    fscanf(sf, "%s", state);
    fclose(sf);

    // determine icon based on battery level and status
    if (!strcmp(state, "Unknown"))
    {
        strcpy(icon, " ");
    }
    else if (!strcmp(state, "Charging"))
    {
        strcpy(icon, " ");
    }
    else if (!strcmp(state, "Full"))
    {
        strcpy(icon, " ");
    }
    else if (!strcmp(state, "Discharging"))
    {
        if (perc < 12)
        {
            strcpy(icon, "  ");
        }
        else if (perc > 12 && perc < 37)
        {
            strcpy(icon, "  ");
        }
        else if (perc > 37 && perc < 63)
        {
            strcpy(icon, "  ");
        }
        else if (perc > 63 && perc < 88)
        {
            strcpy(icon, "  ");
        }
        else if (perc > 88)
        {
            strcpy(icon, "  ");
        }
    }

    // output the data
    return bprintf("^c%s^^b%s^ %s^c%s^^b%s^ %d%% ", GREY, BAT, icon, BAT, GREY, perc);
}
