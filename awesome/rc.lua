--- LOAD PACKAGES ---
pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local xresources = require("beautiful.xresources")
local filesystem = require("gears.filesystem")
local theme_assets = require("beautiful.theme_assets")
require("awful.hotkeys_popup.keys")

--- ERROR HANDLING ---
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "There were errors during startup!",
    text = awesome.startup_errors
  })
end
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
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

--- THEME ---
beautiful.init({
  font = "JetBrainsMono Nerd Font Bold 10",
  bg_normal = "#222222",
  bg_focus = "#005577",
  bg_urgent = "#ff0000",
  bg_minimize = "#222222",
  bg_systray = "#222222",
  fg_normal = "#bbbbbb",
  fg_focus = "#eeeeee",
  fg_urgent = "#eeeeee",
  fg_minimize = "#eeeeee",
  useless_gap = xresources.apply_dpi(0),
  border_width = xresources.apply_dpi(1),
  border_normal = "#222222",
  border_focus = "#005577",
  border_marked = "#eeeeee",
  menu_submenu_icon = filesystem.get_themes_dir() .. "default/submenu.png",
  menu_height = xresources.apply_dpi(40),
  menu_width = xresources.apply_dpi(200),
  menu_border_color = "#005577",
  menu_border_width = xresources.apply_dpi(1),
  menu_bg_focus = "#005577",
  menu_fg_focus = "#eeeeee",
  menu_bg_normal = "#222222",
  menu_fg_normal = "#eeeeee",
  taglist_bg_focus = "#222222",
  taglist_fg_focus = "#eeeeee",
  taglist_bg_urgent = "#ff0000",
  taglist_fg_urgent = "#eeeeee",
  taglist_bg_occupied = "#222222",
  taglist_fg_occupied = "#eeeeee",
  taglist_bg_empty = "#222222",
  taglist_fg_empty = "#444444",
  taglist_squares_sel = theme_assets.taglist_squares_sel(xresources.apply_dpi(4), "#eeeeee"),
  taglist_squares_unsel = theme_assets.taglist_squares_unsel(xresources.apply_dpi(4), "#bbbbbb"),
  titlebar_close_button_normal = filesystem.get_themes_dir() .. "default/titlebar/close_normal.png",
  titlebar_close_button_focus = filesystem.get_themes_dir() .. "default/titlebar/close_focus.png",
  titlebar_minimize_button_normal = filesystem.get_themes_dir() .. "default/titlebar/minimize_normal.png",
  titlebar_minimize_button_focus  = filesystem.get_themes_dir() .. "default/titlebar/minimize_focus.png",
  titlebar_ontop_button_normal_inactive = filesystem.get_themes_dir() .. "default/titlebar/ontop_normal_inactive.png",
  titlebar_ontop_button_focus_inactive = filesystem.get_themes_dir() .. "default/titlebar/ontop_focus_inactive.png",
  titlebar_ontop_button_normal_active = filesystem.get_themes_dir() .. "default/titlebar/ontop_normal_active.png",
  titlebar_ontop_button_focus_active = filesystem.get_themes_dir() .. "default/titlebar/ontop_focus_active.png",
  titlebar_sticky_button_normal_inactive = filesystem.get_themes_dir() .. "default/titlebar/sticky_normal_inactive.png",
  titlebar_sticky_button_focus_inactive = filesystem.get_themes_dir() .. "default/titlebar/sticky_focus_inactive.png",
  titlebar_sticky_button_normal_active = filesystem.get_themes_dir() .. "default/titlebar/sticky_normal_active.png",
  titlebar_sticky_button_focus_active = filesystem.get_themes_dir() .. "default/titlebar/sticky_focus_active.png",
  titlebar_floating_button_normal_inactive = filesystem.get_themes_dir() .. "default/titlebar/floating_normal_inactive.png",
  titlebar_floating_button_focus_inactive = filesystem.get_themes_dir() .. "default/titlebar/floating_focus_inactive.png",
  titlebar_floating_button_normal_active = filesystem.get_themes_dir() .. "default/titlebar/floating_normal_active.png",
  titlebar_floating_button_focus_active = filesystem.get_themes_dir() .. "default/titlebar/floating_focus_active.png",
  titlebar_maximized_button_normal_inactive = filesystem.get_themes_dir() .. "default/titlebar/maximized_normal_inactive.png",
  titlebar_maximized_button_focus_inactive = filesystem.get_themes_dir() .. "default/titlebar/maximized_focus_inactive.png",
  titlebar_maximized_button_normal_active = filesystem.get_themes_dir() .. "default/titlebar/maximized_normal_active.png",
  titlebar_maximized_button_focus_active = filesystem.get_themes_dir() .. "default/titlebar/maximized_focus_active.png",
  wallpaper = filesystem.get_themes_dir() .. "default/background.png",
  layout_fairh = filesystem.get_themes_dir() .. "default/layouts/fairhw.png",
  layout_fairv = filesystem.get_themes_dir() .. "default/layouts/fairvw.png",
  layout_floating  = filesystem.get_themes_dir() .. "default/layouts/floatingw.png",
  layout_magnifier = filesystem.get_themes_dir() .. "default/layouts/magnifierw.png",
  layout_max = filesystem.get_themes_dir() .. "default/layouts/maxw.png",
  layout_fullscreen = filesystem.get_themes_dir() .. "default/layouts/fullscreenw.png",
  layout_tilebottom = filesystem.get_themes_dir() .. "default/layouts/tilebottomw.png",
  layout_tileleft = filesystem.get_themes_dir() .. "default/layouts/tileleftw.png",
  layout_tile = filesystem.get_themes_dir() .. "default/layouts/tilew.png",
  layout_tiletop = filesystem.get_themes_dir() .. "default/layouts/tiletopw.png",
  layout_spiral = filesystem.get_themes_dir() .. "default/layouts/spiralw.png",
  layout_dwindle = filesystem.get_themes_dir() .. "default/layouts/dwindlew.png",
  layout_cornernw = filesystem.get_themes_dir() .. "default/layouts/cornernww.png",
  layout_cornerne = filesystem.get_themes_dir() .. "default/layouts/cornernew.png",
  layout_cornersw = filesystem.get_themes_dir() .. "default/layouts/cornersww.png",
  layout_cornerse = filesystem.get_themes_dir() .. "default/layouts/cornersew.png",
  prompt_bg = "#222222",
  prompt_fg = "#eeeeee",
  notification_font = "JetBrainsMono Nerd Font 10",
  notification_bg = "#222222",
  notification_fg = "#eeeeee",
  notification_border_width = 1,
  notification_border_color = "#005577",
  awesome_icon = theme_assets.awesome_icon(xresources.apply_dpi(24), "#222222", "#eeeeee"),
  icon_theme = nil,
})

