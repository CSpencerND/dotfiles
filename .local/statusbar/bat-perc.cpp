#include <fstream>
#include <iostream>
#include <string>

using namespace std;

int main()
{
    // string perc;
    int perc;
    string icon = "  ";
    string state;

    // get current battery level
    fstream pf("/sys/class/power_supply/BAT0/capacity", ios::in);
    pf >> perc;
    pf.close();

    // get charging status
    fstream sf("/sys/class/power_supply/BAT0/status", ios::in);
    sf >> state;
    sf.close();

    // determine icon based on battery level and status
    if (state == "Unknown")
    {
        icon = " ";
    }
    else if (state == "Charging")
    {
        icon = "  ";
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
    cout << icon << perc << "%  " << endl;

    return 0;
}
