# {{{       IMPORTS        ---

import os
import re
import socket
import subprocess

from libqtile.config import (
    Key, Screen, Group, Drag, Click, Rule, Match, ScratchPad, DropDown
)
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook, extension
from libqtile.widget import Spacer
#import arcobattery

# ---       IMPORTS        }}}
##############################
# {{{     VARS/FUNCS       ---

#mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')
qtile_home = os.path.expanduser('~/.config/qtile')

# Move Windows To Groups By Direction
@lazy.function
def window_to_prev_group(qtile):
    if qtile.current_window is not None:
        i = qtile.groups.index(qtile.current_group)
        qtile.current_window.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.current_window is not None:
        i = qtile.groups.index(qtile.current_group)
        qtile.current_window.togroup(qtile.groups[i + 1].name)

# Bring floating windows to front
@lazy.function
def float_to_front(qtile):
    logging.info("bring floating windows to front")
    for group in qtile.groups:
        for window in group.windows:
            if window.floating:
                window.cmd_bring_to_front()

# Group Definitions
# groups = []
groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_layouts = ["monadtall" for i in group_names]

for i in range(len(group_names)):
    groups.append\
    (
        Group
        (
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i]
        )
    )

groups.append(ScratchPad("scratchpad", dropdowns=\
        [
            DropDown("term", "alacritty", height=0.5, width=0.5, x=0.25)
        ]
    )
)

# Theme
class dracula:
    black =   '#14151b'
    bg =      '#282a36'
    arcobg =  '#383c4a'
    bgl =     '#44475a'
    grey =    '#4d4d4d'
    fga =     '#bfbfbf'
    fg =      '#f8f8f2'
    magenta = '#ff79c6'
    purple =  '#bd93f9'
    blurple = '#4d5b86'
    arcoblue= '#6790eb'
    cyan =    '#8be9fd'
    green =   '#50fa7b'
    yellow =  '#f1fa8c'
    orange =  '#ffb86c'
    red =     '#ff5555'

dracula_highlight = [dracula.blurple, dracula.purple]

# ---     VARS/FUNCS       }}}
##############################
# {{{     KEYBINDINGS      ---

