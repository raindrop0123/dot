#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"
if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi
case "${PERCENTAGE}" in
  9[0-9]|100) ICON="󰁹" battery_color=0xff30d158
  ;;
  [6-8][0-9]) ICON="󰂀" battery_color=0xffffd60a
  ;;
  [3-5][0-9]) ICON="󰁼" battery_color=0xfff9d0a
  ;;
  [1-2][0-9]) ICON="󰁺" battery_color=0xffff453a
  ;;
  *) ICON="" battery_color=0xffff453a
esac
if [[ "$CHARGING" != "" ]]; then
  ICON="󰂄" battery_color=0xff30d158
fi
sketchybar --set "$NAME" icon="$ICON" icon.color=$battery_color label="${PERCENTAGE}%"
