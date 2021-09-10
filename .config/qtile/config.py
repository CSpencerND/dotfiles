# {{{       IMPORTS        ---
import os
import subprocess

from libqtile import qtile, layout, bar, widget, hook
from libqtile.command import lazy
from libqtile.config import (
    Key, Screen, Group, Drag, Match, ScratchPad, DropDown
)

# import arcobattery

# ---       IMPORTS        }}}
##############################
# {{{        VARS          ---

# mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')
qtile_home = os.path.expanduser('~/.config/qtile/')

# Group Definitions
groups = []
group_names = ["1", "2", "3", "4", "5"]
group_labels = ["1", "2", "3", "4", "5"]
group_layouts = [
    "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"
]

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

dropdown_defaults = dict(height=0.5, width=0.5, x=0.25)

groups.append(ScratchPad("scratchpad", dropdowns=\
        [
            DropDown(
                "pad", "alacritty -e lvim ~/.cache/scratchpad",
                **dropdown_defaults
            ),
            DropDown(
                "term", "alacritty",
                **dropdown_defaults
            )
        ]
    )
)

# Theme
class dracula:
    black =   '#14151b'
    bg =      '#282a36'
    bgl =     '#383c4a'
    bgla =    '#44475a'
    comment = "#6272a4"
    fga =     '#bfbfbf'
    fg =      '#f8f8f2'
    magenta = '#ff79c6'
    purple =  '#bd93f9'
    dpurple = '#6d5890'
    blurple = '#4d5b86'
    arcoblue= '#6790eb'
    cyan =    '#8be9fd'
    green =   '#50fa7b'
    yellow =  '#f1fa8c'
    orange =  '#ffb86c'
    red =     '#ff5555'


# ---        VARS          }}}
##############################
# {{{     KEYBINDINGS      ---

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
    for group in qtile.groups:
        for window in group.windows:
            if window.floating:
                window.cmd_bring_to_front()


keys = [
    # Resize
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
        [mod, "control"], "j",
        lazy.layout.shrink_main().when(layout='monadtall'),
        lazy.layout.grow_down().when(layout='columns'),
        lazy.layout.increase_nmaster().when(layout='tile'),
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
        [mod, "control"], "l",
        lazy.layout.grow_main().when(layout='monadtall'),
        lazy.layout.increase_ratio().when(layout='tile'),
        lazy.layout.grow_right().when(layout='columns'),
        lazy.layout.delete().when(layout='matrix'),
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
        [mod, "control"], "f",
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
        [mod, "shift"], "f",
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
    Key
    (
        [mod], "p",
        lazy.group["scratchpad"].dropdown_toggle("pad")
    ),
]


