-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Extra
require("collision")()
local revelation=require("revelation")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}



-- {{{ Variable definitions
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "dracula.lua")
revelation.init()

-- Use correct status icon size
awesome.set_preferred_icon_size(24)

-- Enable gaps
beautiful.useless_gap = 6
beautiful.gap_single_client = true

-- Fix window snapping
awful.mouse.snap.edge_enabled = false

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
  }
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
    mymainmenu = freedesktop.menu.build({
        before = { menu_awesome },
        after =  { menu_terminal }
    })
else
    mymainmenu = awful.menu({
        items = {
                  menu_awesome,
                  { "Debian", debian.menu.Debian_menu.Debian },
                  menu_terminal,
                }
    })
end


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))


local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end


-- #######################################
-- ##                                   ##
-- ##              Widgets              ##
-- ##                                   ##
-- #######################################
-- {{{
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Create systray
    s.systray = wibox.widget.systray()

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mylayoutbox,
            -- s.mypromptbox,
        },

        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mytextclock,
            s.systray,
            -- mykeyboardlayout,
        },
    }
end)
-- }}}



-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}


-- #######################################
-- ##                                   ##
-- ##        Global Key Bindings        ##
-- ##                                   ##
-- #######################################
-- {{{
globalkeys = gears.table.join(
    awful.key
    (
      { }, "XF86MonBrightnessUp",
      function () awful.spawn("sudo brightnessctl -s +5%") end,
      {description = "Brightness Up", group = "Function"}
    ),

    awful.key
    (
      { }, "XF86MonBrightnessDown",
      function () awful.spawn("sudo brightnessctl -s 5%-") end,
      {description = "Brightness Down", group = "Function"}
    ),

    -- Switch Tags
    awful.key({ modkey, "Control" }, "k",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey, "Control" }, "j",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),

    -- Switch Screens
    awful.key({ modkey          }, "Tab", function () awful.screen.focus_relative( 1)    end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Shift" }, "Tab", function () awful.screen.focus_relative(-1)    end,
              {description = "focus the previous screen", group = "screen"}),

    -- Resize Master Window
    awful.key({ modkey,         }, "l",     function () awful.tag.incmwfact( 0.05)       end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,         }, "h",     function () awful.tag.incmwfact(-0.05)       end,
              {description = "decrease master width factor", group = "layout"}),

    -- Set Number of Columns
    awful.key({ modkey, "Shift" }, "n",     function () awful.tag.incncol( 1, nil, true) end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey,         }, "n",     function () awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of columns", group = "layout"}),

    -- Restart or Logout Awesome
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "x", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    -- Show Key Bindings
    awful.key({ modkey          }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    -- Explode All Windows
    awful.key({ modkey          }, "grave",   revelation,
              {description = "explode windows", group = "awesome"}),

    -- Swap layout
    awful.key({ modkey          }, "space", function () awful.layout.inc( 1)             end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1)             end,
              {description = "select previous", group = "layout"}),


-- #######################################
-- ##                                   ##
-- ##        Launch Application         ##
-- ##                                   ##
-- #######################################
    -- Terminal
    awful.key({ modkey, }, "Return",    function () awful.spawn(terminal)                end,
              {description = "open a terminal", group = "launcher"}),
    -- Rofi
    awful.key({ modkey, }, "slash", function () awful.util.spawn("rofi -show run")        end,
              {description = "rofi launcher", group = "launcher"}),
    -- Browser
    awful.key({ modkey, }, "b", function () awful.util.spawn("firefox")          end,
              {description = "firefox launcher", group = "launcher"})
)


-- #######################################
-- ##                                   ##
-- ##        Client Key Bindings        ##
-- ##                                   ##
-- #######################################
clientkeys = gears.table.join(

    -- Minimize, Maximize, Fullscreen
    awful.key({ modkey          }, "m", function (c)
              c.minimized = true end,
              {description = "minimize", group = "client"}),
    awful.key({ modkey, "Shift" }, "m", function (c)
              c.fullscreen = not c.fullscreen c:raise() end,
              {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift", "Control"  }, "m", function (c)
              c.maximized = not c.maximized c:raise() end,
              {description = "(un)maximize", group = "client"}),

    -- Kill the focused window
    awful.key({ modkey          }, "c",  function (c) c:kill() end,
              {description = "close window", group = "client"}),

    -- Toggle Floating the focused window
    awful.key({ modkey,         }, "f",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),

    -- Focus window by index
    awful.key({ modkey,           }, "j", function ()
      awful.client.focus.byidx( 1) end,
      {description = "focus next index", group = "client"}),

    awful.key({ modkey,           }, "k", function ()
      awful.client.focus.byidx(-1) end,
      {description = "focus next index", group = "client"}),

    -- Moving windows
    awful.key({ modkey, "Shift"   }, "h", function (c)
      awful.client.swap.global_bydirection("left") c:raise() end,
      {description = "swap with left client", group = "client"}),

    awful.key({ modkey, "Shift"   }, "l", function (c)
      awful.client.swap.global_bydirection("right") c:raise() end,
      {description = "swap with right client", group = "client"}),

    awful.key({ modkey, "Shift"   }, "j", function (c)
      awful.client.swap.global_bydirection("down") c:raise() end,
      {description = "swap with down client", group = "client"}),

    awful.key({ modkey, "Shift"   }, "k", function (c)
      awful.client.swap.global_bydirection("up") c:raise() end,
      {description = "swap with up client", group = "client"}),

-- #######################################
-- ##                                   ##
-- ##   Floating Client Key Bindings    ##
-- ##                                   ##
-- #######################################
    -- Resize floating windows
    awful.key({ modkey, "Control" }, "Up", function (c)
      if c.floating then
        c:relative_move( 0, 0, 0, -10)
      else
        awful.client.incwfact(0.025)
      end
    end,
    {description = "Floating Resize Vertical -", group = "client"}),
    awful.key({ modkey, "Control" }, "Down", function (c)
      if c.floating then
        c:relative_move( 0, 0, 0,  10)
      else
        awful.client.incwfact(-0.025)
      end
    end,
    {description = "Floating Resize Vertical +", group = "client"}),
    awful.key({ modkey, "Control" }, "Left", function (c)
      if c.floating then
        c:relative_move( 0, 0, -10, 0)
      else
        awful.tag.incmwfact(-0.025)
      end
    end,
    {description = "Floating Resize Horizontal -", group = "client"}),
    awful.key({ modkey, "Control" }, "Right", function (c)
      if c.floating then
        c:relative_move( 0, 0,  10, 0)
      else
        awful.tag.incmwfact(0.025)
      end
    end,
    {description = "Floating Resize Horizontal +", group = "client"}),

    -- Moving floating windows
    awful.key({ modkey, "Shift"   }, "Down", function (c)
      c:relative_move(  0,  10,   0,   0) end,
    {description = "Floating Move Down", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Up", function (c)
      c:relative_move(  0, -10,   0,   0) end,
    {description = "Floating Move Up", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Left", function (c)
      c:relative_move(-10,   0,   0,   0) end,
    {description = "Floating Move Left", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right", function (c)
      c:relative_move( 10,   0,   0,   0) end,
    {description = "Floating Move Right", group = "client"})
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end



-- Control floating windows with mouse
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)



-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },

        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },

        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    { rule_any = { type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },
}
-- }}}



