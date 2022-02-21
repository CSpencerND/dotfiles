#include <stdio.h>
#include <string.h>

int main()
{
    int perc;
    char state[12];
    char *icon = "  ";

    // get current battery level
    FILE *pf = fopen("/sys/class/power_supply/BAT0/capacity", "r");
    fscanf(pf, "%d", &perc);
    fclose(pf);

    // get charging status
    FILE *sf = fopen("/sys/class/power_supply/BAT0/status", "r");
    fscanf(sf, "%s", state);
    fclose(sf);

    // determine icon based on battery level and status
    if (strcmp(state, "Unknown") == 0)
    {
        icon = " ";
    }
    else if (!strcmp(state, "Charging"))
    {
        icon = " ";
    }

    else
    {
        if (perc > 10 && perc < 40)
        {
            icon = "  ";
        }
        else if (perc > 39 && perc < 60)
        {
            icon = "  ";
        }
        else if (perc > 59 && perc < 90)
        {
            icon = "  ";
        }
        else if (perc > 89)
        {
            icon = "  ";
        }
    }

    // output the data
    printf("%s%d%%  ", icon, perc);

    return 0;
}
