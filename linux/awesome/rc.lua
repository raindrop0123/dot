--@REF: https://awesomewm.org/apidoc/documentation/05-awesomerc.md.html
--@REF: https://wiki.archlinux.org/title/awesome

-- LOAD PACKAGE --
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- ERROR HANDLING --

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({ 
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors 
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don"t go into an endless error loop
    if in_error then return end
    in_error = true
    naughty.notify({ 
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err) 
    })
    in_error = false
  end)
end

-- THEME --
beautiful.init({
  font = "monospace bold 12",
  bg_normal = "#222222",
  bg_focus = "#535d6c",
  bg_urgent = "#ff0000",
  bg_minimize = "#444444",
  bg_systray = "#222222",
  fg_normal = "#aaaaaa",
  fg_focus = "#ffffff",
  fg_urgent = "#ffffff",
  fg_minimize = "#ffffff",
  useless_gap = require("beautiful.xresources").apply_dpi(4),
  border_width = require("beautiful.xresources").apply_dpi(2),
  border_normal = "#000000",
  border_focus = "#535d6c",
  border_marked = "#91231c",
  taglist_squares_sel = require("beautiful.theme_assets").taglist_squares_sel(require("beautiful.xresources").apply_dpi(6), "#aaaaaa"),
  taglist_squares_unsel = require("beautiful.theme_assets").taglist_squares_unsel(require("beautiful.xresources").apply_dpi(6), "#222222"),
  menu_submenu_icon = require("gears.filesystem").get_themes_dir().."default/submenu.png",
  menu_height = require("beautiful.xresources").apply_dpi(30),
  menu_width = require("beautiful.xresources").apply_dpi(200),
  titlebar_close_button_normal = require("gears.filesystem").get_themes_dir().."default/titlebar/close_normal.png",
  titlebar_close_button_focus = require("gears.filesystem").get_themes_dir().."default/titlebar/close_focus.png",
  titlebar_minimize_button_normal = require("gears.filesystem").get_themes_dir().."default/titlebar/minimize_normal.png",
  titlebar_minimize_button_focus  = require("gears.filesystem").get_themes_dir().."default/titlebar/minimize_focus.png",
  titlebar_ontop_button_normal_inactive = require("gears.filesystem").get_themes_dir().."default/titlebar/ontop_normal_inactive.png",
  titlebar_ontop_button_focus_inactive = require("gears.filesystem").get_themes_dir().."default/titlebar/ontop_focus_inactive.png",
  titlebar_ontop_button_normal_active = require("gears.filesystem").get_themes_dir().."default/titlebar/ontop_normal_active.png",
  titlebar_ontop_button_focus_active = require("gears.filesystem").get_themes_dir().."default/titlebar/ontop_focus_active.png",
  titlebar_sticky_button_normal_inactive = require("gears.filesystem").get_themes_dir().."default/titlebar/sticky_normal_inactive.png",
  titlebar_sticky_button_focus_inactive = require("gears.filesystem").get_themes_dir().."default/titlebar/sticky_focus_inactive.png",
  titlebar_sticky_button_normal_active = require("gears.filesystem").get_themes_dir().."default/titlebar/sticky_normal_active.png",
  titlebar_sticky_button_focus_active = require("gears.filesystem").get_themes_dir().."default/titlebar/sticky_focus_active.png",
  titlebar_floating_button_normal_inactive = require("gears.filesystem").get_themes_dir().."default/titlebar/floating_normal_inactive.png",
  titlebar_floating_button_focus_inactive = require("gears.filesystem").get_themes_dir().."default/titlebar/floating_focus_inactive.png",
  titlebar_floating_button_normal_active = require("gears.filesystem").get_themes_dir().."default/titlebar/floating_normal_active.png",
  titlebar_floating_button_focus_active = require("gears.filesystem").get_themes_dir().."default/titlebar/floating_focus_active.png",
  titlebar_maximized_button_normal_inactive = require("gears.filesystem").get_themes_dir().."default/titlebar/maximized_normal_inactive.png",
  titlebar_maximized_button_focus_inactive = require("gears.filesystem").get_themes_dir().."default/titlebar/maximized_focus_inactive.png",
  titlebar_maximized_button_normal_active = require("gears.filesystem").get_themes_dir().."default/titlebar/maximized_normal_active.png",
  titlebar_maximized_button_focus_active = require("gears.filesystem").get_themes_dir().."default/titlebar/maximized_focus_active.png",
  wallpaper = require("gears.filesystem").get_themes_dir().."default/background.png",
  layout_fairh = require("gears.filesystem").get_themes_dir().."default/layouts/fairhw.png",
  layout_fairv = require("gears.filesystem").get_themes_dir().."default/layouts/fairvw.png",
  layout_floating  = require("gears.filesystem").get_themes_dir().."default/layouts/floatingw.png",
  layout_magnifier = require("gears.filesystem").get_themes_dir().."default/layouts/magnifierw.png",
  layout_max = require("gears.filesystem").get_themes_dir().."default/layouts/maxw.png",
  layout_fullscreen = require("gears.filesystem").get_themes_dir().."default/layouts/fullscreenw.png",
  layout_tilebottom = require("gears.filesystem").get_themes_dir().."default/layouts/tilebottomw.png",
  layout_tileleft = require("gears.filesystem").get_themes_dir().."default/layouts/tileleftw.png",
  layout_tile = require("gears.filesystem").get_themes_dir().."default/layouts/tilew.png",
  layout_tiletop = require("gears.filesystem").get_themes_dir().."default/layouts/tiletopw.png",
  layout_spiral = require("gears.filesystem").get_themes_dir().."default/layouts/spiralw.png",
  layout_dwindle = require("gears.filesystem").get_themes_dir().."default/layouts/dwindlew.png",
  layout_cornernw = require("gears.filesystem").get_themes_dir().."default/layouts/cornernww.png",
  layout_cornerne = require("gears.filesystem").get_themes_dir().."default/layouts/cornernew.png",
  layout_cornersw = require("gears.filesystem").get_themes_dir().."default/layouts/cornersww.png",
  layout_cornerse = require("gears.filesystem").get_themes_dir().."default/layouts/cornersew.png",
  awesome_icon = require("beautiful.theme_assets").awesome_icon(require("beautiful.xresources").apply_dpi(30), "#535d6c", "#ffffff"),
  icon_theme = nil,
})

