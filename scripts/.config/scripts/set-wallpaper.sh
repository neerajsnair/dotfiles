#!/bin/bash
# Define wallpaper paths
MORNING="$HOME/Pictures/Wallpapers/tropic_island_morning.jpg"
AFTERNOON="$HOME/Pictures/Wallpapers/tropic_island_day.jpg"
EVENING="$HOME/Pictures/Wallpapers/tropic_island_evening.jpg"
NIGHT="$HOME/Pictures/Wallpapers/tropic_island_night.jpg"

# Get the current hour
HOUR=$(date +%H)

# Choose wallpaper based on time
if [ "$HOUR" -ge 6 ] && [ "$HOUR" -lt 10 ]; then
    WALLPAPER="$MORNING"
elif [ "$HOUR" -ge 10 ] && [ "$HOUR" -lt 17 ]; then
    WALLPAPER="$AFTERNOON"
elif [ "$HOUR" -ge 17 ] && [ "$HOUR" -lt 19 ]; then
    WALLPAPER="$EVENING"
else
    WALLPAPER="$NIGHT"
fi

# Set the wallpaper
swww img "$WALLPAPER" --transition-type simple >> /home/neeraj/wallpaper.log 2>&1