--- MODKEY ---
local modkey = "Mod4" -- or Mod1

--- LAYOUT ---
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

--- MENU ---
local mainmenu = awful.menu({
  items = {
    {
      " AwesomeWM ",
      {
        { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
        { "Manual", "alacritty -e man awesome" },
        { "Edit Configuration", "alacritty vim " .. awesome.conffile },
        { "Restart AwesomeWM", awesome.restart },
        { "Quit AwesomeWM", function() awesome.quit() end },
      },
    },
    {
      "Appearance",
      {
        { "lxappearance", "lxappearance" },
        { "Qt5 Setting", "qt5ct" },
      },
    },
    {
      " Terminal ",
      {
        { "Alacritty", "alacritty" },
        { "XTerm", "xterm" },
        { "URxvt", "urxvt" },
      },
    },
    {
      " Browser ",
      {
        { "Firefox", "firefox" },
        { "Microsoft Edge", "microsoft-edge-stable" },
        { "Google Chrome", "google-chrome-stable" },
      },
    },
    {
      " Editor ",
      {
        { "VSCode", "code" },
        { "Emacs", "emacs" },
        { "Vim", "alacritty -e vim" },
        { "Neovim", "alacritty -e nvim" },
        { "Helix", "alacritty -e helix" },
      }
    },
    {
      " System ",
      {
        { "Suspend", function() awful.spawn("suspend") end },
        { "Reboot", function() awful.spawn("reboot") end },
        { "Shutdown", function() awful.spawn("poweroff") end },
      },
    },
  }
})
-- Launcher
local launcher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mainmenu
})
-- Menubar configuration
menubar.utils.terminal = "alacritty"

--- WIBAR ---
-- Wallpaper setup
local function set_wallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    -- gears.wallpaper.maximized(wallpaper, s, true)
    gears.wallpaper.set("#222222") -- set pure color background
  end
end
screen.connect_signal("property::geometry", set_wallpaper)

