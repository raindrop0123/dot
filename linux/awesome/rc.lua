-- https://awesomewm.org/apidoc/documentation/05-awesomerc.md.html

-- Check weather luarocks is installed?
pcall(require, "luarocks.loader")

-- Standard awesomeWM library
local gears = require("gears") local awful = require("awful")
require("awful.autofocus")

-- Widget and Layout library
local wibox = require("wibox")

-- Theme library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")

-- Menu library
local menubar = require("menubar")

-- Hotkey library
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Error Handling

-- Check if awesome encountered an error during startup and fell back to another config.
-- This code will only ever execute for the fallback config.
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "There were errors during startup!",
    text = awesome.startup_errors
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    -- Make sure we don"t go into an endless error loop
    if in_error then return end
    in_error = true
    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "An error happened!",
      text = tostring(err)
    })
    in_error = false
  end)
end

-- Theme
beautiful.init({
  font = "VictorMono Nerd Font Bold 14",
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
  border_width = require("beautiful.xresources").apply_dpi(4),
  border_normal = "#000000",
  border_focus = "#535d6c",
  border_marked = "#91231c",
  taglist_squares_sel = require("beautiful.theme_assets").taglist_squares_sel(require("beautiful.xresources").apply_dpi(0), "#aaaaaa"),
  taglist_squares_unsel = require("beautiful.theme_assets").taglist_squares_unsel(require("beautiful.xresources").apply_dpi(0), "#222222"),
  menu_submenu_icon = require("gears.filesystem").get_themes_dir() .. "default/submenu.png",
  menu_height = require("beautiful.xresources").apply_dpi(30),
  menu_width = require("beautiful.xresources").apply_dpi(200),
  titlebar_close_button_normal = require("gears.filesystem").get_themes_dir() .. "default/titlebar/close_normal.png",
  titlebar_close_button_focus = require("gears.filesystem").get_themes_dir() .. "default/titlebar/close_focus.png",
  titlebar_minimize_button_normal = require("gears.filesystem").get_themes_dir() .. "default/titlebar/minimize_normal.png",
  titlebar_minimize_button_focus  = require("gears.filesystem").get_themes_dir() .. "default/titlebar/minimize_focus.png",
  titlebar_ontop_button_normal_inactive = require("gears.filesystem").get_themes_dir() .. "default/titlebar/ontop_normal_inactive.png",
  titlebar_ontop_button_focus_inactive = require("gears.filesystem").get_themes_dir() .. "default/titlebar/ontop_focus_inactive.png",
  titlebar_ontop_button_normal_active = require("gears.filesystem").get_themes_dir() .. "default/titlebar/ontop_normal_active.png",
  titlebar_ontop_button_focus_active = require("gears.filesystem").get_themes_dir() .. "default/titlebar/ontop_focus_active.png",
  titlebar_sticky_button_normal_inactive = require("gears.filesystem").get_themes_dir() .. "default/titlebar/sticky_normal_inactive.png",
  titlebar_sticky_button_focus_inactive = require("gears.filesystem").get_themes_dir() .. "default/titlebar/sticky_focus_inactive.png",
  titlebar_sticky_button_normal_active = require("gears.filesystem").get_themes_dir() .. "default/titlebar/sticky_normal_active.png",
  titlebar_sticky_button_focus_active = require("gears.filesystem").get_themes_dir() .. "default/titlebar/sticky_focus_active.png",
  titlebar_floating_button_normal_inactive = require("gears.filesystem").get_themes_dir() .. "default/titlebar/floating_normal_inactive.png",
  titlebar_floating_button_focus_inactive = require("gears.filesystem").get_themes_dir() .. "default/titlebar/floating_focus_inactive.png",
  titlebar_floating_button_normal_active = require("gears.filesystem").get_themes_dir() .. "default/titlebar/floating_normal_active.png",
  titlebar_floating_button_focus_active = require("gears.filesystem").get_themes_dir() .. "default/titlebar/floating_focus_active.png",
  titlebar_maximized_button_normal_inactive = require("gears.filesystem").get_themes_dir() .. "default/titlebar/maximized_normal_inactive.png",
  titlebar_maximized_button_focus_inactive = require("gears.filesystem").get_themes_dir() .. "default/titlebar/maximized_focus_inactive.png",
  titlebar_maximized_button_normal_active = require("gears.filesystem").get_themes_dir() .. "default/titlebar/maximized_normal_active.png",
  titlebar_maximized_button_focus_active = require("gears.filesystem").get_themes_dir() .. "default/titlebar/maximized_focus_active.png",
  wallpaper = require("gears.filesystem").get_themes_dir() .. "default/background.png",
  layout_fairh = require("gears.filesystem").get_themes_dir() .. "default/layouts/fairhw.png",
  layout_fairv = require("gears.filesystem").get_themes_dir() .. "default/layouts/fairvw.png",
  layout_floating  = require("gears.filesystem").get_themes_dir() .. "default/layouts/floatingw.png",
  layout_magnifier = require("gears.filesystem").get_themes_dir() .. "default/layouts/magnifierw.png",
  layout_max = require("gears.filesystem").get_themes_dir() .. "default/layouts/maxw.png",
  layout_fullscreen = require("gears.filesystem").get_themes_dir() .. "default/layouts/fullscreenw.png",
  layout_tilebottom = require("gears.filesystem").get_themes_dir() .. "default/layouts/tilebottomw.png",
  layout_tileleft = require("gears.filesystem").get_themes_dir() .. "default/layouts/tileleftw.png",
  layout_tile = require("gears.filesystem").get_themes_dir() .. "default/layouts/tilew.png",
  layout_tiletop = require("gears.filesystem").get_themes_dir() .. "default/layouts/tiletopw.png",
  layout_spiral = require("gears.filesystem").get_themes_dir() .. "default/layouts/spiralw.png",
  layout_dwindle = require("gears.filesystem").get_themes_dir() .. "default/layouts/dwindlew.png",
  layout_cornernw = require("gears.filesystem").get_themes_dir() .. "default/layouts/cornernww.png",
  layout_cornerne = require("gears.filesystem").get_themes_dir() .. "default/layouts/cornernew.png",
  layout_cornersw = require("gears.filesystem").get_themes_dir() .. "default/layouts/cornersww.png",
  layout_cornerse = require("gears.filesystem").get_themes_dir() .. "default/layouts/cornersew.png",
  awesome_icon = require("beautiful.theme_assets").awesome_icon(require("beautiful.xresources").apply_dpi(30), "#535d6c", "#ffffff"),
  icon_theme = nil,
})

