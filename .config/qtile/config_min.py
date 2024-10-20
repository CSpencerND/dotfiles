# {{{       IMPORTS        ---
import os
import subprocess

from libqtile import qtile, layout, bar, widget, hook
from libqtile.command import lazy
from libqtile.config import (
    Key, Screen, Group, Drag, Match, ScratchPad, DropDown
)
import groupbox_git
import custom_tasklist

# subprocess.Popen("setup_screens")

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
                "pad", "kitty -e nvim " + home + "/.cache/scratchpad",
                **dropdown_defaults
            ),
            DropDown(
                "term", "kitty",
                **dropdown_defaults
            ),
            DropDown(
                "top", "kitty -e bpytop",
                on_focus_lost_hide=False,
                **dropdown_defaults
            )
        ]
    )
)


# Theme
class themes:
    class dracula:
        black   = '#21222c'
        bg      = '#282a36'
        bgl     = '#383c4a'
        bgla    = '#424450'
        bgls    = '#646672'
        comment = '#6272a4'
        fg      = '#f8f8f2'
        bright  = '#ff79c6'
        main    = '#bd93f9'
        dim     = '#6d5890'
        dima    = '#4d5b86'
        arco    = '#6790eb'
        alt     = '#8be9fd'
        alta    = '#50fa7b'
        soft    = '#f1fa8c'
        warn    = '#ffb86c'
        alert   = '#ff5555'


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
        lazy.layout.grow_left().when(layout='columns'),
        lazy.layout.add().when(layout='matrix'),
    ),
    Key
    (
        [mod, "control"], "j",
        lazy.layout.shrink_main().when(layout='monadtall'),
        lazy.layout.grow_down().when(layout='columns'),
    ),
    Key
    (
        [mod, "control"], "k",
        lazy.layout.grow_main().when(layout='monadtall'),
        lazy.layout.grow_up().when(layout='columns'),
    ),
    Key
    (
        [mod, "control"], "l",
        lazy.layout.grow_main().when(layout='monadtall'),
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
        [mod, "control"], "n",
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
    Key
    (
        [mod], "t",
        lazy.group["scratchpad"].dropdown_toggle("top")
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
        ]
    )


# ---     KEYBINDINGS      }}}
##############################
# {{{       LAYOUTS        ---

layout_theme = {
    "margin": 10,
    "border_width": 2,
    "single_border_width": 2,
    "border_focus": theme.main,
    "border_normal": theme.dima
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
        border_focus_stack=theme.bright,
        **layout_theme
    ),
    layout.Matrix(**layout_theme),
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


def toggle_notif():
    subprocess.Popen(["open_deadd"])


widget_defaults = dict(
    font='Hack Nerd Font',
    fontsize=14,
    padding=3,
    # background=theme.bgla,
    foreground=theme.main,
    borderwidth=2,
    rounded=True,
    urgent_alert_method='text',
    urgent_text=theme.bright,
    urgent_border=theme.bright,
)

spacer = widget.TextBox(text="|", foreground=theme.bgls)