-- VARIABLE DEFINITION --

terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal.." -e "..editor

-- Mod Key: Mod1=alt, Mod4=windows_key
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  -- awful.layout.suit.floating,
  awful.layout.suit.tile,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}

-- MENU --
-- Create a launcher widget and a main menu
myawesomemenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}
mymainmenu = awful.menu({
  items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", terminal }
  }
})
mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal

-- WIBAR --

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end))

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal(
        "request::activate",
        "tasklist",
        { raise = true }
      )
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
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
    -- gears.wallpaper.set("#000000") -- set pure color background
  end
end

-- Re-set wallpaper when a screen"s geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we"re using.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.noempty,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist{
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({
    height = 24,
    position = "top",
    screen = s,
  })

  -- Add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,
    -- Left Widgets
    {
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      s.mypromptbox,
    },
    -- Middle Widgets
    s.mytasklist,
    -- Right Widgets
    {
      layout = wibox.layout.fixed.horizontal,
      awful.widget.watch([[bash -c "echo [CPU $(top -bn1 | grep Cpu | awk '{print $2}')%]"]], 2),
      awful.widget.watch([[bash -c "echo [MEM $(echo $(free -h | grep Mem) | awk '{print $3}')]"]], 2),
      awful.widget.watch([[bash -c "echo [BAT $(cat /sys/class/power_supply/BAT1/capacity)%]"]], 120),
      awful.widget.watch([[bash -c "echo [VOL $(echo $(amixer sget Master | grep -o -E '[0-9]+%' | head -1))]"]], 2),
      awful.widget.watch([[bash -c "echo [$(date +%Y-%m-%d\ %H:%M)]"]], 60),
      wibox.widget.systray(),
      s.mylayoutbox,
    },
  })
