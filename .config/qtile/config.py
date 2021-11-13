# {{{       IMPORTS        ---
import os
import subprocess

from libqtile import qtile, layout, bar, widget, hook
from libqtile.command import lazy
from libqtile.config import (
    Key, Screen, Group, Drag, Match, ScratchPad, DropDown
)
# import arcobattery
import groupbox_git
import custom_groupbox
import custom_tasklist

from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration

subprocess.Popen("setup_screens")

# ---       IMPORTS        }}}
##############################
# {{{        VARS          ---

mod = "mod4"
home = os.path.expanduser('~')
qtile_home = os.path.expanduser('~/.config/qtile/')

# Group Definitions
groups = []
group_names = ["1", "2", "3", "4", "5", "6"]
group_labels = ["1", "2", "3", "4", "5", "II"]
group_layouts = [
    "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "columns"
]

for i in range(len(group_names)):
    groups.append(
        Group
        (
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

dropdown_defaults = dict(height=0.5, width=0.5, x=0.25)
groups.append(ScratchPad("scratchpad", dropdowns=[

            DropDown(
                "pad", "alacritty -e lvim " + home + "/.cache/scratchpad",
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
class themes:
    class dracula:
        black =   '#21222c'
        bg =      '#282a36'
        bgl =     '#383c4a'
        bgla =    '#424450'
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


    class dracula_alt:
        black =   '#21222c'
        bg =      '#282a36'
        bgl =     '#383c4a'
        bgla =    '#424450'
        comment = "#6272a4"
        fga =     '#bfbfbf'
        fg =      '#f8f8f2'
        magenta = '#bd93f9'
        purple =  '#ff79c6'
        dpurple = '#6d5890'
        blurple = '#4d5b86'
        arcoblue= '#6790eb'
        cyan =    '#8be9fd'
        green =   '#50fa7b'
        yellow =  '#f1fa8c'
        orange =  '#ffb86c'
        red =     '#ff5555'


    class gruvbox:
        black =   '#21222c'
        bg =      '#282828'
        bgl =     '#3c3836'
        bgla =    '#4c4642'
        comment = "#665c54"
        fga =     '#ebdbb2'
        fg =      '#fbf1c7'
        magenta = '#cc241d'
        purple =  '#d57615'
        dpurple = '#cf6503'
        blurple = '#deb204'
        arcoblue= '#6790eb'
        cyan =    '#689d6a'
        green =   '#98971a'
        yellow =  '#fabd2f'
        orange =  '#b16286'
        red =     '#fb4934'


    class monokai:
        black =   '#211F22'
        bg =      '#26292C'
        bgl =     '#333842'
        bgla =    '#424450'
        comment = "#72696A"
        fga =     '#B1B1B1'
        fg =      '#FFF1F3'
        magenta = '#ff79c6'
        purple =  '#FC9867'
        dpurple = '#b92d6f'
        blurple = '#AB5DF2'
        arcoblue= '#6790eb'
        cyan =    '#78DCE8'
        green =   '#A9DC76'
        yellow =  '#FFD866'
        orange =  '#FC9867'
        red =     '#FD6883'


theme = themes.dracula


# ---        VARS          }}}
##############################
# {{{     KEYBINDINGS      ---

# Move Windows To Groups By Direction
@lazy.function
def window_to_prev_group(qtile):
    if qtile.current_window is not None:
        i = qtile.groups.index(qtile.current_group)
        if qtile.groups[i - 1].name == "scratchpad":
            qtile.current_window.togroup(qtile.groups[-2].name)
        else:
            qtile.current_window.togroup(qtile.groups[i - 1].name)


@lazy.function
def window_to_next_group(qtile):
    if qtile.current_window is not None:
        i = qtile.groups.index(qtile.current_group)
        if qtile.groups[i + 1].name == "scratchpad":
            qtile.current_window.togroup(qtile.groups[0].name)
        else:    
            qtile.current_window.togroup(qtile.groups[i + 1].name)


# Move Windows Between Screens
@lazy.function
def window_to_prev_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group)


@lazy.function
def window_to_next_screen(qtile):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group)


# @lazy.function
# def switch_screens(qtile):
#     i = qtile.screens.index(qtile.current_screen)
#     group = qtile.screens[i - 1].group
#     qtile.current_screen.set_group(group)


# Bring floating windows to front
@lazy.function
def float_to_front(qtile):
    for group in qtile.groups:
        for window in group.windows:
            if window.floating:
                window.cmd_bring_to_front()


# Change which monitor has the group
# @lazy.function
# def go_to_group(group):
#     def f(qtile):
#         if group in "12345":
#             qtile.cmd_to_screen(0)
#             qtile.groups_map[group].cmd_toscreen()
#         else:
#             qtile.cmd_to_screen(1)
#             qtile.groups_map[group].cmd_toscreen()

#     return f


keys = [
    # Resize
    Key
    (
        [mod, "control"], "h",
        lazy.layout.shrink_main().when(layout='monadtall'),
        # lazy.layout.decrease_ratio().when(layout='tile'),
        lazy.layout.grow_left().when(layout='columns'),
        lazy.layout.add().when(layout='matrix'),
    ),
    Key
    (
        [mod, "control"], "j",
        lazy.layout.shrink_main().when(layout='monadtall'),
        lazy.layout.grow_down().when(layout='columns'),
        # lazy.layout.increase_nmaster().when(layout='tile'),
    ),
    Key
    (
        [mod, "control"], "k",
        lazy.layout.grow_main().when(layout='monadtall'),
        lazy.layout.grow_up().when(layout='columns'),
        # lazy.layout.decrease_nmaster().when(layout='tile'),
    ),
    Key
    (
        [mod, "control"], "l",
        lazy.layout.grow_main().when(layout='monadtall'),
        # lazy.layout.increase_ratio().when(layout='tile'),
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
    # Key
    # (
    #     [mod, "shift"], "semicolon",
    #     go_to_group,
    # ),
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


    # Switch Screens
    Key
    (
        [mod], "period",
        lazy.next_screen(),
    ),
    Key
    (
        [mod], "comma",
        lazy.prev_screen(),
    ),
    Key
    (
        [mod, "shift"], "period",
        window_to_next_screen
    ),
    Key
    (
        [mod, "shift"], "comma",
        window_to_prev_screen
    ),
    Key
    (
        [mod, "control"], "period",
        window_to_next_screen,
        lazy.next_screen(),
    ),
    Key
    (
        [mod, "control"], "comma",
        window_to_prev_screen,
        lazy.prev_screen(),
    ),
    # Key
    # (
    #     [mod, "control"], "semicolon",
    #     switch_screens
    # ),


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
        [mod, "shift"], "r",
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
        lazy.to_layout_index(1),
        lazy.layout.toggle_split()
    ),


    # Refresh / Logout
    Key
    (
        [mod], "r",
        lazy.reload_config()
    ),
    Key
    (
        [mod, "control"], "r",
        lazy.restart()
    ),
    Key
    (
        [mod, "mod1"], "r",
        lazy.reconfigure_screens()
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
    keys.extend(
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
            # Key
            # (
            #     [mod, "shift", "mod1"], i,
            #     go_to_group
            # )
        ]
    )

# for s, g in [(0, "1"), (0, "2"), (0, "3"), (0, "4"), (0, "5"), (1, "6")]:
#     keys.append(
#         Key
#         (
#             [mod, "mod1"], g,
#             lazy.group[g].toscreen(s),
#         )
#     )

# for s, g in [(0, "1"), (0, "2"), (0, "3"), (0, "4"), (0, "5"), (1, "6")]:
#     keys.append(
#         Key
#         (
#             [mod, "mod1", "shift"], g,
#             lazy.window.togroup(g),
#             lazy.group[g].toscreen(s),
#         )
#     )

# for s, g in [(0, "1"), (0, "2"), (0, "3"), (0, "4"), (0, "5"), (1, "6")]:
#     keys.append(
#         Key
#         (
#             [mod, "mod1", "control"], g,
#             lazy.window.togroup(g),
#             lazy.group[g].toscreen(s),
#             lazy.to_screen(s)
#         )
#     )

# ---     KEYBINDINGS      }}}
##############################
# {{{       LAYOUTS        ---

layout_theme = {

    "margin": 8,
    "border_width": 2,
    "single_border_width": 2,
    "border_focus": theme.purple,
    "border_normal": theme.bg
}

layouts = [

    layout.MonadTall
    (
        new_client_position="top",
        **layout_theme
    ),

    layout.Columns
    (
        insert_position=0,
        border_on_single=True,
        border_normal_stack=theme.bg,
        border_focus_stack=theme.magenta,
        **layout_theme
    ),
    
    layout.Matrix(**layout_theme),

    # layout.Tile
    # (
    #     ratio_increment=0.039,
    #     **layout_theme
    # ),

]

# ---       LAYOUTS        }}}
##############################
# {{{       WIDGETS        ---


def get_bat_percent():
    batinfo = subprocess.getoutput("acpi | sed 's/Battery 0: //'")
    subprocess.Popen(["notify-send", batinfo])


def get_forecast():
    forecast = subprocess.getoutput("openweather")
    return forecast


def tick_widget():
    w = qtile.widgets_map["headset"]
    w.update(w.poll())


widget_defaults = dict(

    font='Hack Nerd Font',
    fontsize=14,
    padding=3,
    background=theme.bgla,
    foreground=theme.fg,
    borderwidth=2,
    rounded=False,
    urgent_alert_method='text',
    urgent_text=theme.magenta,
    urgent_border=theme.magenta,
)
# extension_defaults = widget_defaults.copy()

decor = dict(
    decorations=[
        BorderDecoration
        (
            border_width=[0, 0, 2, 0],
            colour=theme.purple,
        )
    ]
)

class widgets:
    spacer = widget.Spacer(length=4, background=None)

    arco = [

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

    basics = [

        # widget.GroupBox
        # custom_groupbox.GroupBox
        groupbox_git.GroupBox
        (
            highlight_method='line',
            unfocused_highlight_method='text',
            active=theme.fg,
            inactive='#5b5b5b',
            disable_drag=False,
            # block_highlight_text_color=theme.comment,
            highlight_color=theme.bgla,  # [theme.dpurple, theme.purple],
            this_current_screen_border=theme.purple,
            this_screen_border=theme.purple,
            other_current_screen_border=theme.cyan,
            other_screen_border=theme.cyan,
            background=None,
            padding_y=0,
        ),
        widget.CurrentLayoutIcon
        (
            scale=0.7,
            background=None
        ),
        # widget.TaskList
        custom_tasklist.TaskList
        (
            highlight_method='block',
            icon_size=22,
            txt_floating='🗗 ',
            txt_maximized='🗖 ',
            txt_minimized='🗕 ',
            border=theme.dpurple,
            background=None,
            # max_title_width=350,
            # title_width_method = 'uniform',
            padding_y=0,
        ),
        spacer
    ]

    time = [

        widget.TextBox
        (
            name='clock_icon',
            font="JoyPixels",
            text=subprocess.getoutput("cat ~/.cache/clock-icon"),
            fontsize=18,
            mouse_callbacks={
                'Button3': lambda: qtile.cmd_spawn('sb-clock')
            },
            **decor
        ),
        widget.Clock
        (
            format="%I:%M%P",
            **decor
        ),
        spacer
    ]

    date = [

        widget.TextBox
        (
            name='date_icon',
            font="FontAwesome",
            text="📆",
            fontsize=17,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('sb-cal')
            },
            **decor
        ),
        widget.Clock
        (
            format="%a %b %e, %Y",
            update_interval=60,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('sb-cal')
            },
            **decor
        ),
        spacer
    ]

    weather = [

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
            **decor
        ),
        widget.TextBox
        (
            name='current_temp',
            text=subprocess.getoutput("cat ~/.cache/weather/current_temp"),
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('wttr-bttn')
            },
            **decor
        ),
        widget.TextBox
        (
            name='trend',
            font="Material Icons",
            text=subprocess.getoutput("cat ~/.cache/weather/trend"),
            fontsize=18,
            foreground=theme.fg,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('wttr-bttn'),
                'Button3': lambda: qtile.cmd_spawn('openweather-emoji')
            },
            **decor
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
            **decor
        ),
        widget.TextBox
        (
            name='forecast_temp',
            text=subprocess.getoutput("cat ~/.cache/weather/forecast_temp"),
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('wttr-bttn')
            },
            **decor
        ),
        spacer
    ]

    stocks = [

        widget.StockTicker
        (
            apikey='G0BJFWBFWXWJAJ9R',
            symbol='GOOG',
            function='TIME_SERIES_INTRADAY',
            foreground=theme.green,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn(
                    'firefox https://www.google.com/finance/quote/GOOG:NASDAQ\
                    ?sa=X&ved=2ahUKEwja5LDekejyAhWAJTQIHaLjDtwQ3ecFegQIKhAa'
                )
            },
            **decor
        ),
        spacer
    ]

    keyboard = [

        # widget.TextBox
        # (
        #     name='kbd_icon',
        #     font='Hack Nerd Font',
        #     text='',
        #     fontsize=22,
        #     foreground=theme.cyan,
        #     padding=6
        # ),
        widget.Image
        (
            filename='~/.config/qtile/icons/kmonad.png',
            scale=False,
            margin_y=4,
            **decor
        ),
        widget.TextBox
        (
            name='kbd_layout',
            text='Std',
            padding=4,
            **decor
        ),
        spacer
    ]

    headset = [
        widget.TextBox
        (
            text="🎧",
            **decor
        ),
        widget.GenPollText
        (
            name="headset",
            func=lambda: subprocess.getoutput(
                "headsetcontrol -b | awk '/Battery: /{print $2}'"
            ),
            mouse_callbacks={'Button1': tick_widget},
                            # {"Button1": lazy.widget["genpolltext"].function(lambda w: w.update(w.poll())}
            update_interval=432,
            **decor
        ),
        spacer,
    ]

