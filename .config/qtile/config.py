# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
import socket
import psutil
from typing import List  # noqa: F401

from libqtile import qtile, hook
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
terminal = "alacritty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html

    # Window Movement
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.next()),
    Key([mod], "k", lazy.layout.previous()),
    Key([mod], "o", lazy.next_screen()),
    Key([mod], "comma", lazy.prev_screen()),

    # Window Control
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "space", lazy.next_layout()),
    Key([mod], "q", lazy.window.kill()),

    # Window Arrangement
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    Key([mod], "t", lazy.layout.normalize()),

    # Spawn Programs
    Key([mod], "d", lazy.spawn("dmenu_run -fn 'Misc Termsyn.Icons:size=15.0'")),
    Key([mod], "w", lazy.spawn("brave")),
    Key([mod, "shift"], "d", lazy.spawn("discord")),
    Key([mod, "shift"], "p", lazy.spawn("postman")),
    Key([mod, "shift"], "e", lazy.spawn("emacs")),
    Key([mod, "shift"], "Return", lazy.spawn("thunar")),
    Key([mod], "Return", lazy.spawn(terminal)),

    # Qtile Config Commands
    Key([mod, "shift"], "r", lazy.reload_config()),
    Key([mod, "shift"], "q", lazy.shutdown()),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(toggle=True),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

    layout_theme = {"border_width": 3,
                    "margin": 0,
                    "border_focus": "#005577",
                    "border_normal": "#444444",
                    }

layouts = [
    layout.Columns(**layout_theme, border_on_single=True, insert_position=1),
    layout.Max(),
]

widget_defaults = dict(
    font='monospace',
    fontsize=12,
    padding=2,
)
extension_defaults = widget_defaults.copy()


def cus_battery():
    if socket.gethostname() == "nixos-laptop":
        return widget.Battery(
            padding=3,
            low_percentage=0.20,
            low_foreground="#ff5555",
            update_delay=15,
            format='[ BAT: {percent:.0%} ]',
            )
    return widget.TextBox(
        text='',
        padding=0,
        fontsize=0
    )


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(highlight_method="line", highlight_color="#005577", padding_x=7, borderwidth=0, margin_x=0, disable_drag=True, block_highlight_text_color="FFFFFF"),
                widget.Prompt(),
                widget.WindowName(
                    background="#005577",
                ),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
                cus_battery(),
                widget.CPU(
                    padding=2,
                    format="[CPU  {load_percent:2.0f}%]",
                    update_interval=2.0,
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(terminal + ' -t dropdown_cpu -e btm')},
                 ),
                widget.Memory(
                 format="[RAM  {MemPercent:2.0f}%]",
                 update_interval=2.0,
                 ),
                widget.Clock(format='(%Y-%m-%d) (%a) %H:%M'),

            ],
            size=26,
            # opacity=0.6
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(highlight_method="line", highlight_color="#005577", padding_x=7, borderwidth=0, margin_x=0, disable_drag=True, block_highlight_text_color="FFFFFF"),
                widget.Prompt(),
                widget.WindowName(
                    background="#005577",
                ),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
                cus_battery(),
                widget.CPU(
                    padding=2,
                    format="[CPU  {load_percent:2.0f}%]",
                    update_interval=2.0,
                    mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(terminal + ' -t dropdown_cpu -e btm')},
                 ),
                widget.Memory(
                 format="[RAM  {MemPercent:2.0f}%]",
                 update_interval=2.0,
                 ),
                widget.Clock(format='(%Y-%m-%d) (%a) %H:%M'),

            ],
            size=26,
            # opacity=0.6
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.client_new
def _swallow(window):
    pid = window.window.get_net_wm_pid()
    ppid = psutil.Process(pid).ppid()
    cpids = {c.window.get_net_wm_pid(): wid for wid, c in window.qtile.windows_map.items()}
    for i in range(5):
        if not ppid:
            return
        if ppid in cpids:
            parent = window.qtile.windows_map.get(cpids[ppid])
            parent.minimized = True
            window.parent = parent
            return
        ppid = psutil.Process(ppid).ppid()


@hook.subscribe.client_killed
def _unswallow(window):
    if hasattr(window, 'parent'):
        window.parent.minimized = False


@hook.subscribe.startup_once
def start_once():
    """Run setup script on startup."""
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/setup.sh'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