-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Functions
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


-- #######################################
-- ##                                   ##
-- ## User Defined Startup Applications ##
-- ##                                   ##
-- #######################################

awful.spawn.with_shell("picom -b --experimental-backends")
awful.spawn.with_shell("nitrogen --set-zoom-fill --random ~/.local/share/backgrounds")
awful.spawn.with_shell("variety")
awful.spawn.with_shell("pactl load-module module-alsa-sink device=hw:1,1")

awful.spawn.with_shell("cbatticon")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("volumeicon")
awful.spawn.with_shell("copyq")
awful.spawn.with_shell("solaar -b solaar -w hide")

awful.spawn.with_shell("/usr/bin/com.system76.FirmwareManager.Notify")
awful.spawn.with_shell("/usr/bin/pop-upgrade release check")
awful.spawn.with_shell("sudo system76-power charge-thresholds --profile max_lifespan")
awful.spawn.with_shell("sudo ifconfig enp35s0 down")

-- awful.spawn.with_shell("/home/cs/.local/bin/polyscr/polystart.sh")
awful.spawn.with_shell("discord")
awful.spawn.with_shell("/home/$USER/.local/bin/kbconfig")

-- Customize
-- beautiful.useless_gap = 5
-- beautiful.font = "Hack Nerd Font:size=12"
-- beautiful.border_width = 2
-- beautiful.border_focus = "#BD93F9"

