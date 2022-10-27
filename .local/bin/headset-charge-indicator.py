#!/usr/bin/env python3
#
# Simple AppIndicator which uses the HeadsetControl application from 
# https://github.com/Sapd/HeadsetControl/ for retrieving charge information
# for wireless headsets and displays it as app-indicator
#
#
# Simple start this application as background process, i.e. during
# startup of the graphical desktop

import argparse
from shutil import which
from sys import argv, exit
from subprocess import check_output, CalledProcessError
from gi import require_version

require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib

try:
    require_version('AyatanaAppIndicator3', '0.1')
    from gi.repository import AyatanaAppIndicator3 as appindicator
    print("Using AyatanaAppIndicator")
except ValueError:
    require_version('AppIndicator3', '0.1')
    from gi.repository import AppIndicator3 as appindicator
    print("Using AppIndicator")

APPINDICATOR_ID = 'headset-charge-indicator'

global HEADSETCONTROL_BINARY
HEADSETCONTROL_BINARY = None

global SWITCHSOUND_BINARY
SWITCHSOUND_BINARY = None

OPTION_CAPABILITIES = '-?'
OPTION_BATTERY = '-b'
OPTION_SILENT = '-c'
OPTION_CHATMIX = '-m'
OPTION_SIDETONE = '-s'
OPTION_LED = '-l'
OPTION_INACTIVE_TIME = '-i'

global ind
ind = None
global chatmix
chatmix = None
global charge
charge = None
global prevSwitch
prevSwitch = 0


def change_icon():
    global prevSwitch
    try:
        if SWITCHSOUND_BINARY is not None:
            check_output([SWITCHSOUND_BINARY, "-1"])
            if prevSwitch == 0:
                # exit 0 means we could not find out, so set some other icon
                ind.set_icon_full("audio-card", "Audio Card")
        else:
            ind.set_icon_full("audio-headset", "Headset")
        
    except CalledProcessError as e:
        print("Response: " + str(e.returncode) + ": " + str(e))
        if e.returncode == 1:
            ind.set_icon_full("audio-speakers", "Audio Card")
            prevSwitch = 1
        elif e.returncode == 2:
            ind.set_icon_full("audio-headset", "Headset")
            prevSwitch = 2
        elif e.returncode == 3:
            ind.set_icon_full("audio-headphones", "USB")
            prevSwitch = 3
        elif e.returncode == 4:
            ind.set_icon_full("audio-input-microphone", "Speakerphone")
            prevSwitch = 4
        else:
            ind.set_icon_full("monitor", "Monitor")
            prevSwitch = 5

def fetch_capabilities():
    try:
        # ask HeadsetControl for the available capabilities for the current headset
        output = check_output([HEADSETCONTROL_BINARY, OPTION_CAPABILITIES, OPTION_SILENT])
        if args.verbose:
            print('Cap: ' + str(output, 'utf-8'))

        return output
    except CalledProcessError as e:
        print(e)
        return "all"


def change_label():
    try:
        output = check_output([HEADSETCONTROL_BINARY, OPTION_BATTERY, OPTION_SILENT])
        if args.verbose:
            print('Bat: ' + str(output, 'utf-8'))

        # -1 indicates "Battery is charging"
        if int(output) == -1:
            text = 'Chg'
        # -2 indicates "Battery is unavailable"
        elif int(output) == -2:
            text = 'Off'
        elif int(output) < 100:
            text = str(output, 'utf-8') + '%'
        else:
            text = str(output, 'utf-8') + '%'
    except CalledProcessError as e:
        print(e)
        text = 'N/A'

    ind.set_label(text, '999%')
    charge.get_child().set_text('Charge: ' + text)


def change_chatmix():
    global chatmix

    try:
        output = check_output([HEADSETCONTROL_BINARY, OPTION_CHATMIX, OPTION_SILENT])
        if args.verbose:
            print("ChatMix: " + str(output, 'utf-8'))
        chatmix.get_child().set_text('ChatMix: ' + str(output, 'utf-8'))
    except CalledProcessError as e:
        print(e)
        chatmix.get_child().set_text('ChatMix: N/A')


def set_sidetone(dummy, level):
    if args.verbose:
        print("Set sidetone to: " + str(level))
    try:
        output = check_output([HEADSETCONTROL_BINARY, OPTION_SIDETONE, str(level), OPTION_SILENT])
        if args.verbose:
            print("Result: " + str(output, 'utf-8'))
    except CalledProcessError as e:
        print(e)

    return True


