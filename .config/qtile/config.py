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

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

# Workspaces
groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
# group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall",
#                  "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            # layout=group_layouts[i].lower(),
            label=group_labels[i]
        )
    )

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
    # Switch Between Windows
    # Vim Keys
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

    # Arrow Keys
    Key
    (
        [mod], "Up",
        lazy.layout.up()
    ),
    Key
    (
        [mod], "Down",
        lazy.layout.down()
    ),
    Key
    (
        [mod], "Left",
        lazy.layout.left()
    ),
    Key
    (
        [mod], "Right",
        lazy.layout.right()
    ),

    # Switch Between Groups
    Key
    (
        [mod], "i",
        lazy.screen.next_group(),
        desc="Switch to next group"
    ),
    Key
    (
        [mod], "u",
        lazy.screen.prev_group(),
        desc="Switch to previous group"
    ),
    Key
    (
        [mod], "semicolon",
        lazy.screen.toggle_group(),
        desc="Toggle to previous group"
    ),

    # Switch Between Monitors

    # Resize Windows
    Key
    (
        [mod, "shift"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete()
    ),
    Key
    (
        [mod, "shift"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add()
    ),
    Key
    (
        [mod, "shift"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster()
    ),
    Key
    (
        [mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster()
    ),

    # Window Functions
    Key
    (
        [mod], "c",
        lazy.window.kill()
    ),
    Key
    (
        [mod, "shift"], "m",
        lazy.window.toggle_fullscreen()
    ),
    Key
    (
        [mod], "f",
        lazy.window.toggle_floating()
    ),

    # Layout Functions
    Key
    (
        [mod], "n",
        lazy.layout.normalize()
    ),
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
        [mod], "s",
        lazy.layout.toggle_split()
    ),

    ### Refresh / Logout
    Key
    (
        [mod, "shift"], "r",
        lazy.restart(),
        desc="Refresh Qtile"
    ),
    Key
    (
        [mod, "shift"], "x",
        lazy.shutdown(),
        desc="Logout Qtile"
    ),


    # Launchers
    Key
    (
        [mod], "Return",
        lazy.spawn(terminal),
        desc="Launch Terminal"
    ),
    Key
    (
        [mod], "slash",
        lazy.spawn(prompt),
        desc="Launch Rofi"
    ),
    Key
    (
        [mod], "b",
        lazy.spawn(browser),
        desc="Launch Firefox"
    ),
    Key
    (
        [mod], "e",
        lazy.spawn("rofimoji"),
        desc="Search Emojis"
    ),


    # Media Keys
    Key
    (
        [], "XF86AudioMute",
        lazy.spawn("amixer -D pulse sset Master toggle")
    ),
    Key
    (
        [], "XF86AudioLowerVolume",
        lazy.spawn("amixer -D pulse sset Master 5%-")
    ),
    Key
    (
        [], "XF86AudioRaiseVolume",
        lazy.spawn("amixer -D pulse sset Master 5%+")
    )
]

# Switching Groups By Index
for i in groups:
    keys.extend(
        [
            Key
            (
                [mod], i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group by index"
            ),
            Key
            (
                [mod, "shift"], i.name,
                lazy.window.togroup(i.name),
                desc="Move focused window to group by index"
            ),
            Key
            (
                [mod, "control"], i.name,
                lazy.window.togroup(i.name),
                lazy.group[i.name].toscreen(),
                desc="Move focused window and switch to group by index"
            )
        ])

# ---     KEYBINDINGS      }}}
##############################
# {{{       LAYOUTS        ---

layout_theme = {
    "margin": 10,
    "border_width": 1,
    "border_focus": dracula['purple'],
    "border_normal": dracula['bg']
}

layouts = [
    layout.MonadTall(new_client_position="top", **layout_theme),
    layout.Tile(ratio_increment=0.039, **layout_theme),
    layout.Bsp(**layout_theme),
    layout.Columns(**layout_theme),
    layout.Floating(**layout_theme),
]

# ---       LAYOUTS        }}}
##############################
# {{{       WIDGETS        ---

extension_defaults = {
    'font': 'JetBrains Mono',
    'fontsize': 12,
    'padding': 3,
    'background': dracula['bgl'],
    'foreground': dracula['fg']
}

widgets_list = [
    widget.Sep(
        linewidth=0,
        padding=6,
        foreground=colors[2],
        background=colors[0]
    ),
    widget.Image(
        filename="~/.config/qtile/icons/python-white.png",
        scale="False",
        mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(myTerm)}
    ),
    widget.Sep(
        linewidth=0,
        padding=6,
        foreground=colors[2],
        background=colors[0]
    ),
    widget.GroupBox(
        font="Ubuntu Bold",
        fontsize=9,
        margin_y=3,
        margin_x=0,
        padding_y=5,
        padding_x=3,
        borderwidth=3,
        active=colors[2],
        inactive=colors[7],
        rounded=False,
        highlight_color=colors[1],
        highlight_method="line",
        this_current_screen_border=colors[6],
        this_screen_border=colors[4],
        other_current_screen_border=colors[6],
        other_screen_border=colors[4],
        foreground=colors[2],
        background=colors[0]
    ),
    widget.Prompt(
        prompt=prompt,
        font="Ubuntu Mono",
        padding=10,
        foreground=colors[3],
        background=colors[1]
    ),
    widget.Sep(
        linewidth=0,
        padding=40,
        foreground=colors[2],
        background=colors[0]
    ),
    widget.WindowName(
        foreground=colors[6],
        background=colors[0],
        padding=0
    ),
    widget.Systray(
        background=colors[0],
        padding=5
    ),
    widget.Sep(
        linewidth=0,
        padding=6,
        foreground=colors[0],
        background=colors[0]
    ),
    widget.TextBox(
        text='',
        background=colors[0],
        foreground=colors[4],
        padding=0,
        fontsize=37
    ),
    widget.Net(
        interface="enp6s0",
        format='{down} ↓↑ {up}',
        foreground=colors[2],
        background=colors[4],
        padding=5
    ),
    widget.TextBox(
        text='',
        background=colors[4],
        foreground=colors[5],
        padding=0,
        fontsize=37
    ),
    widget.TextBox(
        text=" 🌡 TEMP NOT SHOWN ",
        padding=2,
        foreground=colors[2],
        background=colors[5],
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
        background=colors[5],
        foreground=colors[4],
        padding=0,
        fontsize=37
    ),
    widget.TextBox(
        text=" ⟳",
        padding=2,
        foreground=colors[2],
        background=colors[4],
        fontsize=14
    ),
    widget.CheckUpdates(
        update_interval=1800,
        distro="Arch_checkupdates",
        display_format="{updates} Updates",
        foreground=colors[2],
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e sudo apt update')
        },
        background=colors[4]
    ),
    widget.TextBox(
        text='',
        background=colors[4],
        foreground=colors[5],
        padding=0,
        fontsize=37
    ),
    widget.TextBox(
        text=" 🖬",
        foreground=colors[2],
        background=colors[5],
        padding=0,
        fontsize=14
    ),
    widget.Memory(
        foreground=colors[2],
        background=colors[5],
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')
        },
        padding=5
    ),
    widget.TextBox(
        text='',
        background=colors[5],
        foreground=colors[4],
        padding=0,
        fontsize=37
    ),
    widget.TextBox(
        text=" ₿",
        padding=0,
        foreground=colors[2],
        background=colors[4],
        fontsize=12
    ),
    widget.BitcoinTicker(
        foreground=colors[2],
        background=colors[4],
        padding=5
    ),
    widget.TextBox(
        text='',
        background=colors[4],
        foreground=colors[5],
        padding=0,
        fontsize=37
    ),
    widget.TextBox(
        text=" Vol:",
        foreground=colors[2],
        background=colors[5],
        padding=0
    ),
    widget.Volume(
        foreground=colors[2],
        background=colors[5],
        padding=5
    ),
    widget.TextBox(
        text='',
        background=colors[5],
        foreground=colors[4],
        padding=0,
        fontsize=37
    ),
    widget.CurrentLayoutIcon(
        custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
        foreground=colors[0],
        background=colors[4],
        padding=0,
        scale=0.7
    ),
    widget.CurrentLayout(
        foreground=colors[2],
        background=colors[4],
        padding=5
    ),
    widget.TextBox(
        text='',
        background=colors[4],
        foreground=colors[5],
        padding=0,
        fontsize=37
    ),
    widget.Clock(
        foreground=colors[2],
        background=colors[5],
        format="%A, %B %d - %H:%M "
    ),
]


screens = [
    Screen(
        top=bar.Bar(
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
                widget.TextBox("default config", name="default"),
                widget.TextBox("Press &lt;M-r&gt; to spawn",
                               foreground="#d75f5f"),
                widget.Systray(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                widget.QuickExit(),
            ],
            24,
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

lazy.spawn("nitrogen --restore")
