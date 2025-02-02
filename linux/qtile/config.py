#!/usr/bin/python

##########
# MODULE #
##########
import os
import subprocess
from libqtile import bar, layout, qtile, widget, extension, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy

##########
# MODKEY #
##########
mod = "mod4" # or mod1

##############
# KEYBINDING #
##############
keys = [
    Key([mod], "Return", lazy.spawn("wezterm"), desc="Launch terminal"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus to down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus to up"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window to the down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window to the up"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), lazy.layout.grow(), desc="Grow window to the left"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), lazy.layout.grow(), desc="Grow window to the down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), lazy.layout.shrink(), desc="Grow window to the up"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), lazy.layout.shrink(), desc="Grow window to the right"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Exit Qtile"),
    Key([mod], "Space", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "Space", lazy.spawn("rofi -show run"), desc="Spawn a command using a prompt widget"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +5%"), desc="Raise Monitor Backlight Up"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 5%-"), desc="Raise Monitor Backlight Down"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"), desc="Raise Volume Up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"), desc="Raise Volume Down"),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc="Toggle Volume"),
]
for vt in range(1, 10):
    keys.append(
        Key(
            ["control", "mod4"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}"
        )
    )

#############
# WORKSPACE #
#############
groups = [Group(i) for i in "1234567890"]
for i in groups:
    keys.extend(
        [
            Key([mod], i.name, lazy.group[i.name].toscreen(), desc="Switch to group {}".format(i.name)),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc="Switch to & move focused window to group {}".format(i.name)),
        ]
    )

##########
# LAYOUT #
##########
layouts = [
    layout.MonadTall(border_width=4, margin=4, border_focus="#a6e3a1", border_normal="#11111b"),
    layout.Columns(),
    layout.Max(),
    layout.Stack(),
    layout.Bsp(),
    layout.Matrix(),
    layout.MonadWide(),
    layout.RatioTile(),
    layout.Tile(),
    layout.TreeTab(),
    layout.VerticalTile(),
    layout.Zoomy(),
]

#######
# BAR #
#######
widget_defaults = dict(
    font="JetBrainsMono Nerd Font Bold",
    fontsize=14,
    padding=7,
    background="#11111b",
    foreground="#cdd6f4"
)
extension_defaults = widget_defaults.copy()
screens = [
    Screen(
        wallpaper="/home/cya/wallpaper/wp1.jpg",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.TextBox(fmt="", foreground="#f9e2af"),
                widget.GroupBox(
                    hide_unused=True,
                    active="#89b4fa",
                    block_highlight_text_color="#cdd6f4",
                    this_current_screen_border="#a6e3a1",
                    fontsize=12,
                    padding=5
                ),
                widget.Prompt(background="#a6e3a1", foreground="#11111b"),
                widget.WindowName(background="#11111b", foreground="#cdd6f4"),
                widget.CPU(format=" {load_percent}%", foreground="#f38ba8"),
                widget.Memory(format=" {MemUsed:.0f}{mm}", foreground="#fab387"),
                widget.Battery(format="󰁹 {percent:2.0%}", foreground="#a6e3a1"),
                widget.Net(format=" {down:.0f}{down_suffix}", foreground="#89b4fa"),
                widget.Net(format=" {up:.0f}{up_suffix}", foreground="#cba6f7"),
                widget.Backlight(format=" {percent:2.0%}", backlight_name="intel_backlight", foreground="#f9e2af"),
                widget.Volume(fmt=" {}", foreground="#f5c2e7"),
                widget.Clock(format=" %Y-%m-%d %H:%M", foreground="#f5e0dc"),
                widget.Systray(),
                widget.CurrentLayoutIcon(scale=0.7),
            ],
            35,
            border_width=[0, 0, 0, 0],
            border_color=["#ffffff", "#ffffff", "#ffffff", "#ffffff"]
        ),
        x11_drag_polling_rate = 56,
    ),
]

################
# MOUSEBINDING #
################
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

#################
# MISCELLANEOUS #
#################
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wl_xcursor_theme = None
wl_xcursor_size = 24

#############
# AUTOSTART #
#############
@hook.subscribe.startup_once
def start_once():
    qtile.cmd_spawn("nm-applet")
    qtile.cmd_spawn("blueman-applet")
    qtile.cmd_spawn("flameshot")
    qtile.cmd_spawn("xclip")
    qtile.cmd_spawn("udiskie --tray")
    qtile.cmd_spawn("xrdb -merge /home/cya/.Xresources")
    # qtile.cmd_spawn("feh --bg-fill --randomize /home/cya/wallpaper/*")
    qtile.cmd_spawn("/usr/lib/polkit-kde-authentication-agent-1")
    qtile.cmd_spawn("picom")
    qtile.cmd_spawn("dunst")
    qtile.cmd_spawn("conky")
    qtile.cmd_spawn("ibus-daemon -rxdR")
    qtile.cmd_spawn("redshift -x && redshift -O 4500")

###########
# WM NAME #
###########
wmname = "LG3D"
