#!/bin/bash

killall -q waybar
exec env GTK_THEME=Dracula waybar & disown