for i in group_names:
    keys.extend\
    (
        [
            Key
            (
                [mod], i,
                lazy.group[i].toscreen()
            ),
            Key
            (
                [mod, "shift"], i,
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
    (
        insert_position=0,
        border_normal_stack=dracula.blurple,
        border_focus_stack=dracula.magenta,
        **layout_theme
    ),

    layout.Matrix(**layout_theme)
]

# ---       LAYOUTS        }}}
##############################
# {{{       WIDGETS        ---


def get_bat_percent():
    batinfo = subprocess.getoutput("acpi | sed 's/Battery 0: //'")
    subprocess.call(["notify-send", batinfo])


def get_forecast():
    forecast = subprocess.getoutput("openweather")
    return forecast


widget_defaults = dict\
(
    font='Hack Nerd Font',
    fontsize=15,
    padding=3,
    background=dracula.bgl,
    foreground=dracula.fg,
    highlight_method='block',
    borderwidth=2,
    rounded=False,
    urgent_alert_method='text',
    urgent_text=dracula.magenta,
    urgent_border=dracula.magenta,
)
extension_defaults = widget_defaults.copy()


class widgets:
    spacer = widget.Spacer(length=6, background=None)

    arco = \
    [
        spacer,
        widget.Image
        (
            filename='~/.config/qtile/icons/arcolinux-arc.png',
            margin=0,
            background=None,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('arcolinux-logout')
            }
        ),
        widget.Spacer(length=4, background=None)
    ]

    basics = \
    [
        widget.GroupBox
        (
            padding=2,
            margin_y=6,
            active=dracula.fg,
            disable_drag=False,
            highlight_method='line',
            highlight_color=[dracula.purple, dracula.dpurple],
            this_current_screen_border=dracula.dpurple,
            inactive=dracula.bgl,
            background=None,
        ),
        widget.CurrentLayoutIcon
        (
            scale=0.7,
            background=None
        ),
        widget.TaskList
        (
            icon_size=22,
            max_title_width=350,
            margin=3,
            padding_y=2,
            # title_width_method = 'uniform',
            txt_floating='🗗 ',
            txt_maximized='🗖 ',
            txt_minimized='🗕 ',
            border=dracula.dpurple,
            background=None
        ),
        spacer
    ]

    time = \
    [
        widget.TextBox
        (
            name='clock_icon',
            font="JoyPixels",
            text=subprocess.getoutput("cat ~/.cache/clock-icon"),
            fontsize=18,
            mouse_callbacks={
                'Button3': lambda: qtile.cmd_spawn('sb-clock')
            }
        ),
        widget.Clock
        (
            format="%I:%M%P"
        ),
        spacer
    ]

    date = \
    [
        widget.TextBox
        (
            name='date_icon',
            font="FontAwesome",
            text="📆",
            fontsize=18,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('sb-cal')
            }
        ),
        widget.Clock
        (
            format="%a %b%e, %Y",
            update_interval=60,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('sb-cal')
            }
        ),
        spacer
    ]

    weather = \
    [
        # widget.GenPollText
        # (
        #     font = 'Weather Icons',
        #     fontsize = 16,
        #     func = get_forecast,
        #     update_interval = 3600,
        # ),
        widget.TextBox
        (
            name='current_icon',
            font="JoyPixels",
            text=subprocess.getoutput("cat ~/.cache/weather/current_icon"),
            fontsize=18,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('wttr-bttn'),
            },
        ),
        widget.TextBox
        (
            name='current_temp',
            text=subprocess.getoutput("cat ~/.cache/weather/current_temp"),
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('wttr-bttn')
            },
        ),
        widget.TextBox
        (
            name='trend',
            font="Material Icons",
            text=subprocess.getoutput("cat ~/.cache/weather/trend"),
            fontsize=18,
            foreground=dracula.yellow,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('wttr-bttn'),
                'Button3': lambda: qtile.cmd_spawn('openweather-emoji')
            },
        ),
        widget.TextBox
        (
            name='forecast_icon',
            font="JoyPixels",
            text=subprocess.getoutput("cat ~/.cache/weather/forecast_icon"),
            fontsize=18,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('wttr-bttn')
            },
        ),
        widget.TextBox
        (
            name='forecast_temp',
            text=subprocess.getoutput("cat ~/.cache/weather/forecast_temp"),
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('wttr-bttn')
            },
        ),
        spacer
    ]

    stocks = \
    [
        widget.StockTicker
        (
            apikey='G0BJFWBFWXWJAJ9R',
            symbol='GOOG',
            function='TIME_SERIES_INTRADAY',
            foreground=dracula.green,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn(
                    'firefox https://www.google.com/finance/quote/GOOG:NASDAQ\
                    ?sa=X&ved=2ahUKEwja5LDekejyAhWAJTQIHaLjDtwQ3ecFegQIKhAa'
                )
            }
        ),
        spacer
    ]

    keyboard = \
    [
        # widget.TextBox
        # (
        #     name='kbd_icon',
        #     font='Hack Nerd Font',
        #     text='',
        #     fontsize=22,
        #     foreground=dracula.cyan,
        #     padding=6
        # ),
        widget.Image
        (
            filename='~/.config/qtile/icons/kmonad.png',
            scale=False,
            margin_y=4
        ),
        widget.TextBox
        (
            name='kbd_layout',
            text='Std',
            padding=4
        ),
        spacer
    ]

    memory = \
    [
        widget.TextBox
        (
            name='memory_icon',
            font="JoyPixels",
            text="🧠",
            fontsize=18,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('mem-icon-click')
            }
        ),
        widget.Memory
        (
            measure_mem='G',
            format='{MemUsed:.1f}{mm}',
            update_interval=10,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('mem-text-click')
            }
        ),
        spacer
    ]

    thermals = \
    [
        widget.TextBox
        (
            name='thermal_icon',
            font="JoyPixels",
            text="🌡",
            padding=0,
            fontsize=19,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('cpu-icon-click')
            }
        ),
        widget.ThermalSensor
        (
            foreground_alert=dracula.magenta,
            metric=True,
            threshold=70,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('cpu-text-click')
            }
        ),
        spacer
    ]

    system76 = \
    [
        widget.TextBox
        (
            name='system76',
            font='JoyPixels',
            text='⚡',
            padding=0,
            fontsize=18,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('s76-power-base')
            },
        ),
        widget.TextBox
        (
            name='indicator',
            text=subprocess.getoutput("cat ~/.cache/power-profile"),
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('s76-power-base')
            },
        ),
        spacer,
    ]

    battery = \
    [
        widget.BatteryIcon
        (
            mouse_callbacks={'Button1': get_bat_percent},
            padding=0,
        ),
        widget.Battery
        (
            format='{percent:2.0%}',
            mouse_callbacks={'Button1': get_bat_percent},
            low_foreground=dracula.magenta,
            low_percentage=0.20,
            notify_below=0.20,
        ),
        spacer,
    ]

    tray = \
    [
        widget.Systray
        (
            icon_size=22,
            padding=4,
            background=None
        ),
        spacer
    ]

    tray_box = \
    [
        widget.WidgetBox
        (
            widgets=[*tray],
            close_button_location='right',
            font='JoyPixels',
            text_closed='⚙',
            text_open='⚙',
            fontsize=19,
            background=None,
        ),
        spacer
    ]