def set_inactive_time(dummy, level):
    if args.verbose:
        print("Set inactive-time to: " + str(level))
    try:
        output = check_output([HEADSETCONTROL_BINARY, OPTION_INACTIVE_TIME, str(level), OPTION_SILENT])
        if args.verbose:
            print("Result: " + str(output, 'utf-8'))
    except CalledProcessError as e:
        print(e)

    return True


def set_led(dummy, level):
    if args.verbose:
        print("Set LED to: " + str(level))
    try:
        output = check_output([HEADSETCONTROL_BINARY, OPTION_LED, str(level), OPTION_SILENT])
        if args.verbose:
            print("Result: " + str(output, 'utf-8'))
    except CalledProcessError as e:
        print(e)

    return True


def switch_sound(dummy, level):
    if args.verbose:
        print("Switch sound to: " + str(level))
    try:
        output = check_output([SWITCHSOUND_BINARY, str(level)])
        if args.verbose:
            print("Result: " + str(output, 'utf-8'))
    except CalledProcessError as e:
        print("Result: " + str(e.output, 'utf-8'))
        print(e)

    # refresh UI after switching
    refresh(None)

    return True


def sidetone_menu():
    # we map 5 levels to the range of [0-128]
    # The Steelseries Arctis internally supports 0-0x12, i.e. 0-18
    #    OFF -> 0
    #    LOW -> 32
    #    MEDIUM -> 64
    #    HIGH -> 96
    #    MAX -> 128

    sidemenu = Gtk.Menu()

    off = Gtk.MenuItem(label="off")
    off.connect("activate", set_sidetone, 0)
    sidemenu.append(off)
    off.show_all()

    low = Gtk.MenuItem(label="low")
    low.connect("activate", set_sidetone, 32)
    sidemenu.append(low)
    low.show_all()

    medium = Gtk.MenuItem(label="medium")
    medium.connect("activate", set_sidetone, 64)
    sidemenu.append(medium)
    medium.show_all()

    high = Gtk.MenuItem(label="high")
    high.connect("activate", set_sidetone, 96)
    sidemenu.append(high)
    high.show_all()

    maximum = Gtk.MenuItem(label="max")
    maximum.connect("activate", set_sidetone, 128)
    sidemenu.append(maximum)
    maximum.show_all()

    return sidemenu


def inactive_time_menu():
    # the option allows to set an inactive time between 0 and 90 minutes
    # therefore we map a few different time-spans to the range of [0-90]

    inactive_time_menu = Gtk.Menu()

    off = Gtk.MenuItem(label="off")
    off.connect("activate", set_inactive_time, 0)
    inactive_time_menu.append(off)
    off.show_all()

    five = Gtk.MenuItem(label="5 min")
    five.connect("activate", set_inactive_time, 5)
    inactive_time_menu.append(five)
    five.show_all()

    fifteen = Gtk.MenuItem(label="15 min")
    fifteen.connect("activate", set_inactive_time, 15)
    inactive_time_menu.append(fifteen)
    fifteen.show_all()

    thirty = Gtk.MenuItem(label="30 min")
    thirty.connect("activate", set_inactive_time, 30)
    inactive_time_menu.append(thirty)
    thirty.show_all()

    sixty = Gtk.MenuItem(label="60 min")
    sixty.connect("activate", set_inactive_time, 60)
    inactive_time_menu.append(sixty)
    sixty.show_all()

    ninety = Gtk.MenuItem(label="90 min")
    ninety.connect("activate", set_inactive_time, 90)
    inactive_time_menu.append(ninety)
    ninety.show_all()

    return inactive_time_menu


def led_menu():
    ledmenu = Gtk.Menu()

    off = Gtk.MenuItem(label="off")
    off.connect("activate", set_led, 0)
    ledmenu.append(off)
    off.show_all()

    on = Gtk.MenuItem(label="on")
    on.connect("activate", set_led, 1)
    ledmenu.append(on)
    on.show_all()

    return ledmenu


