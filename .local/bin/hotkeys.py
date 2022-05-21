#!/usr/bin/env python

import gi

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk
from gi.repository import Gdk

black   = '#21222c'
bg      = '#282a36'
bgl     = '#383c4a'
bgla    = '#424450'
fade    = '#6272a4'
fg      = '#f8f8f2'
pink    = '#ff79c6'
purple  = '#bd93f9'
cyan    = '#8be9fd'
green   = '#50fa7b'
yellow  = '#f1fa8c'
orange  = '#ffb86c'

title   = fg
mods    = orange
key     = fg
sep     = bgla
head    = yellow
special = pink

# mod     = "❖"
# shift   = "⇪"
# ctrl    = "⌃"
# alt     = "⌥"

mod     = "Mod"
shift   = "Shf"
ctrl    = "Ctl"
alt     = "Alt"

class Main(Gtk.Window):
    def __init__(self):
        super().__init__(title="Hotkey Helper")

        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_resizable(False)


        ### TITLEBAR ---------------------------------------------------------------------------------------------------------
        bar = Gtk.HeaderBar()
        bar.set_show_close_button(True)
        bar.props.title = "Hotkey Helper - Toggle with Mod + Space"
        self.set_titlebar(bar)


        # KEYBINDS -----------------------------------------------------------------------------------------------------------
        ### window move ------------------------------------------------------------------------------------------------------
        focus_clients = Gtk.Label(xalign=0)
        focus_clients.set_markup(
            f"<span color='{title}'>Focus Clients</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>J</span><span color='{sep}'> / </span><span color='{key}'>K</span>"
        )

        rotate_clients = Gtk.Label(xalign=0)
        rotate_clients.set_markup(
            f"<span color='{title}'>Rotate Clients</span>\n" +
            f"<span color='{mods}'>{shift}</span><span color='{sep}'> + </span><span color='{key}'>J</span><span color='{sep}'> / </span><span color='{key}'>K</span>"
        )

        move_clients = Gtk.Label(xalign=0)
        move_clients.set_markup(
            f"<span color='{title}'>Move Clients</span>\n" +
            f"<span color='{mods}'>{ctrl}</span><span color='{sep}'> + </span><span color='{key}'>J</span><span color='{sep}'> / </span><span color='{key}'>K</span>"
        )


        ### window resize ------------------------------------------------------------------------------------------------------
        resize_horiz = Gtk.Label(xalign=0)
        resize_horiz.set_markup(
            f"<span color='{title}'>Resize Horizontal</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>H</span><span color='{sep}'> / </span><span color='{key}'>L</span>"
        )

        resize_verti = Gtk.Label(xalign=0)
        resize_verti.set_markup(
            f"<span color='{title}'>Resize Vertical</span>\n" +
            f"<span color='{mods}'>{ctrl}</span><span color='{sep}'> + </span><span color='{key}'>H</span><span color='{sep}'> / </span><span color='{key}'>L</span>"
        )

        resize_reset = Gtk.Label(xalign=0)
        resize_reset .set_markup(
            f"<span color='{title}'>Normalize Size</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>N</span>"
        )


        ### window control ------------------------------------------------------------------------------------------------------
        maximise = Gtk.Label(xalign=0)
        maximise.set_markup(
            f"<span color='{title}'>Toggle Maximise</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>M</span>"
        )

        fullscreen = Gtk.Label(xalign=0)
        fullscreen.set_markup(
            f"<span color='{title}'>Toggle Fullscreen</span>\n" +
            f"<span color='{mods}'>{shift}</span><span color='{sep}'> + </span><span color='{key}'>M</span>"
        )

        floating = Gtk.Label(xalign=0)
        floating.set_markup(
            f"<span color='{title}'>Toggle Floating</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>F</span>"
        )

        skippy = Gtk.Label(xalign=0)
        skippy.set_markup(
            f"<span color='{title}'>Exposé</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>V</span>"
        )


        ### shift tools ----------------------------------------------------------------------------------------------------------
        focus_tag_right = Gtk.Label(xalign=0)
        focus_tag_right.set_markup(
            f"<span color='{title}'>Focus Tag Right</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>I</span><span color='{sep}'> / </span><span color='{key}'>Tab</span>"
        )

        focus_tag_left = Gtk.Label(xalign=0)
        focus_tag_left.set_markup(
            f"<span color='{title}'>Focus Tag Left</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>U</span><span color='{sep}'> / </span><span color='{mods}'>{shift}</span><span color='{sep}'> + </span><span color='{key}'>Tab</span>"
        )

        client_tag = Gtk.Label(xalign=0)
        client_tag.set_markup(
            f"<span color='{title}'>Shift To Tag</span>\n" +
            f"<span color='{mods}'>{shift}</span><span color='{sep}'> + </span><span color='{key}'>I</span><span color='{sep}'> / </span><span color='{key}'>U</span>"
        )

        tag_and_go = Gtk.Label(xalign=0)
        tag_and_go.set_markup(
            f"<span color='{title}'>Shift &amp; Go Tag</span>\n" +
            f"<span color='{mods}'>{ctrl}</span><span color='{sep}'> + </span><span color='{key}'>I</span><span color='{sep}'> / </span><span color='{key}'>U</span>"
        )

        swap_tags = Gtk.Label(xalign=0)
        swap_tags.set_markup(
            f"<span color='{title}'>Swap Tags</span>\n" +
            f"<span color='{mods}'>{alt}</span><span color='{sep}'> + </span><span color='{key}'>I</span><span color='{sep}'> / </span><span color='{key}'>U</span>"
        )


        ### monitors --------------------------------------------------------------------------------------------------------------
        focus_mon = Gtk.Label(xalign=0)
        focus_mon.set_markup(
            f"<span color='{title}'>Focus Monitor</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>&gt;</span><span color='{sep}'> / </span><span color='{key}'>&lt;</span>"
        )

        client_mon = Gtk.Label(xalign=0)
        client_mon.set_markup(
            f"<span color='{title}'>Shift To Monitor</span>\n" +
            f"<span color='{mods}'>{shift}</span><span color='{sep}'> + </span><span color='{key}'>&gt;</span><span color='{sep}'> / </span><span color='{key}'>&lt;</span>"
        )

        mon_and_go = Gtk.Label(xalign=0)
        mon_and_go.set_markup(
            f"<span color='{title}'>Shift &amp; Go Monitor</span>\n" +
            f"<span color='{mods}'>{shift}</span><span color='{sep}'> + </span><span color='{key}'>&gt;</span><span color='{sep}'> / </span><span color='{key}'>&lt;</span>"
        )

        swap_mons = Gtk.Label(xalign=0)
        swap_mons.set_markup(
            f"<span color='{title}'>Swap Monitors</span>\n" +
            f"<span color='{mods}'>{shift}</span><span color='{sep}'> + </span><span color='{key}'>&gt;</span><span color='{sep}'> / </span><span color='{key}'>&lt;</span>"
        )

        toggle_bar = Gtk.Label(xalign=0)
        toggle_bar.set_markup(
            f"<span color='{title}'>Toggle Bar</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>B</span>"
        )


        ### layouts --------------------------------------------------------------------------------------------------------------
        cycle_layout = Gtk.Label(xalign=0)
        cycle_layout.set_markup(
            f"<span color='{title}'>Cycle Layouts</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>]</span><span color='{sep}'> / </span><span color='{key}'>[</span>"
        )

        n_master = Gtk.Label(xalign=0)
        n_master.set_markup(
            f"<span color='{title}'>Increment Master</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>+</span><span color='{sep}'> / </span><span color='{key}'>-</span>"
        )

        sticky = Gtk.Label(xalign=0)
        sticky.set_markup(
            f"<span color='{title}'>Sticky Client</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>S</span>"
        )


        ### launchers ------------------------------------------------------------------------------------------------------------
        rofi = Gtk.Label(xalign=0)
        rofi.set_markup(
            f"<span color='{title}'>Run Launcher</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>Slash</span>"
        )
        
        terminal = Gtk.Label(xalign=0)
        terminal.set_markup(
            f"<span color='{title}'>Terminal</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>Return</span>"
        )
        
        various = Gtk.Label(xalign=0)
        various.set_markup(
            f"<span color='{head}'>Leader Key</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>G</span><span color='{special}'>   then</span>\n\n" +
            f"<span color='{title}'>Browser</span><span color='{sep}'>   - </span><span color='{mods}'>W</span>\n\n" +
            f"<span color='{title}'>Discord</span><span color='{sep}'>   - </span><span color='{mods}'>D</span>\n\n" +
            f"<span color='{title}'>Volume</span><span color='{sep}'>    - </span><span color='{mods}'>V</span>\n\n" +
            f"<span color='{title}'>Bluetooth</span><span color='{sep}'> - </span><span color='{mods}'>B</span>\n\n" +
            f"<span color='{title}'>Picom</span><span color='{sep}'>     - </span><span color='{mods}'>P</span>"
        )


        ### scratchpads --------------------------------------------------------------------------------------------------------
        spterm = Gtk.Label(xalign=0)
        spterm.set_markup(
            f"<span color='{title}'>Terminal</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>Apostrophe</span>"
        )
        
        spvim = Gtk.Label(xalign=0)
        spvim.set_markup(
            f"<span color='{title}'>Notes</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>Semicolon</span>"
        )
        
        sptop = Gtk.Label(xalign=0)
        sptop.set_markup(
            f"<span color='{title}'>Tasks</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>T</span>"
        )
        
        spranger = Gtk.Label(xalign=0)
        spranger.set_markup(
            f"<span color='{title}'>Files</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>O</span>"
        )
        
        spdynamic = Gtk.Label(xalign=0)
        spdynamic.set_markup(
            f"<span color='{head}'>Dynamic</span><span color='{sep}'> - </span><span color='{mods}'>P</span><span color='{special}'>   with</span>\n" +
            f"<span color='{mods}'>Mod</span><span color='{sep}'>    / </span><span color='{mods}'>Ctl</span><span color='{sep}'> / </span><span color='{mods}'>Alt</span>\n" +
            f"<span color='{key}'>Toggle</span><span color='{sep}'> / </span><span color='{key}'>Set</span><span color='{sep}'> / </span><span color='{key}'>Remove</span>"
        )


        ### miscellaneous ------------------------------------------------------------------------------------------------------
        kill_client = Gtk.Label(xalign=0)
        kill_client.set_markup(
            f"<span color='{title}'>Close Client</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>C</span>"
        )

        power_menu = Gtk.Label(xalign=0)
        power_menu.set_markup(
            f"<span color='{title}'>Power Menu</span>\n" +
            f"<span color='{mods}'>{mod}</span><span color='{sep}'> + </span><span color='{key}'>X</span>"
        )

        logout = Gtk.Label(xalign=0)
        logout.set_markup(
            f"<span color='{title}'>Logout</span>\n" +
            f"<span color='{mods}'>{shift}</span><span color='{sep}'> + </span><span color='{key}'>X</span>"
        )

        reload = Gtk.Label(xalign=0)
        reload.set_markup(
            f"<span color='{title}'>Reload</span>\n" +
            f"<span color='{mods}'>{shift}</span><span color='{sep}'> + </span><span color='{key}'>R</span>"
        )


        ### HEADINGS -----------------------------------------------------------------------------------------------------------
        nav_head = Gtk.Label(xalign=0, yalign=0)
        nav_head.set_markup(f"<span color='{head}'><b><u>Navigation</u></b></span>")

        delig_head = Gtk.Label(xalign=0, yalign=0)
        delig_head.set_markup(f"<span color='{head}'><b><u>Deligation</u></b></span>")

        combo_head = Gtk.Label(xalign=0, yalign=0)
        combo_head.set_markup(f"<span color='{head}'><b><u>Combination</u></b></span>")

        layout_head = Gtk.Label(xalign=0, yalign=0)
        layout_head.set_markup(f"<span color='{head}'><b><u>Layout</u></b></span>")

        launchers_head = Gtk.Label(xalign=0, yalign=0)
        launchers_head.set_markup(f"<span color='{head}'><b><u>Launchers</u></b></span>")

        scratchpads_head = Gtk.Label(xalign=0, yalign=0)
        scratchpads_head.set_markup(f"<span color='{head}'><b><u>Scratchpads</u></b></span>")

        miscellaneous_head = Gtk.Label(xalign=0, yalign=0)
        miscellaneous_head.set_markup(f"<span color='{head}'><b><u>Miscellaneous</u></b></span>")


        ### CATEGORIES -------------------------------------------------------------------------------------------------------
        navigation = Gtk.VBox()
        navigation.add(nav_head)
        navigation.add(focus_clients)
        navigation.add(focus_tag_right)
        navigation.add(focus_tag_left)
        navigation.add(focus_mon)
        navigation.add(skippy)

        deligation = Gtk.VBox()
        deligation.add(delig_head)
        deligation.add(move_clients)
        deligation.add(rotate_clients)
        deligation.add(client_tag)
        deligation.add(client_mon)

        combination = Gtk.VBox()
        combination.add(combo_head)
        combination.add(tag_and_go)
        combination.add(mon_and_go)
        combination.add(swap_tags)
        combination.add(swap_mons)

        launchers = Gtk.VBox()
        launchers.add(launchers_head)
        launchers.add(rofi)
        launchers.add(terminal)
        launchers.add(various)

        scratchpads = Gtk.VBox()
        scratchpads.add(scratchpads_head)
        scratchpads.add(spterm)
        scratchpads.add(spvim)
        scratchpads.add(sptop)
        scratchpads.add(spranger)
        scratchpads.add(spdynamic)

        edit_layout = Gtk.VBox()
        edit_layout.add(layout_head)
        edit_layout.add(cycle_layout)
        edit_layout.add(resize_horiz)
        edit_layout.add(resize_verti)
        edit_layout.add(resize_reset)
        edit_layout.add(maximise)
        edit_layout.add(fullscreen)
        edit_layout.add(floating)
        edit_layout.add(sticky)
        edit_layout.add(n_master)

        misc_box = Gtk.VBox()
        misc_box.add(miscellaneous_head)
        misc_box.add(kill_client)
        misc_box.add(power_menu)
        misc_box.add(logout)
        misc_box.add(reload)
        misc_box.add(toggle_bar)

        ### LAYOUT -------------------------------------------------------------------------------------------------------------
        layout = Gtk.Grid()
        # layout.set_column_homogeneous(True)
        # layout.set_row_homogeneous(True)
        layout.attach(navigation,     0, 0, 1, 1)
        layout.attach(deligation,     1, 0, 1, 1)
        layout.attach(combination,    2, 0, 1, 1)
        layout.attach(launchers,      0, 1, 1, 1)
        layout.attach(scratchpads,    1, 1, 1, 1)
        layout.attach(misc_box,       2, 1, 1, 1)
        layout.attach(edit_layout,    3, 0, 1, 2)

        self.add(layout)

        css = b'* { font-family: Hack Nerd Font; } grid * { padding: 5px; font-size: 16px;}'
        css_provider = Gtk.CssProvider()
        css_provider.load_from_data(css)
        context = Gtk.StyleContext()
        screen = Gdk.Screen.get_default()
        context.add_provider_for_screen(screen, css_provider,
                                        Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION)


if __name__ == "__main__":
    w = Main()
    w.connect("destroy", Gtk.main_quit)
    w.show_all()
    Gtk.main()