widgets_list = \
[
    *widgets.arco,
    *widgets.basics,
    *widgets.time,
    *widgets.date,
    *widgets.weather,
    *widgets.stocks,
    *widgets.keyboard,
    *widgets.memory,
    *widgets.thermals,
    *widgets.system76,
    *widgets.battery,
    *widgets.tray_box,
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
    return [
             Screen(top=bar.Bar(
                widgets=init_widgets_screen1(),
                size=28, background=dracula.bg, opacity=0.85
             )),
             Screen(top=bar.Bar(
                widgets=init_widgets_screen2(),
                size=28, background=dracula.bg, opacity=0.85
             ))
           ]
screens = init_screens()

# ---       WIDGETS        }}}
##############################
# {{{        MISC          ---

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

dgroups_key_binder = None
dgroups_app_rules = []

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

floating_layout = layout.Floating\
(
    float_rules=\
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
        Match(wm_class='redshift-gtk'),
        Match(wm_class='solaar'),
        Match(wm_class='blueberry.py'),
        Match(wm_class='pavucontrol'),
        Match(title='branchdialog'),
        Match(title='Open File'),
        Match(title='pinentry'),
        Match(func=lambda c: bool(c.is_transient_for()))
    ],

    fullscreen_border_width=0,
    border_width=1,
    border_focus=dracula.arcoblue,
    border_normal=dracula.blurple,
)


auto_fullscreen = True
focus_on_window_activation = "focus" # or smart
wmname = "LG3D"

# ---        MISC          }}}

# arcobattery.BatteryIcon(
#          padding=0,
#          scale=0.7,
#          y_poss=2,
#          theme_path=home + "/.config/qtile/icons/battery_icons_horiz",
#          update_interval = 5,
#          background = colors[1]
#          ),
# # battery option 2  from Qtile
# widget.Battery(
#          font="Noto Sans",
#          update_interval = 10,
#          fontsize = 12,
#          foreground = colors[5],
#          background = colors[1],
#          ),

