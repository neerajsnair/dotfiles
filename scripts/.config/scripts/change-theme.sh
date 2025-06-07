#!/usr/bin/env bash

hypr="$HOME/.config/hypr"
kitty="$HOME/.config/kitty"
rofi="$HOME/.config/rofi"
swaync="$HOME/.config/swaync"
waybar="$HOME/.config/waybar"
yazi="$HOME/.config/yazi"


declare -a options=(
  "Catppuccin"
  "Dracula"
  "Gruvbox"
  "Everforest"
  "Tokyonight"
  "Nightfox"
  )

  choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -window-title Theme)

if [ "$choice" ]; then
 
  #set gtk theme
  rm -r $HOME/.config/gtk-4.0
  cp -r $HOME/.themes/$choice/gtk-4.0 $HOME/.config
  gsettings set org.gnome.desktop.interface gtk-theme "$choice"
  flatpak override --user --env=GTK_THEME=$choice


  #set waybar theme
  cp $waybar/themes/$choice.css $waybar/theme.css

  #set hyprland theme
  cp $hypr/themes/$choice.conf $hypr/theme.conf

  #set rofi theme
  cp $rofi/themes/$choice.rasi $rofi/config.rasi

  #set kitty theme
  cp $kitty/themes/$choice.conf $kitty/theme.conf

  #set yazi theme
  cp $yazi/themes/$choice.toml $yazi/theme.toml

  #reload waybar
  killall -q waybar
  exec env GTK_THEME=Dracula waybar & disown

else
    echo "Program terminated" && exit 1
fi

#set icons
if [ "$choice" = "Catppuccin" ]; then
    #papirus-folders -C blue --theme Papirus-Dark
    gsettings set org.gnome.desktop.interface icon-theme "Catppuccin-Mocha-Alt"

elif [ "$choice" = "Dracula" ]; then
    #papirus-folders -C violet --theme Papirus-Dark
    gsettings set org.gnome.desktop.interface icon-theme "dracula-circle"

elif [ "$choice" = "Gruvbox" ]; then
    gsettings set org.gnome.desktop.interface icon-theme "Gruvbox-Dark"
 
elif [ "$choice" = "Everforest" ]; then
    gsettings set org.gnome.desktop.interface icon-theme "Everforest-Dark"

elif [ "$choice" = "Tokyonight" ]; then
    gsettings set org.gnome.desktop.interface icon-theme "Tokyonight-Dark"

elif [ "$choice" = "Nightfox" ]; then
    gsettings set org.gnome.desktop.interface icon-theme "Duskfox-Alt-3"
fi

exit 0