-- Modkey
modkey = "Mod1"

-- Layout
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  awful.layout.suit.corner.ne,
  awful.layout.suit.corner.sw,
  awful.layout.suit.corner.se,
  awful.layout.suit.floating,
}

-- Menu

-- Submenu: awesome
awesomemenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", "xterm man awesome" },
  { "edit config", "xterm vim " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

-- Submenu: editor
editormenu = {
  { "Emacs", "emacs" },
  { "vim", "xterm vim" },
  { "neovim", "xterm nvim" },
}

-- Main Menu
mainmenu = awful.menu({
  items = {
    { " AwesomeWM ", awesomemenu, beautiful.awesome_icon },
    { " Terminal ", "xterm" },
    { " Editor ", editormenu },
  }
})

-- Launcher
launcher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mainmenu
})

-- Menubar configuration
menubar.utils.terminal = "xterm"

-- wibar

-- Wallpaper setup
local function set_wallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    -- gears.wallpaper.maximized(wallpaper, s, true)
    gears.wallpaper.set("#000000") -- set pure color background
  end
end
screen.connect_signal("property::geometry", set_wallpaper)

-- Set wibar on each screen
awful.screen.connect_for_each_screen(function(s)

  -- Set wallpaper
  set_wallpaper(s)

  -- Tag
  awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }, s, awful.layout.layouts[1])

  -- Prompt or Application Launcher
  s.promptbox = awful.widget.prompt()

  -- Layoutbox
  s.layoutbox = awful.widget.layoutbox(s)

  -- Taglist
  s.taglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.noempty,
  })

  -- Tasklist
  s.tasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
  })

  -- Create wibox
  s.wibox = awful.wibar({
    height = 24,
    position = "top",
    screen = s,
  })

  -- Add widgets to the wibox
  s.wibox:setup({
    layout = wibox.layout.align.horizontal,
    -- Left Widgets
    {
      layout = wibox.layout.fixed.horizontal,
      launcher,
      s.taglist,
    },
    -- Middle Widgets
    {
      layout = wibox.layout.fixed.horizontal,
      s.tasklist,
      s.promptbox,
    },
    -- Right Widgets
    {
      layout = wibox.layout.fixed.horizontal,
      awful.widget.watch([[bash -c "echo \  $(top -bn1 | grep Cpu | awk '{print $2}')%\ "]], 2),
      awful.widget.watch([[bash -c "echo \  $(echo $(free -h | grep Mem) | awk '{print $3}')\ "]], 2),
      awful.widget.watch([[bash -c "echo \ 󰁹 $(cat /sys/class/power_supply/BAT1/capacity)%\ "]], 120),
      awful.widget.watch([[bash -c "echo \  $(echo $(amixer sget Master | grep -o -E '[0-9]+%' | head -1))\ "]], 2),
      awful.widget.watch([[bash -c "echo \  $(($(brightnessctl get)*100/$(brightnessctl max)))%\ "]], 2),
      awful.widget.watch([[bash -c "echo \  $(date +%Y-%m-%d\ %H:%M)\ "]], 60),
      wibox.widget.systray(),
      s.layoutbox,
    },
  })
