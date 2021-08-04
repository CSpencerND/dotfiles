# {{{       IMPORTS        ---

import os
import re
import socket
import subprocess
from libqtile import qtile, bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, KeyChord, Rule
from libqtile.command import lazy
from libqtile.lazy import lazy
from typing import List  # noqa: F401

# ---       IMPORTS        }}}
##############################
# {{{ VARIABLE DEFINITIONS ---

mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')

terminal = "alacritty"
prompt = "rofi -show run"
browser = "firefox"

@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

# Groups
groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall",
                 "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i]
        )
    )

# Colors
dracula = {
    'black':    '#14151b',
    'bg':       '#282a36',
    'bgl':      '#44475a',
    'grey':     '#4d4d4d',
    'fga':      '#bfbfbf',
    'fg':       '#f8f8f2',
    'magenta':  '#ff79c6',
    'purple':   '#bd93f9',
    'blurple':  '#4d5b86',
    'cyan':     '#8be9fd',
    'green':    '#50fa7b',
    'yellow':   '#f1fa8c',
    'orange':   '#ffb86c',
    'red':      '#ff5555',
}

# --- VARIABLE DEFINITIONS }}}
##############################
# {{{     KEYBINDINGS      ---

keys = [
    # Resize
    Key
    (
        [mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key
    (
        [mod, "control"], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key
    (
        [mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key
    (
        [mod, "control"], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key
    (
        [mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key
    (
        [mod, "control"], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key
    (
        [mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),
    Key
    (
        [mod, "control"], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),

    # Change Focus
    Key([mod        ], "Up",            lazy.layout.up()),
    Key([mod        ], "Down",          lazy.layout.down()),
    Key([mod        ], "Left",          lazy.layout.left()),
    Key([mod        ], "Right",         lazy.layout.right()),
    Key([mod        ], "k",             lazy.layout.up()),
    Key([mod        ], "j",             lazy.layout.down()),
    Key([mod        ], "h",             lazy.layout.left()),
    Key([mod        ], "l",             lazy.layout.right()),

    # BSP Flip
    Key([mod, "mod1" ], "k",            lazy.layout.flip_up()),
    Key([mod, "mod1" ], "j",            lazy.layout.flip_down()),
    Key([mod, "mod1" ], "l",            lazy.layout.flip_right()),
    Key([mod, "mod1" ], "h",            lazy.layout.flip_left()),

    # BSP Shuffle
    Key([mod, "shift"], "k",            lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j",            lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h",            lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l",            lazy.layout.shuffle_right()),

    # Monad move windows up or down
    Key([mod, "shift"], "Up",           lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Down",         lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Left",         lazy.layout.swap_left()),
    Key([mod, "shift"], "Right",        lazy.layout.swap_right()),

    # Switch Groups
    Key([mod         ], "i",            lazy.screen.next_group()),
    Key([mod         ], "u",            lazy.screen.prev_group()),
    Key([mod         ], "semicolon",    lazy.screen.toggle_group()),

    # Window Functions
    Key([mod           ], "c",          lazy.window.kill()),
    Key([mod,          ], "m",          lazy.window.toggle_minimize()),
    Key([mod, "control"], "m",          lazy.window.toggle_maximize()),
    Key([mod, "shift"  ], "m",          lazy.window.toggle_fullscreen()),
    Key([mod           ], "f",          lazy.window.toggle_floating()),
    Key([mod           ], "space",      lazy.findwindow()),

    # Layout Functions
    Key([mod         ], "bracketright", lazy.next_layout()),
    Key([mod         ], "bracketleft",  lazy.prev_layout()),
    Key([mod         ], "n",            lazy.layout.normalize()),
    Key([mod         ], "r",            lazy.layout.reset()),
    Key([mod, "shift"], "f",            lazy.layout.flip()),
    Key([mod         ], "s",            lazy.layout.toggle_split()),


    # Refresh / Logout
    Key([mod, "shift"], "r",            lazy.restart()),
    Key([mod, "shift"], "x",            lazy.shutdown()),

    # Launchers
    Key([mod         ], "Return",       lazy.spawn(terminal)),
    Key([mod         ], "slash",        lazy.spawn("rofi -show run")),
    Key([mod         ], "b",            lazy.spawn(browser)),
    Key([mod         ], "e",            lazy.spawn("rofimoji")),

    # Media Keys
    Key(
        [], "XF86AudioMute", 
        lazy.spawn("amixer sset Master toggle")
    ),

    Key(
        [], "XF86AudioLowerVolume", 
        lazy.spawn("amixer sset Master 5%-")
    ),

    Key(
        [], "XF86AudioRaiseVolume", 
        lazy.spawn("amixer sset Master 5%+")
    )
]

# Switch Groups By Index
for i in groups:
    keys.extend(
        [
            Key(
                [mod           ], i.name, 
                lazy.group[i.name].toscreen()
            ),

            Key(
                [mod, "shift"  ], i.name, 
                lazy.window.togroup(i.name)
            ),

            Key(
                [mod, "control"], i.name, 
                lazy.window.togroup(i.name),
                lazy.group[i.name].toscreen()
            )
        ]
    )

# ---     KEYBINDINGS      }}}
##############################
# {{{       LAYOUTS        ---

def init_layout_theme():
    return {
        "margin": 5,
        "border_width": 1,
        "border_focus": dracula['purple'],
        "border_normal": dracula['bg']
    }

layout_theme = init_layout_theme()

layouts = [
    layout.MonadTall(
        new_client_position="top", 
        margin=8,
        border_width=1,
        single_border_width=1,
        border_focus=dracula['purple'],
        border_normal=dracula['bg']
    ),

    layout.Tile(
        ratio_increment=0.039, 
        **layout_theme
    ),

    layout.Bsp(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Floating(**layout_theme),
]

# ---       LAYOUTS        }}}
##############################
# {{{       WIDGETS        ---

def init_widgets_defaults():
    return {
        'font': 'JetBrains Mono',
        'fontsize': 12,
        'padding': 3,
        'background': dracula['bg'],
        'foreground': dracula['fg']
    }

widget_defaults = init_widgets_defaults()

widgets_list = [
    widget.Sep(
        linewidth=0,
        padding=6,
    ),
    widget.Image(
        filename="~/.config/qtile/icons/python-white.png",
        scale="False",
        mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(terminal)}
    ),
    widget.Sep(
        linewidth=0,
        padding=6,
    ),
    widget.GroupBox(
        font="Ubuntu Bold",
        fontsize=9,
        margin_y=3,
        margin_x=0,
        padding_y=5,
        padding_x=3,
        borderwidth=3,
        rounded=False,
        highlight_method="line",
    ),
    widget.Prompt(
        prompt=prompt,
        font="Ubuntu Mono",
        padding=10,
    ),
    widget.Sep(
        linewidth=0,
        padding=40,
    ),
    widget.WindowName(
        padding=0
    ),
    widget.Systray(
        padding=5
    ),
    widget.Sep(
        linewidth=0,
        padding=6,
    ),
    widget.TextBox(
        text='',
        padding=0,
        fontsize=37
    ),
    widget.Net(
        interface="enp6s0",
        format='{down} ↓↑ {up}',
        padding=5
    ),
    widget.TextBox(
        text='',
        padding=0,
        fontsize=37
    ),
    widget.TextBox(
        text=" 🌡 TEMP NOT SHOWN ",
        padding=2,
        fontsize=11
    ),
    # widget.ThermalSensor(
    #          foreground = colors[2],
    #          background = colors[5],
    #          threshold = 90,
    #          padding = 5
    # ),
    widget.TextBox(
        text='',
        padding=0,
        fontsize=37
    ),
    widget.TextBox(
        text=" ⟳",
        padding=2,
        fontsize=14
    ),
    widget.CheckUpdates(
        update_interval=1800,
        distro="Arch_checkupdates",
        display_format="{updates} Updates",
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(terminal + ' -e sudo apt update')
        },
    ),
    widget.TextBox(
        text='',
        padding=0,
        fontsize=37
    ),
    widget.TextBox(
        text=" 🖬",
        padding=0,
        fontsize=14
    ),
    widget.Memory(
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(terminal + ' -e bpytop')
        },
        padding=5
    ),
    widget.TextBox(
        text='',
        padding=0,
        fontsize=37
    ),
    widget.TextBox(
        text=" ₿",
        padding=0,
        fontsize=12
    ),
    widget.TextBox(
        text='',
        padding=0,
        fontsize=37
    ),
    widget.TextBox(
        text=" Vol:",
        padding=0
    ),
    widget.Volume(
        padding=5
    ),
    widget.TextBox(
        text='',
        padding=0,
        fontsize=37
    ),
    widget.CurrentLayoutIcon(
        custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
        padding=0,
        scale=0.7
    ),
    widget.CurrentLayout(
        padding=5
    ),
    widget.TextBox(
        text='',
        padding=0,
        fontsize=37
    ),
    widget.Clock(
        format="%A, %B %d - %H:%M "
    ),
]


screens = [
    Screen(
        top=bar.Bar
        (
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                widget.Systray(),
                # widget.QuickExit(),
            ], 24, opacity=0.9
        ),
    ),
]

# ---       WIDGETS        }}}
##############################
# {{{    MISCELLANEOUS     ---

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True
wmname = "LG3D"

# ---    MISCELLANEOUS     }}}

