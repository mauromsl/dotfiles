#!/usr/bin/python3

#[youtube_music]
#label=🎧
#command=~/.config/i3/scripts/youtube-music-status.py
#color=#b2071d
#interval=15

import dbus
import os
import sys

try:
    volume_str = ""
    bus = dbus.SessionBus()
    try:
        # The electron app does not set a name for media player, it is set
        # to a string like "chromium.intance[0-9]{8}"
        player_name = next(filter(lambda name: "MediaPlayer2.chromium.instance" in name, bus.list_names()))
    except StopIteration:
        exit
    player = bus.get_object(player_name, "/org/mpris/MediaPlayer2")
    player_iface = dbus.Interface(player, 'org.freedesktop.DBus.Properties')

    if os.environ.get('BLOCK_BUTTON'):
        control_iface = dbus.Interface(player, 'org.mpris.MediaPlayer2.Player')
        if (os.environ['BLOCK_BUTTON'] == '1'):
            control_iface.Previous()
        elif (os.environ['BLOCK_BUTTON'] == '2'):
            control_iface.PlayPause()
        elif (os.environ['BLOCK_BUTTON'] == '3'):
            control_iface.Next()
        elif (os.environ['BLOCK_BUTTON'] == '4'):
            # youtube-music MPRIS does not return correct volume always returns 1
            volume = player_iface.Get('org.mpris.MediaPlayer2.Player', 'Volume')
            volume_str = f"{volume}%"

    props = player_iface.Get('org.mpris.MediaPlayer2.Player', 'Metadata')

    print(f"{volume_str} {props['xesam:artist'][0]} - {props['xesam:title']}").encode('utf-8')
except Exception as err:
    print(f"{err.__class__}: {err}")
    exit