widgets_list = [
    groupbox_git.GroupBox
    # widget.GroupBox
    (
        foreground=theme.fg,
        highlight_method='block',
        unfocused_highlight_method='border',
        borderwidth=1,
        active=theme.fg,
        inactive='#5b5b5b',
        disable_drag=False,
        highlight_color=theme.bgla,  # [theme.main, theme.main],
        this_current_screen_border=theme.main,
        this_screen_border=theme.main,
        other_current_screen_border=theme.alt,
        other_screen_border=theme.alt,
        background=None,
        padding_y=4,
    ),

    widget.CurrentLayoutIcon
    (
        scale=0.7,
        background=None,
    ),

    custom_tasklist.TaskList
    # widget.TaskList
    (
        foreground=theme.fg,
        highlight_method='block',
        icon_size=22,
        txt_floating='🗗 ',
        txt_maximized='🗖 ',
        txt_minimized='🗕 ',
        border=theme.main,
        background=None,
        padding_y=0,
    ),

    spacer,

    widget.TextBox
    (
        foreground=theme.alt,
        font="Weather Icons",
        name='clock_icon',
        text=subprocess.getoutput("cat ~/.cache/clock-icon"),
        fontsize=22,
        mouse_callbacks={
            'Button3': lambda: qtile.cmd_spawn('sb-clock')
        },
    ),

    widget.Clock
    (
        foreground=theme.alt,
        format=" %I:%M%P",
    ),

    spacer,

    widget.TextBox
    (
        name='date_icon',
        text=" ",
        fontsize=17,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('sb-cal')
        },
    ),
    widget.Clock
    (
        format="%a %b %e, %Y",
        update_interval=60,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('sb-cal')
        },
    ),
    spacer,

    widget.TextBox
    (
        foreground=theme.soft,
        font="Weather Icons",
        name='current_icon',
        text=subprocess.getoutput("cat ~/.cache/weather/current_icon"),
        fontsize=18,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('wttr-bttn'),
        },
    ),
    widget.TextBox
    (
        foreground=theme.soft,
        name='current_temp',
        text=subprocess.getoutput("cat ~/.cache/weather/current_temp"),
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('wttr-bttn')
        },
    ),
    widget.TextBox
    (
        foreground=theme.soft,
        name='trend',
        font="Material Icons",
        text=subprocess.getoutput("cat ~/.cache/weather/trend"),
        fontsize=18,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('wttr-bttn'),
            'Button3': lambda: qtile.cmd_spawn('openweather')
        },
    ),
    widget.TextBox
    (
        foreground=theme.soft,
        font="Weather Icons",
        name='forecast_icon',
        text=subprocess.getoutput("cat ~/.cache/weather/forecast_icon"),
        fontsize=18,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('wttr-bttn')
        },
    ),
    widget.TextBox
    (
        foreground=theme.soft,
        name='forecast_temp',
        text=subprocess.getoutput("cat ~/.cache/weather/forecast_temp"),
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('wttr-bttn')
        },
    ),
    spacer,

    widget.StockTicker
    (
        foreground=theme.main,
        apikey='G0BJFWBFWXWJAJ9R',
        symbol='GOOG',
        function='TIME_SERIES_INTRADAY',
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn(
                'firefox https://www.google.com/finance/quote/GOOG:NASDAQ\
                ?sa=X&ved=2ahUKEwja5LDekejyAhWAJTQIHaLjDtwQ3ecFegQIKhAa'
            )
        },
    ),
    spacer,

    widget.TextBox
    (
        foreground=theme.alt,
        name='memory_icon',
        text=" ",
        fontsize=18,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('mem-icon-click')
        },
    ),
    widget.Memory
    (
        foreground=theme.alt,
        measure_mem='G',
        format='{MemUsed:.1f}{mm}',
        update_interval=10,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('mem-text-click')
        },
    ),
    spacer,

    widget.TextBox
    (
        foreground=theme.soft,
        name='thermal_icon',
        text="",
        padding=0,
        fontsize=15,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('cpu-icon-click')
        },
    ),
    widget.ThermalSensor
    (
        foreground=theme.soft,
        foreground_alert=theme.alert,
        metric=True,
        threshold=75,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('cpu-text-click')
        },
    ),
    spacer,

    widget.TextBox
    (
        foreground=theme.alt,
        name='system76',
        text='',
        padding=0,
        fontsize=18,
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('s76-power-base')
        },
    ),
    widget.TextBox
    (
        foreground=theme.alt,
        name='indicator',
        text=subprocess.getoutput("cat ~/.cache/power-profile"),
        mouse_callbacks={
            'Button1': lambda: qtile.cmd_spawn('s76-power-base')
        },
    ),
    spacer,

    widget.TextBox
    (
        text="🎧",
        fontsize=18,
    ),
    widget.GenPollText
    (
        name="headset",
        func=lambda: subprocess.getoutput("cat ~/.cache/headset_percent"),
        mouse_callbacks={'Button1': tick_widget},
        update_interval=108,
    ),
    spacer,

    # widget.BatteryIcon
    # (
    #     mouse_callbacks={'Button1': get_bat_percent},
    #     padding=0,
    # ),

    widget.TextBox
    (
        foreground=theme.alt,
        text="",
        fontsize=22,
    ),
    widget.Battery
    (
        foreground=theme.alt,
        format='{percent:2.0%}',
        mouse_callbacks={'Button1': get_bat_percent},
        low_foreground=theme.bright,
        low_percentage=0.20,
        notify_below=0.20,
    ),
    spacer,

    widget.WidgetBox
    (
        widgets=[
            widget.Systray
            (
                icon_size=20,
                padding=4,
                background=theme.bg
            ),
        ],
        close_button_location='right',
        text_closed='⚙',
        text_open='⚙',
        fontsize=18,
        background=theme.bg,
    ),
    spacer,

    widget.TextBox
    (
        foreground=theme.alt,
        name="notifs",
        text=" ",
        mouse_callbacks={"Button1": toggle_notif},
        background=theme.bg,
    ),
]


def init_screens():
    return [
             Screen(top=bar.Bar(
                widgets=widgets_list,
                size=28, background=theme.bg, opacity=.80, margin=[8, 8, 0, 8]
             )),
             Screen(top=bar.Bar(
                widgets=[
                    groupbox_git.GroupBox
                    # widget.GroupBox
                    (
                        foreground=theme.fg,
                        highlight_method='block',
                        unfocused_highlight_method='border',
                        borderwidth=1,
                        active=theme.fg,
                        inactive='#5b5b5b',
                        disable_drag=False,
                        highlight_color=theme.bgla,  # [theme.main, theme.main],
                        this_current_screen_border=theme.main,
                        this_screen_border=theme.main,
                        other_current_screen_border=theme.alt,
                        other_screen_border=theme.alt,
                        background=None,
                        padding_y=4,
                    )],
                size=28, background=theme.bg, opacity=.80, margin=[8, 8, 0, 8]
             )),
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
        Match(wm_class='qalculate-gtk'),
        Match(title='branchdialog'),
        Match(title='Open File'),
        Match(title='pinentry'),
        Match(func=lambda c: bool(c.is_transient_for()))
    ],

    fullscreen_border_width=0,
    border_width=1,
    border_focus=theme.arco,
    border_normal=theme.dima,
)


auto_fullscreen = True
focus_on_window_activation = "focus"  # or smart
wmname = "LG3D"

# ---        MISC          }}}
