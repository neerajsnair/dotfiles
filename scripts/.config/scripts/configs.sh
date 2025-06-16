#!/usr/bin/env bash

declare -a options=(
  "Alacritty      - $HOME/.config/alacritty/alacritty.toml"
  "Bash           - $HOME/.bashrc"
  "Fastfetch      - $HOME/.config/fastfetch/config.jsonc"
  "Fish           - $HOME/.config/fish/config.fish"
  "Ghostty        - $HOME/.config/ghostty/config"
  "Hypridle       - $HOME/.config/hypr/hypridle.conf"
  "Hyprland       - $HOME/.config/hypr/hyprland.conf"
  "Hyprlock       - $HOME/.config/hypr/hyprlock.conf"
  "i3             - $HOME/.config/i3/config"
  "Keybindings    - $HOME/.config/hypr/keybindings.conf"
  "Kitty          - $HOME/.config/kitty/kitty.conf"
  "Niri           - $HOME/.config/niri/config.kdl"
  "Polybar        - $HOME/.config/polybar/config.ini"
  "Rofi           - $HOME/.config/rofi/config.rasi"
  "Starship       - $HOME/.config/starship.toml"
  "Swaync_config  - $HOME/.config/swaync/config.json"
  "Swaync_style   - $HOME/.config/swaync/style.css"
  "Waybar_config  - $HOME/.config/waybar/config.jsonc"
  "Waybar_style   - $HOME/.config/waybar/style.css"
  "Windowrules    - $HOME/.config/hypr/windowrules.conf"
   )

  choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -window-title Config)

  if [ "$choice" ]; then
    cfg=$(printf '%s\n' "$choice" | awk '{print $3}')
    kitty -e nvim "$cfg"

  else
    echo "Program terminated" && exit 1
  fi
