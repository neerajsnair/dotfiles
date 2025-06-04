#!/bin/bash

# Set the path to the wallpapers directory
    wallpapersDir="$HOME/Pictures/Wallpapers"

# Get a list of all image files in the wallpapers directory
    wallpapers=("$wallpapersDir"/*)

# Select a random wallpaper from the directory
    wallpaperIndex=$(( RANDOM % ${#wallpapers[@]} ))
    selectedWallpaper="${wallpapers[$wallpaperIndex]}"

# Update the wallpaper using the swww img command
    swww img "$selectedWallpaper"  --transition-step 10

#pywal
    wal -i "$selectedWallpaper"

#reload waybar
    killall waybar
    waybar

exit 0