-- Set wibar on each screen
awful.screen.connect_for_each_screen(function(s)

  -- Set wallpaper
  set_wallpaper(s)

  -- Tag
  awful.tag({ "1", "2", "3", "4", "5", "6", "7" , "8", "9", "0" }, s, awful.layout.layouts[1])

  -- Prompt or Application Launcher
  s.promptbox = awful.widget.prompt()

  -- Layoutbox
  s.layoutbox = awful.widget.layoutbox(s)

  -- Taglist
  s.taglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
  })

  -- Tasklist
  s.tasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
  })

  -- Create wibox
  s.wibox = awful.wibar({
    height = 24,
    position = "bottom",
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
      s.tasklist,
      s.promptbox,
    },
    -- Middle Widgets
    {
      layout = wibox.layout.fixed.horizontal,
    },
    -- Right Widgets
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = xresources.apply_dpi(8),
      awful.widget.watch([[sh -c "echo  $(top -bn1 | grep Cpu | awk '{print $2}')%"]], 3),
      awful.widget.watch([[sh -c "echo  $(echo $(free -h | grep Mem) | awk '{print $3}')"]], 3),
      awful.widget.watch([[sh -c "echo 󰁹 $(cat /sys/class/power_supply/BAT1/capacity)%"]], 120),
      awful.widget.watch([[sh -c "echo  $(echo $(amixer sget Master | grep -o -E '[0-9]+%' | head -1))"]], 1),
      awful.widget.watch([[sh -c "echo  $(($(brightnessctl get)*100/$(brightnessctl max)))%"]], 1),
      awful.widget.watch([[sh -c "echo  $(date +%Y-%m-%d\ %H:%M)"]], 60),
      wibox.widget.systray(),
      s.layoutbox,
    },
  })
end)

--- KEYBINDINGS & MOUSEBINDINGS ---
local globalkeys = gears.table.join(

-- Launcher
awful.key({ modkey }, "Return", function() awful.spawn("alacritty") end, { description = "Open terminal", group = "Launcher" }),
awful.key({ modkey }, "space", function() awful.screen.focused().promptbox:run() end, { description = "Run Prompt", group = "Launcher" }),
awful.key({ modkey, "Shift" }, "space", function() menubar.show() end, { description = "App Launcher", group = "Launcher" }),

-- Client
awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end, { description = "Focus Next by Index", group = "Client" }),
awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end, { description = "Focus Previous by Index", group = "Client" }),
awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end, { description = "Swap with Next Client by Index", group = "Client" }),
awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end, { description = "Swap with Previous Client by Index", group = "Client" }),

-- Screen
-- awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end, { description = "focus the next screen", group = "Screen" }),
-- awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end, { description = "focus the previous screen", group = "Screen" }),

-- Awesome
awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "Awesome" }),
awful.key({ modkey, "Shift" }, "e", awesome.quit, { description = "quit awesome", group = "Awesome" }),

-- Layout
awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end, { description = "Increase Master Width Factor", group = "Layout" }),
awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end, { description = "Decrease Master Width Factor", group = "Layout" }),
awful.key({ modkey }, "Tab", function() awful.layout.inc(1) end, { description = "Select Next", group = "Layout" }),
awful.key({ modkey, "Shift" }, "Tab", function() awful.layout.inc(-1) end, { description = "Select Previous", group = "Layout" }),

