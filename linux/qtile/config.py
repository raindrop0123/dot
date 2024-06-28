import os
import subprocess
from libqtile import bar, layout, qtile, widget, extension, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"

keys = [
    Key([mod], "j", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "k", lazy.layout.right(), desc="Move focus to right"),
    Key(
        [mod],
        "h",
        lazy.layout.grow_left().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide", "monadthreecol"]),
        desc="Grow window to the left",
    ),
    Key(
        [mod],
        "l",
        lazy.layout.grow_right().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide", "monadthreecol"]),
        desc="Grow window to the right"
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "Return", lazy.spawn("alacritty"), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Exit Qtile"),
    Key([mod], "Space", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +5%"), desc="Raise Monitor Backlight Up"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 5%-"), desc="Raise Monitor Backlight Down"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 3%+"), desc="Raise Volume Up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 3%-"), desc="Raise Volume Down"),
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master 1+ toggle"), desc="Toggle Volume"),
]

for vt in range(1, 10):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = [Group(i) for i in "1234567890"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

layouts = [
    # layout.Columns(),
    # layout.Max(),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="monospace bold",
    fontsize=16,
    padding=4,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper="/home/c/wp1.jpg",
        wallpaper_mode="fill",
        bottom=bar.Bar(
            [
                widget.GroupBox(hide_unused=True),
                widget.Prompt(),
                widget.WindowName(),
                widget.CPU(format="[CPU {load_percent}%]"),
                widget.Memory(format="[MEM {MemUsed:.0f}{mm}]"),
                widget.Battery(format="[BAT {percent:2.0%}]"),
                widget.Volume(fmt="[VOL {}]"),
                widget.Clock(format="[%Y-%m-%d %H:%M]"),
                widget.Systray(),
                widget.CurrentLayoutIcon(scale=0.8),
            ],
            30,
            border_width=[0, 0, 0, 0],
            border_color=["000000", "000000", "000000", "000000"]
        ),
        x11_drag_polling_rate = 60,
    ),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

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

# autostart
@hook.subscribe.startup_once
def start_once():
    qtile.cmd_spawn('xclip')
    qtile.cmd_spawn('nm-applet')
    qtile.cmd_spawn('flameshot')
    qtile.cmd_spawn('ibus-daemon -rxdR')
    qtile.cmd_spawn('[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources')

wmname = "LG3D"