keys = [
    # Resize
    Key
    (
        [mod, "control"], "l",
        lazy.layout.grow_main().when(layout='monadtall'),
        lazy.layout.increase_ratio().when(layout='tile'),
        lazy.layout.grow_right().when(layout='columns'),
        lazy.layout.delete().when(layout='matrix'),
    ),
    Key
    (
        [mod, "control"], "Right",
        lazy.layout.grow_main().when(layout='monadtall'),
        lazy.layout.increase_ratio().when(layout='tile'),
        lazy.layout.grow_right().when(layout='columns'),
        lazy.layout.delete().when(layout='matrix'),
    ),
    Key
    (
        [mod, "control"], "h",
        lazy.layout.shrink_main().when(layout='monadtall'),
        lazy.layout.decrease_ratio().when(layout='tile'),
        lazy.layout.grow_left().when(layout='columns'),
        lazy.layout.add().when(layout='matrix'),
    ),
    Key
    (
        [mod, "control"], "Left",
        lazy.layout.shrink_main().when(layout='monadtall'),
        lazy.layout.decrease_ratio().when(layout='tile'),
        lazy.layout.grow_left().when(layout='columns'),
        lazy.layout.add().when(layout='matrix'),
    ),
    Key
    (
        [mod, "control"], "k",
        lazy.layout.grow_main().when(layout='monadtall'),
        lazy.layout.grow_up().when(layout='columns'),
        lazy.layout.decrease_nmaster().when(layout='tile'),
    ),
    Key
    (
        [mod, "control"], "Up",
        lazy.layout.grow_main().when(layout='monadtall'),
        lazy.layout.grow_up().when(layout='columns'),
        lazy.layout.decrease_nmaster().when(layout='tile'),
    ),
    Key
    (
        [mod, "control"], "j",
        lazy.layout.shrink_main().when(layout='monadtall'),
        lazy.layout.grow_down().when(layout='columns'),
        lazy.layout.increase_nmaster().when(layout='tile'),
    ),
    Key
    (
        [mod, "control"], "Down",
        lazy.layout.shrink_main().when(layout='monadtall'),
        lazy.layout.grow_down().when(layout='columns'),
        lazy.layout.increase_nmaster().when(layout='tile'),
    ),


    # Change Focus
    Key
    (
        [mod], "k",
        lazy.layout.up()
    ),
    Key
    (
        [mod], "j",
        lazy.layout.down()
    ),
    Key
    (
        [mod], "h",
        lazy.layout.left()
    ),
    Key
    (
        [mod], "l",
        lazy.layout.right()
    ),
    Key
    (
        [mod], 'z',
        lazy.next_urgent()
    ),


    # Move Windows Around The Stack
    Key
    (
        [mod, "shift"], "h",
        lazy.layout.shuffle_left()
    ),
    Key
    (
        [mod, "shift"], "j",
        lazy.layout.shuffle_down()
    ),
    Key
    (
        [mod, "shift"], "k",
        lazy.layout.shuffle_up()
    ),
    Key
    (
        [mod, "shift"], "l",
        lazy.layout.shuffle_right()
    ),

    Key
    (
        [mod, "mod1"], "h",
        lazy.layout.swap_left()
    ),
    Key
    (
        [mod, "mod1"], "j",
        lazy.layout.swap_left()
    ),
    Key
    (
        [mod, "mod1"], "k",
        lazy.layout.swap_right()
    ),
    Key
    (
        [mod, "mod1"], "l",
        lazy.layout.swap_right()
    ),


    # Switch Groups by direction
    Key
    (
        [mod], "Tab",
        lazy.screen.next_group()
    ),
    Key
    (
        [mod, "shift"], "Tab",
        lazy.screen.prev_group()
    ),
    Key
    (
        [mod], "i",
        lazy.screen.next_group()
    ),
    Key
    (
        [mod], "u",
        lazy.screen.prev_group()
    ),
    Key
    (
        [mod], "Right",
        lazy.screen.next_group()
    ),
    Key
    (
        [mod], "Left",
        lazy.screen.prev_group()
    ),
    Key
    (
        [mod], "semicolon",
        lazy.screen.toggle_group()),
    Key
    (
        [mod, "shift"], "i",
        window_to_next_group
    ),
    Key
    (
        [mod, "shift"], "u",
        window_to_prev_group
    ),
    Key
    (
        [mod, "control"], "i",
        window_to_next_group,
        lazy.screen.next_group()
    ),
    Key
    (
        [mod, "control"], "u",
        window_to_prev_group,
        lazy.screen.prev_group()
    ),


    # Window Functions
    Key
    (
        [mod], "c",
        lazy.window.kill()
    ),
    Key
    (
        [mod], "m",
        lazy.window.toggle_minimize()
    ),
    Key
    (
        [mod, "control"], "m",
        lazy.group.unminimize_all()
    ),
    Key
    (
        [mod, "shift"], "m",
        lazy.window.toggle_maximize()
    ),
    Key
    (
        [mod, "mod1"], "m",
        lazy.window.toggle_fullscreen()
    ),
    Key
    (
        [mod], "f",
        lazy.window.toggle_floating()
    ),
    Key
    (
        [mod, "shift"], "f",
        float_to_front
    ),

    # Layout Functions
    Key
    (
        [mod], "bracketright",
        lazy.next_layout()
    ),
    Key
    (
        [mod], "bracketleft",
        lazy.prev_layout()
    ),
    Key
    (
        [mod], "n",
        lazy.layout.normalize()
    ),
    Key
    (
        [mod], "r",
        lazy.layout.reset()
    ),
    Key
    (
        [mod, "mod1"], "f",
        lazy.layout.flip()
    ),
    Key
    (
        [mod], "s",
        lazy.layout.toggle_split()
    ),
    Key
    (
        [mod, "shift"], "s",
        lazy.to_layout_index(2),
        lazy.layout.toggle_split()
    ),


    # Refresh / Logout
    Key
    (
        [mod, "shift"], "r",
        lazy.restart()
    ),
    Key
    (
        [mod, "shift"], "x",
        lazy.shutdown()
    ),


    # Miscellaneous
    Key
    (
        [mod, "shift"], "b",
        lazy.hide_show_bar()
    ),
    Key
    (
        [mod], "apostrophe",
        lazy.group["scratchpad"].dropdown_toggle("term")
    ),
]


