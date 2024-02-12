#!/usr/bin/python3

# based on https://github.com/firatakandere/i3blocks-spotify
# to show the spotify song and artist put the following lines in your i3blocks config file:
#[spotify]
#label=
#command=~/.config/i3/scripts/spotify-status.py
#color=#8fbcbb
#interval=15

import dbus
import os
import sys

try:
    bus = dbus.SessionBus()
    spotify = bus.get_object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")


    if os.environ.get('BLOCK_BUTTON'):
        control_iface = dbus.Interface(spotify, 'org.mpris.MediaPlayer2.Player')
        if (os.environ['BLOCK_BUTTON'] == '1'):
            control_iface.Previous()
        elif (os.environ['BLOCK_BUTTON'] == '2'):
            control_iface.PlayPause()
        elif (os.environ['BLOCK_BUTTON'] == '3'):
            control_iface.Next()

    spotify_iface = dbus.Interface(spotify, 'org.freedesktop.DBus.Properties')
    props = spotify_iface.Get('org.mpris.MediaPlayer2.Player', 'Metadata')

    if (sys.version_info > (3, 0)):
        print(str(props['xesam:artist'][0]) + " - " + str(props['xesam:title']))
    else:
        print(props['xesam:artist'][0] + " - " + props['xesam:title']).encode('utf-8')
    exit
except dbus.exceptions.DBusException:
    exit
except Exception as err:
    print(err)
    exit