end)

-- Keybinding and Mousebinding
globalkeys = gears.table.join(
  awful.key({ modkey }, "Return", function() awful.spawn("xterm") end, { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey, "Shift" }, "Return", function() awful.spawn("emacs") end, { description = "open Emacs", group = "launcher" }),
  awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end, { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end, { description = "focus previous by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end, { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end, { description = "swap with previous client by index", group = "client" }),
  -- awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end, { description = "focus the next screen", group = "screen" }),
  -- awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end, { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "e", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end, { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey }, "Tab", function() awful.layout.inc(1) end, { description = "select next", group = "layout" }),
  awful.key({ modkey }, "space", function() awful.screen.focused().promptbox:run() end, { description = "run prompt", group = "launcher "}),
  awful.key({ modkey }, "#10", function() local screen = awful.screen.focused(); local tag = screen.tags[1]; if tag then tag:view_only() end; end, { description = "view tag #1", group = "tag" }),
  awful.key({ modkey }, "#11", function() local screen = awful.screen.focused(); local tag = screen.tags[2]; if tag then tag:view_only() end; end, { description = "view tag #2", group = "tag" }),
  awful.key({ modkey }, "#12", function() local screen = awful.screen.focused(); local tag = screen.tags[3]; if tag then tag:view_only() end; end, { description = "view tag #3", group = "tag" }),
  awful.key({ modkey }, "#13", function() local screen = awful.screen.focused(); local tag = screen.tags[4]; if tag then tag:view_only() end; end, { description = "view tag #4", group = "tag" }),
  awful.key({ modkey }, "#14", function() local screen = awful.screen.focused(); local tag = screen.tags[5]; if tag then tag:view_only() end; end, { description = "view tag #5", group = "tag" }),
  awful.key({ modkey }, "#15", function() local screen = awful.screen.focused(); local tag = screen.tags[6]; if tag then tag:view_only() end; end, { description = "view tag #6", group = "tag" }),
  awful.key({ modkey }, "#16", function() local screen = awful.screen.focused(); local tag = screen.tags[7]; if tag then tag:view_only() end; end, { description = "view tag #7", group = "tag" }),
  awful.key({ modkey }, "#17", function() local screen = awful.screen.focused(); local tag = screen.tags[8]; if tag then tag:view_only() end; end, { description = "view tag #8", group = "tag" }),
  awful.key({ modkey }, "#18", function() local screen = awful.screen.focused(); local tag = screen.tags[9]; if tag then tag:view_only() end; end, { description = "view tag #9", group = "tag" }),
  awful.key({ modkey }, "#19", function() local screen = awful.screen.focused(); local tag = screen.tags[10]; if tag then tag:view_only() end; end, { description = "view tag #10", group = "tag" }),
  awful.key({ modkey, "Shift" }, "#10", function() if client.focus then local tag = client.focus.screen.tags[1]; if tag then client.focus:move_to_tag(tag) end end end, { description = "move focused client to tag #1", group = "tag" }),
  awful.key({ modkey, "Shift" }, "#11", function() if client.focus then local tag = client.focus.screen.tags[2]; if tag then client.focus:move_to_tag(tag) end end end, { description = "move focused client to tag #2", group = "tag" }),
  awful.key({ modkey, "Shift" }, "#12", function() if client.focus then local tag = client.focus.screen.tags[3]; if tag then client.focus:move_to_tag(tag) end end end, { description = "move focused client to tag #3", group = "tag" }),
  awful.key({ modkey, "Shift" }, "#13", function() if client.focus then local tag = client.focus.screen.tags[4]; if tag then client.focus:move_to_tag(tag) end end end, { description = "move focused client to tag #4", group = "tag" }),
  awful.key({ modkey, "Shift" }, "#14", function() if client.focus then local tag = client.focus.screen.tags[5]; if tag then client.focus:move_to_tag(tag) end end end, { description = "move focused client to tag #5", group = "tag" }),
  awful.key({ modkey, "Shift" }, "#15", function() if client.focus then local tag = client.focus.screen.tags[6]; if tag then client.focus:move_to_tag(tag) end end end, { description = "move focused client to tag #6", group = "tag" }),
  awful.key({ modkey, "Shift" }, "#16", function() if client.focus then local tag = client.focus.screen.tags[7]; if tag then client.focus:move_to_tag(tag) end end end, { description = "move focused client to tag #7", group = "tag" }),
  awful.key({ modkey, "Shift" }, "#17", function() if client.focus then local tag = client.focus.screen.tags[8]; if tag then client.focus:move_to_tag(tag) end end end, { description = "move focused client to tag #8", group = "tag" }),
  awful.key({ modkey, "Shift" }, "#18", function() if client.focus then local tag = client.focus.screen.tags[9]; if tag then client.focus:move_to_tag(tag) end end end, { description = "move focused client to tag #9", group = "tag" }),
  awful.key({ modkey, "Shift" }, "#19", function() if client.focus then local tag = client.focus.screen.tags[10]; if tag then client.focus:move_to_tag(tag) end end end, { description = "move focused client to tag #10", group = "tag" }),
  awful.key({}, "XF86MonBrightnessUp", function() awful.util.spawn("brightnessctl s +5%") end, { description = "Raise Monitor Backlight", group = "XF86" }),
  awful.key({}, "XF86MonBrightnessDown", function() awful.util.spawn("brightnessctl s 5%-") end, { description = "Lower Monitor Backlight", group = "XF86" }),
  awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer sset Master 5%+") end, { description = "Raise Volume", group = "XF86" }),
  awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("amixer sset Master 5%-") end, { description = "Lower Volume", group = "XF86" }),
  awful.key({}, "XF86AudioMute", function() awful.util.spawn("amixer sset Master 1+ toggle") end, { description = "Toggle Volume", group = "XF86" })
)
root.keys(globalkeys)
root.buttons(gears.table.join(awful.button({}, 3, function() mainmenu:toggle() end)))