#     network = [

#        widget.Net
#        (
#            interface="wlp0s20f3",
#            format='{down} ↓↑ {up}',
#        ),
#        spacer
#     ]

    memory = [

        widget.TextBox
        (
            name='memory_icon',
            font="JoyPixels",
            text="🧠",
            fontsize=18,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('mem-icon-click')
            },
            **decor
        ),
        widget.Memory
        (
            measure_mem='G',
            format='{MemUsed:.1f}{mm}',
            update_interval=10,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('mem-text-click')
            },
            **decor
        ),
        spacer
    ]

    thermals = [

        widget.TextBox
        (
            name='thermal_icon',
            font="JoyPixels",
            text="🌡",
            padding=0,
            fontsize=18,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('cpu-icon-click')
            },
            **decor
        ),
        widget.ThermalSensor
        (
            foreground_alert=theme.magenta,
            metric=True,
            threshold=70,
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('cpu-text-click')
            },
            **decor
        ),
        spacer
    ]

    system76 = [

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
            **decor
        ),
        widget.TextBox
        (
            name='indicator',
            text=subprocess.getoutput("cat ~/.cache/power-profile"),
            mouse_callbacks={
                'Button1': lambda: qtile.cmd_spawn('s76-power-base')
            },
            **decor
        ),
        spacer,
    ]

    battery = [

        widget.BatteryIcon
        (
            mouse_callbacks={'Button1': get_bat_percent},
            padding=0,
            **decor
        ),
        widget.Battery
        (
            format='{percent:2.0%}',
            mouse_callbacks={'Button1': get_bat_percent},
            low_foreground=theme.magenta,
            low_percentage=0.20,
            notify_below=0.20,
            **decor
        ),
        spacer,
    ]

    tray = [

        widget.Systray
        (
            icon_size=20,
            padding=4,
            background=theme.bg
        ),
        spacer
    ]

    tray_box = [

        widget.WidgetBox
        (
            widgets=[*tray],
            close_button_location='right',
            font='JoyPixels',
            text_closed='⚙',
            text_open='⚙',
            fontsize=18,
            background=theme.bg,
        ),
        spacer
    ]