-- Tag
awful.key({ modkey }, "#10", function() local screen = awful.screen.focused(); local tag = screen.tags[1]; if tag then tag:view_only() end; end, { description = "View Tag #1", group = "Tag" }),
awful.key({ modkey }, "#11", function() local screen = awful.screen.focused(); local tag = screen.tags[2]; if tag then tag:view_only() end; end, { description = "View Tag #2", group = "Tag" }),
awful.key({ modkey }, "#12", function() local screen = awful.screen.focused(); local tag = screen.tags[3]; if tag then tag:view_only() end; end, { description = "View Tag #3", group = "Tag" }),
awful.key({ modkey }, "#13", function() local screen = awful.screen.focused(); local tag = screen.tags[4]; if tag then tag:view_only() end; end, { description = "View Tag #4", group = "Tag" }),
awful.key({ modkey }, "#14", function() local screen = awful.screen.focused(); local tag = screen.tags[5]; if tag then tag:view_only() end; end, { description = "View Tag #5", group = "Tag" }),
awful.key({ modkey }, "#15", function() local screen = awful.screen.focused(); local tag = screen.tags[6]; if tag then tag:view_only() end; end, { description = "View Tag #6", group = "Tag" }),
awful.key({ modkey }, "#16", function() local screen = awful.screen.focused(); local tag = screen.tags[7]; if tag then tag:view_only() end; end, { description = "View Tag #7", group = "Tag" }),
awful.key({ modkey }, "#17", function() local screen = awful.screen.focused(); local tag = screen.tags[8]; if tag then tag:view_only() end; end, { description = "View Tag #8", group = "Tag" }),
awful.key({ modkey }, "#18", function() local screen = awful.screen.focused(); local tag = screen.tags[9]; if tag then tag:view_only() end; end, { description = "View Tag #9", group = "Tag" }),
awful.key({ modkey }, "#19", function() local screen = awful.screen.focused(); local tag = screen.tags[10]; if tag then tag:view_only() end; end, { description = "View Tag #10", group = "Tag" }),
awful.key({ modkey, "Shift" }, "#10", function() if client.focus then local tag = client.focus.screen.tags[1]; if tag then client.focus:move_to_tag(tag) end end end, { description = "Move Focused Client to Tag #1", group = "Tag" }),
awful.key({ modkey, "Shift" }, "#11", function() if client.focus then local tag = client.focus.screen.tags[2]; if tag then client.focus:move_to_tag(tag) end end end, { description = "Move Focused Client to Tag #2", group = "Tag" }),
awful.key({ modkey, "Shift" }, "#12", function() if client.focus then local tag = client.focus.screen.tags[3]; if tag then client.focus:move_to_tag(tag) end end end, { description = "Move Focused Client to Tag #3", group = "Tag" }),
awful.key({ modkey, "Shift" }, "#13", function() if client.focus then local tag = client.focus.screen.tags[4]; if tag then client.focus:move_to_tag(tag) end end end, { description = "Move Focused Client to Tag #4", group = "Tag" }),
awful.key({ modkey, "Shift" }, "#14", function() if client.focus then local tag = client.focus.screen.tags[5]; if tag then client.focus:move_to_tag(tag) end end end, { description = "Move Focused Client to Tag #5", group = "Tag" }),
awful.key({ modkey, "Shift" }, "#15", function() if client.focus then local tag = client.focus.screen.tags[6]; if tag then client.focus:move_to_tag(tag) end end end, { description = "Move Focused Client to Tag #6", group = "Tag" }),
awful.key({ modkey, "Shift" }, "#16", function() if client.focus then local tag = client.focus.screen.tags[7]; if tag then client.focus:move_to_tag(tag) end end end, { description = "Move Focused Client to Tag #7", group = "Tag" }),
awful.key({ modkey, "Shift" }, "#17", function() if client.focus then local tag = client.focus.screen.tags[8]; if tag then client.focus:move_to_tag(tag) end end end, { description = "Move Focused Client to Tag #8", group = "Tag" }),
awful.key({ modkey, "Shift" }, "#18", function() if client.focus then local tag = client.focus.screen.tags[9]; if tag then client.focus:move_to_tag(tag) end end end, { description = "Move Focused Client to Tag #9", group = "Tag" }),
awful.key({ modkey, "Shift" }, "#19", function() if client.focus then local tag = client.focus.screen.tags[10]; if tag then client.focus:move_to_tag(tag) end end end, { description = "Move Focused Client to Tag #10", group = "Tag" }),

-- XF86
awful.key({}, "XF86MonBrightnessUp", function() awful.util.spawn("brightnessctl s +5%") end, { description = "Raise Monitor Backlight", group = "XF86" }),
awful.key({}, "XF86MonBrightnessDown", function() awful.util.spawn("brightnessctl s 5%-") end, { description = "Lower Monitor Backlight", group = "XF86" }),
awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer sset Master 5%+") end, { description = "Raise Volume", group = "XF86" }),
awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("amixer sset Master 5%-") end, { description = "Lower Volume", group = "XF86" }),
awful.key({}, "XF86AudioMute", function() awful.util.spawn("amixer sset Master 1+ toggle") end, { description = "Toggle Volume", group = "XF86" })
)
root.keys(globalkeys)
root.buttons(gears.table.join(awful.button({}, 3, function() mainmenu:toggle() end)))

--- RULE ---
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
      keys = gears.table.join(
      awful.key({ modkey }, "f", function(c) c.fullscreen = not c.fullscreen; c:raise() end, { description = "Toggle Fullscreen", group = "Client" }),
      awful.key({ modkey, "Shift" }, "q", function(c) c:kill() end, { description = "Close Window", group = "Client" })
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

--- SIGNAL ---
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

--- AUTOSTART ---
local application = {
  "xclip",
  "nm-applet",
  "blueman-applet",
  "flameshot",
  "udiskie",
  "/usr/lib/polkit-kde-authentication-agent-1",
  "xrdb -merge ~/.Xresources",
  "fcitx5 --replace -d",
}
for _, app in ipairs(application) do
  awful.spawn.with_shell(app)
end

--- GARBAGE COLLECTION ---
gears.timer({
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    collectgarbage()
  end,
})