-- RULE

-- Rules to apply to new clients
-- (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = gears.table.join(
        awful.key({ modkey }, "f", function(c) c.fullscreen = not c.fullscreen; c:raise() end, { description = "toggle fullscreen", group = "client" }),
        awful.key({ modkey, "Shift" }, "q", function(c) c:kill() end, { description = "close", group = "client" })
      ),
      buttons = gears.table.join(
        awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end),
        awful.button({ modkey }, 3, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }); awful.mouse.client.resize(c) end)
      ),
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
    }
  },
  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA",
        "copyq",
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "veromix",
        "xtightvncviewer"
      },
      name = {
        "Event Tester",
      },
      role = {
        "AlarmWindow",
        "ConfigManager",
        "pop-up",
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

-- Signal

-- Signal function to execute when a new client appears.
-- Prevent clients from being unreachable after screen count changes.
client.connect_signal("manage", function(c) if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then awful.placement.no_offscreen(c) end end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  awful.titlebar(c, { size = 24 }):setup({
    -- Left
    {
      awful.titlebar.widget.iconwidget(c),
      buttons = gears.table.join(
        awful.button({}, 1, function() c:emit_signal("request::activate", "titlebar", { raise = true }); awful.mouse.client.move(c) end),
        awful.button({}, 3, function() c:emit_signal("request::activate", "titlebar", { raise = true }); awful.mouse.client.resize(c) end)
      ),
      layout = wibox.layout.fixed.horizontal
    },
    -- Middle
    {
      {
        align = "center",
        widget = awful.titlebar.widget.titlewidget(c)
      },
      buttons = gears.table.join(
        awful.button({}, 1, function() c:emit_signal("request::activate", "titlebar", { raise = true }); awful.mouse.client.move(c) end),
        awful.button({}, 3, function() c:emit_signal("request::activate", "titlebar", { raise = true }); awful.mouse.client.resize(c) end)
      ),
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
client.connect_signal("mouse::enter", function(c) c:emit_signal("request::activate", "mouse_enter", { raise = false }) end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Autostart
awful.spawn.with_shell("xclip")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("flameshot")
awful.spawn.with_shell("udiskie")
awful.spawn.with_shell("/usr/lib/polkit-kde-authentication-agent-1")
awful.spawn.with_shell("[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources")
awful.spawn.with_shell("fcitx5 --replace -d")
-- awful.spawn.with_shell("ibus-daemon -drxR")

-- Garbage Collection
gears.timer({
  timeout = 30,
  autostart = true,
  callback = function()
    collectgarbage()
  end,
})
