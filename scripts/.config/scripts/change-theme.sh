#/bin/bash
#
waybar="$HOME/.config/waybar"
hypr="$HOME/.config/hypr"
swaync="$HOME/.config/swaync"
rofi="$HOME/.config/rofi"


declare -a options=(
  "Catppuccin"
  "Dracula"
  "Gruvbox"
   )

  choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -window-title Config)

 # if [ "$choice" ]; then
  #  $selection=$(printf '%s\n' "$choice")

  #else
   # echo "Program terminated" && exit 1
  #fi

#set theme
cp $waybar/themes/$choice.css $waybar/theme.css

#reload waybar
killall -q waybar
exec env GTK_THEME=Dracula waybar & disown
