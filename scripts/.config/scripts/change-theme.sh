#/bin/bash
#
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
   )

  choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -window-title Config)

if [ "$choice" ]; then
  
  #set waybar theme
  cp $waybar/themes/$choice.css $waybar/theme.css

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