widgets_list = [

    *widgets.arco,
    *widgets.basics,
    # widget.OpenWeather(
    #     zip=18328,
    #     format="{main_feels_like}°{weather}",
    #     metric=False,
    # ),
    *widgets.time,
    *widgets.date,
    *widgets.weather,
    *widgets.stocks,
    # *widgets.network,
    *widgets.memory,
    *widgets.thermals,
    *widgets.system76,
    *widgets.keyboard,
    # *widgets.headset,
    *widgets.battery,
    *widgets.tray_box,
]


def init_widgets_screen1():
    widgets_screen1 = widgets_list
    return widgets_screen1


# def init_widgets_screen2():
#     widgets_screen2 = widgets_list
#     return widgets_screen2


widgets_screen1 = init_widgets_screen1()
# widgets_screen2 = init_widgets_screen2()


def init_screens():
    # theme.bg += ".99"
    return [
             Screen(top=bar.Bar(
                widgets=init_widgets_screen1(),
                size=28, background=theme.bg, opacity=.82
             )),

             Screen(top=bar.Bar(
                widgets=[*widgets.basics],
                size=28, background=theme.bg, opacity=.82
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
    subprocess.Popen([home + '/.config/qtile/scripts/autostart.sh'])


@hook.subscribe.startup
def start_always():
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr', 'kbrate'])


@hook.subscribe.startup_complete
def start_after():
    subprocess.Popen([home + '/.config/qtile/scripts/autostart-after.sh'])


@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True


# hook.subscribe.screen_change(qtile.cmd_reconfigure_screens())


floating_types = ["notification", "toolbar", "splash", "dialog"]

follow_mouse_focus = True
bring_front_click = True
cursor_warp = False

floating_layout = layout.Floating(
    float_rules=[

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
    border_focus=theme.arcoblue,
    border_normal=theme.blurple,
)


auto_fullscreen = True
focus_on_window_activation = "focus"  # or smart
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