for i in group_names:
    keys.extend\
    (
        [
            Key
            (
                [mod           ], i, 
                lazy.group[i].toscreen()
            ),
            Key
            (
                [mod, "shift"  ], i, 
                lazy.window.togroup(i)
            ),
            Key
            (
                [mod, "control"], i, 
                lazy.window.togroup(i),
                lazy.group[i].toscreen()
            ),
        ]
    )

# ---     KEYBINDINGS      }}}
##############################
# {{{       LAYOUTS        ---

layout_theme = \
{
    "margin": 8,
    "border_width": 2,
    "single_border_width": 2,
    "border_focus": dracula.purple,
    "border_normal": dracula.blurple
}

layouts = \
[
    layout.MonadTall
    (
        new_client_position="top", 
        **layout_theme
    ),

    layout.Tile
    (
        ratio_increment=0.039, 
        **layout_theme
    ),

    layout.Columns
    (   insert_position=0,
        border_normal_stack=dracula.blurple,
        border_focus_stack=dracula.magenta,
        **layout_theme
    ),

    layout.Matrix(**layout_theme)
]

# ---       LAYOUTS        }}}
##############################
# {{{       WIDGETS        ---

def init_colors():
    return [["#2F343F", "#2F343F"], # color 0
            ["#2F343F", "#2F343F"], # color 1
            ["#c0c5ce", "#c0c5ce"], # color 2
            ["#fba922", "#fba922"], # color 3
            ["#3384d0", "#3384d0"], # color 4
            ["#f3f4f5", "#f3f4f5"], # color 5
            ["#cd1f3f", "#cd1f3f"], # color 6
            ["#62FF00", "#62FF00"], # color 7
            ["#6790eb", "#6790eb"], # color 8
            ["#a9a9a9", "#a9a9a9"]] # color 9
colors = init_colors()


widget_defaults = dict\
(
    font = 'Hack Nerd Font',
    fontsize = 14,
    padding = 3,
    background = dracula.bg,
    foreground = dracula.fg,
    highlight_method = 'border',
    border = dracula.purple,
    borderwidth = 1,
    # rounded = False,
    urgent_alert_method = 'text',
    urgent_text = dracula.magenta,
    urgent_border = dracula.magenta,
)
extension_defaults = widget_defaults.copy()


prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
widgets_list = \
[
    widget.GroupBox
    (
        active = dracula.fg,
        disable_drag = False,
        # highlight_color = dracula_highlight,
        inactive = dracula.bgl,
        this_current_screen_border = dracula.purple,
    ),

    widget.CurrentLayoutIcon
    (
        # custom_icon_paths = [qtile_home + '/icons/layouts/'],
        scale = 0.7
    ),

    widget.TaskList
    (
        icon_size = 20,
        max_title_width = 350,
        margin = 2,
        padding_y = 2,
        # title_width_method = 'uniform',
        txt_floating = '🗗 ',
        txt_maximized = '🗖 ',
        txt_minimized = '🗕 ',
    ),

    widget.TextBox
    (
        font = "FontAwesome",
        text = "  ",
        foreground = dracula.orange,
        background = dracula.bgl,
        padding = 0,
        fontsize = 16
    ),

    widget.Clock
    (
        foreground = dracula.fg,
        background = dracula.bgl,
        format = "%a %b %e, %Y  %I:%M%P"
    ),

    widget.Sep
    (
        linewidth = 1,
        padding = 10,
        foreground = colors[2],
        background = colors[1]
    ),

    widget.Systray
    (
        icon_size=20,
        padding = 4
    ),
]