def switch_menu():
    switchmenu = Gtk.Menu()

    laptop = Gtk.MenuItem(label="Soundcard")
    laptop.connect("activate", switch_sound, 1)
    switchmenu.append(laptop)
    laptop.show_all()

    headset = Gtk.MenuItem(label="Headset")
    headset.connect("activate", switch_sound, 2)
    switchmenu.append(headset)
    headset.show_all()

    usb = Gtk.MenuItem(label="USB Headset")
    usb.connect("activate", switch_sound, 3)
    switchmenu.append(usb)
    usb.show_all()

    chat = Gtk.MenuItem(label="Chat Device")
    chat.connect("activate", switch_sound, 4)
    switchmenu.append(chat)
    chat.show_all()

    monitor = Gtk.MenuItem(label="Monintor")
    monitor.connect("activate", switch_sound, 5)
    switchmenu.append(monitor)
    monitor.show_all()

    return switchmenu


def refresh(dummy):
    cap = fetch_capabilities()

    change_icon()
    if "all" == cap or b'b' in cap:
        change_label()
    if "all" == cap or b'm' in cap:
        change_chatmix()
    
    # return True to keep the timer running
    return True


def quit_app(source):
    Gtk.main_quit()


def locate_headsetcontrol_binary(binary_location):
    location = which(binary_location)

    if location is None:
        print(f"Unable to locate headsetcontrol binary at: {binary_location}")
    elif args.verbose:
        print(f"Found headsetcontrol binary at: {location}")

    return location


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="""
    Simple AppIndicator which uses the HeadsetControl application from 
    https://github.com/Sapd/HeadsetControl/ for retrieving charge information
    for wireless headsets and displays it as app-indicator
    
    The application has two optional commandline arguments, one for the location of the
    HeadsetControl binary and one for a command to switch between Laptop, Headset
    and other devices.
    """, formatter_class=argparse.RawTextHelpFormatter)
    parser.add_argument('--headsetcontrol-binary', metavar='<path to headsetcontrol binary>', type=str,
                        help='Optional path to headsetcontrol binary', required=False, default='headsetcontrol',
                        dest='headsetcontrolbinary')
    parser.add_argument('--switch-command', metavar='<device switch command>', type=str,
                        help='Optional command to switch between Laptop, Headset and other devices', required=False, default=None,
                        dest='switch_command')
    parser.add_argument("--verbose", help="Increase output verbosity", action="store_true")
    args = parser.parse_args()

    HEADSETCONTROL_BINARY = locate_headsetcontrol_binary(args.headsetcontrolbinary)

    if not HEADSETCONTROL_BINARY:
        parser.print_usage()
        exit(2);

    if args.switch_command is not None:
        SWITCHSOUND_BINARY = args.switch_command

    ind = appindicator.Indicator.new(
        APPINDICATOR_ID,
        "audio-headset",
        appindicator.IndicatorCategory.HARDWARE)
    ind.set_status(appindicator.IndicatorStatus.ACTIVE)
    ind.set_label("-1%", '999%')

    # create a menu with an Exit-item
    menu = Gtk.Menu()

    menu_items = Gtk.MenuItem(label="Refresh")
    menu.append(menu_items)
    menu_items.connect("activate", refresh)
    menu_items.show_all()

    menu_items = Gtk.MenuItem(label="Charge: -1")
    menu.append(menu_items)
    menu_items.show_all()
    charge = menu_items

    menu_items = Gtk.MenuItem(label="Chat: -1")
    menu.append(menu_items)
    menu_items.show_all()
    chatmix = menu_items

    menu_items = Gtk.MenuItem(label="Sidetone")
    menu.append(menu_items)
    menu_items.show_all()
    menu_items.set_submenu(sidetone_menu())

    menu_items = Gtk.MenuItem(label="LED")
    menu.append(menu_items)
    menu_items.show_all()
    menu_items.set_submenu(led_menu())

    menu_items = Gtk.MenuItem(label="Inactive time")
    menu.append(menu_items)
    menu_items.show_all()
    menu_items.set_submenu(inactive_time_menu())

    if args.switch_command is not None:
        menu_items = Gtk.MenuItem(label="Switch")
        menu.append(menu_items)
        menu_items.show_all()
        menu_items.set_submenu(switch_menu())

    menu_items = Gtk.MenuItem(label="Exit")
    menu.append(menu_items)
    menu_items.connect("activate", quit_app)
    menu_items.show_all()

    ind.set_menu(menu)

    # update information every 60 seconds
    GLib.timeout_add(60000, refresh, None)

    # refresh values right away
    refresh(None)

    Gtk.main()
