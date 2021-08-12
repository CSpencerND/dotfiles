# {{{       IMPORTS        ---

import socket
from os import environ
from os.path import expanduser
from subprocess import call
from libqtile import qtile, bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen 
from libqtile.lazy import lazy
from typing import List  # noqa: F401

# ---       IMPORTS        }}}
##############################
# {{{      VARIABLES       ---

mod = "mod4"
terminal = "alacritty"
launcher = "rofi -show run"
browser = "firefox"
home = expanduser("~")

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

class dracula:
    black =   '#14151b'
    bg =      '#282a36'
    bgl =     '#44475a'
    grey =    '#4d4d4d'
    fga =     '#bfbfbf'
    fg =      '#f8f8f2'
    magenta = '#ff79c6'
    purple =  '#bd93f9'
    blurple = '#4d5b86'
    cyan =    '#8be9fd'
    green =   '#50fa7b'
    yellow =  '#f1fa8c'
    orange =  '#ffb86c'
    red =     '#ff5555'

# ---      VARIABLES       }}}
##############################
# {{{      FUNCTIONS       ---

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

# ---      FUNCTIONS       }}}
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
    Key([mod        ], "k",             lazy.layout.up()),
    Key([mod        ], "j",             lazy.layout.down()),
    Key([mod        ], "h",             lazy.layout.left()),
    Key([mod        ], "l",             lazy.layout.right()),
    Key([mod        ], 'z',             lazy.next_urgent()),

    # Move Windows Around The Stack
    Key([mod, "shift"], "h",            lazy.layout.shuffle_left()),
    Key([mod, "shift"], "j",            lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k",            lazy.layout.shuffle_up()),
    Key([mod, "shift"], "l",            lazy.layout.shuffle_right()),

    Key([mod, "mod1" ], "h",            lazy.layout.swap_left()),
    Key([mod, "mod1" ], "j",            lazy.layout.swap_left()),
    Key([mod, "mod1" ], "k",            lazy.layout.swap_right()),
    Key([mod, "mod1" ], "l",            lazy.layout.swap_right()),

    # Switch Groups by direction
    Key([mod           ], "i",         lazy.screen.next_group()),
    Key([mod           ], "u",         lazy.screen.prev_group()),
    Key([mod           ], "semicolon", lazy.screen.toggle_group()),
    Key([mod, "shift"  ], "i",         window_to_next_group),
    Key([mod, "shift"  ], "u",         window_to_prev_group),
    Key([mod, "control"], "i",         window_to_next_group, lazy.screen.next_group()),
    Key([mod, "control"], "u",         window_to_prev_group, lazy.screen.prev_group()),

    # Window Functions
    Key([mod           ], "c",          lazy.window.kill()),
    Key([mod,          ], "m",          lazy.window.toggle_minimize()),
    Key([mod, "control"], "m",          lazy.group.unminimize_all()),
    Key([mod, "shift"  ], "m",          lazy.window.toggle_maximize()),
    Key([mod, "shift"  ], "f",          lazy.window.toggle_fullscreen()),
    Key([mod           ], "f",          lazy.window.toggle_floating()),
    Key([mod           ], "apostrophe", lazy.findwindow()),

    # Layout Functions
    Key([mod         ], "bracketright", lazy.next_layout()),
    Key([mod         ], "bracketleft",  lazy.prev_layout()),
    Key([mod         ], "n",            lazy.layout.normalize()),
    Key([mod         ], "r",            lazy.layout.reset()),
    Key([mod, "mod1" ], "f",            lazy.layout.flip()),
    Key([mod         ], "s",            lazy.layout.toggle_split()),


    # Refresh / Logout
    Key([mod, "shift"], "r",            lazy.restart()),
    Key([mod, "shift"], "x",            lazy.shutdown()),

    # Launchers
    Key([mod         ], "Return",       lazy.spawn(terminal)),
    Key([mod         ], "slash",        lazy.spawn(launcher)),
    Key([mod         ], "b",            lazy.spawn(browser)),
    Key([mod         ], "e",            lazy.spawn("rofimoji")),

    # Miscellaneous
    Key([mod, "shift"], "b",            lazy.hide_show_bar()),

    # Function Keys
    Key
    (
        [], "XF86MonBrightnessUp", 
        lazy.spawn("sudo brightnessctl s +5%")
    ),
    Key
    (
        [], "XF86MonBrightnessDown", 
        lazy.spawn("sudo brightnessctl s 5%-")
    ),
#     Key
#     (
#         [], "XF86AudioMute", 
#         lazy.spawn("amixer sset Master toggle")
#     ),
#     Key
#     (
#         [], "XF86AudioLowerVolume", 
#         lazy.spawn("amixer amixer -c 0 -q set Master 5dB-") 
#     ),
#     Key
#     (
#         [], "XF86AudioRaiseVolume", 
#         lazy.spawn("amixer amixer -c 0 -q set Master 5dB+") 
#     ),
]

# Switch Groups By Index

for i in groups:
    keys.extend(
        [
            Key
            (
                [mod           ], i.name, 
                lazy.group[i.name].toscreen()
            ),
            Key
            (
                [mod, "shift"  ], i.name, 
                lazy.window.togroup(i.name)
            ),
            Key
            (
                [mod, "control"], i.name, 
                lazy.window.togroup(i.name),
                lazy.group[i.name].toscreen()
            ),
        ]
    )

# ---     KEYBINDINGS      }}}
##############################
# {{{       LAYOUTS        ---

def init_layout_theme():
    return {
        "margin": 8,
        "border_width": 2,
        "single_border_width": 2,
        "border_focus": dracula.purple,
        "border_normal": dracula.bg
    }
layout_theme = init_layout_theme()


layouts = [
    layout.MonadTall(
        new_client_position="top", 
        **layout_theme
    ),

    layout.Tile(
        ratio_increment=0.039, 
        **layout_theme
    ),

    layout.Columns(**layout_theme),
    layout.Matrix(**layout_theme)
]

# ---       LAYOUTS        }}}
##############################
# {{{       WIDGETS        ---

def init_widgets_defaults():
    return {
        'font': 'JetBrains Mono',
        'fontsize': 14,
        'padding': 3,
        'background': dracula.bg,
        'foreground': dracula.fg
    }
widget_defaults = init_widgets_defaults()


def init_widgets_list():
    icon_path = expanduser("~/.config/qtile/icons")
    prompt = "{0}@{1}: ".format(environ["USER"], socket.gethostname())
    widgets_list = [
        widget.CurrentLayoutIcon
        (
            custom_icon_paths=[icon_path],
            **widget_defaults
        ),
        widget.GroupBox
        (
            borderwidth=3,
            rounded=False,
            highlight_method="line",
            **widget_defaults
        ),

    ]
    return widgets_list
widgets = init_widgets_list()


screens = [
    Screen(
        top=bar.Bar
        (
            [
                widget.CurrentLayoutIcon(),
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
            ], 24, opacity=0.95
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


@hook.subscribe.startup_once
def start_once():
    call([expanduser("~/.config/qtile/autostart.sh")])

# ---    MISCELLANEOUS     }}}