def init_widgets_screen1():
    widgets_screen1 = widgets_list
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = widgets_list
    return widgets_screen2

widgets_screen1 = init_widgets_screen1()
widgets_screen2 = init_widgets_screen2()


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=26, background=dracula.bg, opacity=0.8)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=26, background=dracula.bg, opacity=0.8))]
screens = init_screens()


# MOUSE CONFIGURATION
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

dgroups_key_binder = None
dgroups_app_rules = []

# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME
# BEGIN

#########################################################
################ assgin apps to groups ##################
#########################################################
# @hook.subscribe.client_new
# def assign_app_group(client):
#     d = {}
#     #####################################################################################
#     ### Use xprop fo find  the value of WM_CLASS(STRING) -> First field is sufficient ###
#     #####################################################################################
#     d[group_names[0]] = ["Navigator", "Firefox", "Vivaldi-stable", "Vivaldi-snapshot", "Chromium", "Google-chrome", "Brave", "Brave-browser",
#               "navigator", "firefox", "vivaldi-stable", "vivaldi-snapshot", "chromium", "google-chrome", "brave", "brave-browser", ]
#     d[group_names[1]] = [ "Atom", "Subl", "Geany", "Brackets", "Code-oss", "Code", "TelegramDesktop", "Discord",
#                "atom", "subl", "geany", "brackets", "code-oss", "code", "telegramDesktop", "discord", ]
#     d[group_names[2]] = ["Inkscape", "Nomacs", "Ristretto", "Nitrogen", "Feh",
#               "inkscape", "nomacs", "ristretto", "nitrogen", "feh", ]
#     d[group_names[3]] = ["Gimp", "gimp" ]
#     d[group_names[4]] = ["Meld", "meld", "org.gnome.meld" "org.gnome.Meld" ]
#     d[group_names[5]] = ["Vlc","vlc", "Mpv", "mpv" ]
#     d[group_names[6]] = ["VirtualBox Manager", "VirtualBox Machine", "Vmplayer",
#               "virtualbox manager", "virtualbox machine", "vmplayer", ]
#     d[group_names[7]] = ["Thunar", "Nemo", "Caja", "Nautilus", "org.gnome.Nautilus", "Pcmanfm", "Pcmanfm-qt",
#               "thunar", "nemo", "caja", "nautilus", "org.gnome.nautilus", "pcmanfm", "pcmanfm-qt", ]
#     d[group_names[8]] = ["Evolution", "Geary", "Mail", "Thunderbird",
#               "evolution", "geary", "mail", "thunderbird" ]
#     d[group_names[9]] = ["Spotify", "Pragha", "Clementine", "Deadbeef", "Audacious",
#               "spotify", "pragha", "clementine", "deadbeef", "audacious" ]
#     ######################################################################################
#
# wm_class = client.window.get_wm_class()[0]
#
#     for i in range(len(d)):
#         if wm_class in list(d.values())[i]:
#             group = list(d.keys())[i]
#             client.togroup(group)
#             client.group.cmd_toscreen(toggle=False)

# END
# ASSIGN APPLICATIONS TO A SPECIFIC GROUPNAME



main = None

@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])

@hook.subscribe.startup
def start_always():
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])

@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True


floating_types = ["notification", "toolbar", "splash", "dialog"]

follow_mouse_focus = True
bring_front_click = True
cursor_warp = False

