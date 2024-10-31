## Import Libraries and Theme ----------------------------------

import os
import subprocess
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from themes.tokyonight import colors

## Startup ----------------------------------


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])


## Key Bindings ----------------------------------

mod = "mod4"
terminal = "kitty"
browser = "firefox-developer-edition"
file_manager = "thunar"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Custom
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Launch Menu"),
    Key([mod], "w", lazy.spawn(browser), desc="Launch Browser"),
    Key([mod], "e", lazy.spawn(file_manager), desc="Launch Browser"),
    Key([mod], "p", lazy.spawn("sh -c ~/.config/rofi/scripts/power"), desc="powermenu"),
    # Switch focus of monitors
    Key([mod], "period", lazy.next_screen()),
    Key([mod], "comma", lazy.prev_screen()),
    # Switch between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"],
        "Left",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "Right",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "Left",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "Right",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

## Groups creation ----------------------------------

# Define the name of the group in japanese
group_names = ["一", "二", "三", "四", "五", "六", "七", "八", "九"]

# Create groups
groups = [Group(name) for name in group_names]

# Configure the keyboard shortcuts to change groups
for i, name in enumerate(group_names, 1):
    keys.extend(
        [
            # mod + num of group = change group
            Key(
                [mod],
                str(i),
                lazy.group[name].toscreen(),
                desc=f"Switch to group {name}",
            ),
            # mod + shift + num of group = change and move focus window to group
            Key(
                [mod, "shift"],
                str(i),
                lazy.window.togroup(name, switch_group=True),
                desc=f"Switch to & move focused window to group {name}",
            ),
        ]
    )

## Layouts ----------------------------------


# TODO: Change color scheme to go with tokyonight
def init_colors():
    return [
        ["#2E3440", "#2E3440"],  # color 0 Background
        ["#37306B", "#37306B"],  # color 1
        ["#66347F", "#66347F"],  # color 2
        ["#9E4784", "#9E4784"],  # color 3
        ["#D27685", "#D27685"],  # color 4
        ["#b172ff", "#b172ff"],  # color 5 - purple-dark
        ["#bf8bff", "#bf8bff"],  # color 6 - ...
        ["#cda5ff", "#cda5ff"],  # color 7 -
        ["#dbbeff", "#dbbeff"],  # color 8 -
        ["#e9d8ff", "#e9d8ff"],
    ]  # color 8 -


tokyo = colors["night"]

colors = init_colors()


def init_layout_theme():
    return {
        "margin": 6,
        "border_width": 2,
        "border_focus": tokyo["magenta"],
        "border_normal": tokyo["black"],
    }


layout_theme = init_layout_theme()

layouts = [
    layout.Columns(**layout_theme),
    layout.Max(**layout_theme),
    # layout.Tile(**layout_theme),
    # layout.MonadTall(**layout_theme),
    layout.Floating(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Bsp(**layout_theme),
]


def init_widgets_defaults():
    return dict(
        font="JetBrainsMono Nerd Font Regular",
        fontsize=12,
        padding=5,
        foreground=tokyo["fg"],
        background=tokyo["bg"],
    )


widget_defaults = init_widgets_defaults()
extension_defaults = widget_defaults.copy()


def power():
    qtile.cmd_spawn("sh -c ~/.config/rofi/scripts/power")


## Screens ----------------------------------

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    margin_y=3,
                    margin_x=0,
                    padding_y=6,
                    padding_x=6,
                    borderwidth=0,
                    disable_drag=True,
                    active=tokyo["magenta"],
                    inactive=tokyo["fg"],
                    rounded=False,
                    highlight_color=tokyo["red"],
                    this_current_screen_border=tokyo["magenta"],
                    this_screen_border=tokyo["magenta"],
                    other_current_screen_border=tokyo["bg"],
                    other_screen_border=tokyo["bg"],
                    urgent_border=tokyo["red"],
                    urgent_text=tokyo["red"],
                    highlight_method="text",
                ),
                widget.CurrentLayout(),
                widget.Prompt(),
                widget.Spacer(len=bar.STRETCH),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(),
                widget.TextBox(
                    text="",
                    foreground="#9C2DFF",
                ),
                widget.Clock(format="%d-%m-%Y - %R %p"),
                # widget.QuickExit(),
            ],
            35,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            # margin=[0, 10, 10, 10],
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
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

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