end)

-- MOUSE BINDING --
root.buttons(gears.table.join(
  awful.button({}, 3, function () mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))

-- KEY BINDING --
globalkeys = gears.table.join(
  awful.key({ modkey }, "s", hotkeys_popup.show_help,
    { description = "show help", group = "awesome"}),
  awful.key({ modkey }, "j",
    function ()
      awful.client.focus.byidx(1)
    end,
    { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k",
    function ()
      awful.client.focus.byidx(-1)
    end,
    { description = "focus previous by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
    { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
    { description = "swap with previous client by index", group = "client" }),
  -- awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(1) end,
  --           { description = "focus the next screen", group = "screen" }),
  -- awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
  --           { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey, "Shift" }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "e", awesome.quit,
    { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end,
    { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
    { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey }, "Tab", function () awful.layout.inc(1) end,
    { description = "select next", group = "layout" }),
  awful.key({ modkey }, "space", function () awful.screen.focused().mypromptbox:run() end,
    { description = "run prompt", group = "launcher "}),
  awful.key({ modkey, "Shift" }, "space", function() menubar.show() end,
    { description = "show the menubar", group = "launcher" }),
  awful.key({}, "XF86MonBrightnessUp", function() awful.util.spawn("brightnessctl s +5%") end,
    { description = "Raise Monitor Backlight", group = "XF86" }),
  awful.key({}, "XF86MonBrightnessDown", function() awful.util.spawn("brightnessctl s 5%-") end,
    { description = "Lower Monitor Backlight", group = "XF86" }),
  awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer sset Master 3%+") end,
    { description = "Raise Volume", group = "XF86" }),
  awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("amixer sset Master 3%-") end,
    { description = "Lower Volume", group = "XF86" }),
  awful.key({}, "XF86AudioMute", function() awful.util.spawn("amixer sset Master 1+ toggle") end,
    { description = "Toggle Volume", group = "XF86" }))

clientkeys = gears.table.join(
  awful.key({ modkey }, "f",
    function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, "Shift" }, "q", function(c) c:kill() end,
    { description = "close", group = "client" }))

for i = 1, 10 do
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
      { description = "view tag #"..i, group = "tag" }),
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
      { description = "move focused client to tag #"..i, group = "tag" }))
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end))
-- Set keys
root.keys(globalkeys)

-- RULE --
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { 
    rule = {},
    properties = { 
      border_width = beautiful.border_width,
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
  { 
    rule_any = {
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

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester",  -- xev.
      },
      role = {
        "AlarmWindow",  -- Thunderbird"s calendar.
        "ConfigManager",  -- Thunderbird"s about:config.
        "pop-up",       -- e.g. Google Chrome"s (detached) Developer Tools.
      }
    },
    properties = {
      floating = true
    }
  },

  -- Add titlebars to normal clients and dialogs
  { 
    rule_any = {
      type = {
        "normal",
        "dialog",
      }
    },
    properties = {
      titlebars_enabled = true
    }
  },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  {
    rule = {
      class = "Firefox"
    },
    properties = {
      screen = 1,
      tag = "2"
    }
  },
}

-- SIGNAL --
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end))

  awful.titlebar(c, { size = 24 }):setup({
    -- Left
    {
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal
    },
    -- Middle
    {
      -- Title
      {
        align = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal
    },
    -- Right
    {
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  })
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- AUTOSTART --
awful.spawn.with_shell("xclip")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("flameshot")
awful.spawn.with_shell("ibus-daemon -drxR")
awful.spawn.with_shell("[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources")

-- GARBAGE COLLECTION --
gears.timer({
  timeout = 30,
  autostart = true,
  callback = function()
    collectgarbage()
  end,
})