floating_layout = layout.Floating(float_rules=\
    [
        Match(wm_class='Arcolinux-welcome-app.py'),
        Match(wm_class='Arcolinux-tweak-tool.py'),
        Match(wm_class='Arcolinux-calamares-tool.py'),
        Match(wm_class='confirm'),
        Match(wm_class='dialog'),
        Match(wm_class='download'),
        Match(wm_class='error'),
        Match(wm_class='file_progress'),
        Match(wm_class='notification'),
        Match(wm_class='splash'),
        Match(wm_class='toolbar'),
        Match(wm_class='confirmreset'),
        Match(wm_class='makebranch'),
        Match(wm_class='maketag'),
        Match(wm_class='Arandr'),
        Match(wm_class='feh'),
        Match(wm_class='Galculator'),
        Match(wm_class='arcolinux-logout'),
        Match(wm_class='xfce4-terminal'),
        Match(wm_class='ssh-askpass'),
        Match(title='branchdialog'),
        Match(title='Open File'),
        Match(title='pinentry'),
    ],  
        fullscreen_border_width=0, 
        border_width=1, 
        border_focus=dracula.arcoblue,
        border_normal=dracula.blurple,
)


auto_fullscreen = True
focus_on_window_activation = "focus" # or smart
wmname = "LG3D"

# widget.Net(
#          font="Noto Sans",
#          fontsize=12,
#          interface="enp0s31f6",
#          foreground=colors[2],
#          background=colors[1],
#          padding = 0,
#          ),
# widget.Sep(
#          linewidth = 1,
#          padding = 10,
#          foreground = colors[2],
#          background = colors[1]
#          ),
# widget.NetGraph(
#          font="Noto Sans",
#          fontsize=12,
#          bandwidth="down",
#          interface="auto",
#          fill_color = colors[8],
#          foreground=colors[2],
#          background=colors[1],
#          graph_color = colors[8],
#          border_color = colors[2],
#          padding = 0,
#          border_width = 1,
#          line_width = 1,
#          ),
# widget.Sep(
#          linewidth = 1,
#          padding = 10,
#          foreground = colors[2],
#          background = colors[1]
#          ),
# # do not activate in Virtualbox - will break qtile
# widget.ThermalSensor(
#          foreground = colors[5],
#          foreground_alert = colors[6],
#          background = colors[1],
#          metric = True,
#          padding = 3,
#          threshold = 80
#          ),
# # battery option 1  ArcoLinux Horizontal icons do not forget to import arcobattery at the top
# widget.Sep(
#          linewidth = 1,
#          padding = 10,
#          foreground = colors[2],
#          background = colors[1]
#          ),
# arcobattery.BatteryIcon(
#          padding=0,
#          scale=0.7,
#          y_poss=2,
#          theme_path=home + "/.config/qtile/icons/battery_icons_horiz",
#          update_interval = 5,
#          background = colors[1]
#          ),
# # battery option 2  from Qtile
# widget.Sep(
#          linewidth = 1,
#          padding = 10,
#          foreground = colors[2],
#          background = colors[1]
#          ),
# widget.Battery(
#          font="Noto Sans",
#          update_interval = 10,
#          fontsize = 12,
#          foreground = colors[5],
#          background = colors[1],
#          ),
# widget.TextBox(
#          font="FontAwesome",
#          text="  ",
#          foreground=colors[6],
#          background=colors[1],
#          padding = 0,
#          fontsize=16
#          ),
# widget.CPUGraph(
#          border_color = colors[2],
#          fill_color = colors[8],
#          graph_color = colors[8],
#          background=colors[1],
#          border_width = 1,
#          line_width = 1,
#          core = "all",
#          type = "box"
#          ),
# widget.Sep(
#          linewidth = 1,
#          padding = 10,
#          foreground = colors[2],
#          background = colors[1]
#          ),
# widget.TextBox(
#          font="FontAwesome",
#          text="  ",
#          foreground=colors[4],
#          background=colors[1],
#          padding = 0,
#          fontsize=16
#          ),
# widget.Memory(
#          font="Noto Sans",
#          format = '{MemUsed}M/{MemTotal}M',
#          update_interval = 1,
#          fontsize = 12,
#          foreground = colors[5],
#          background = colors[1],
#         ),
# widget.Sep(
#          linewidth = 1,
#          padding = 10,
#          foreground = colors[2],
#          background = colors[1]
#          ),

