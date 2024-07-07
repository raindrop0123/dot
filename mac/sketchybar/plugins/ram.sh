#!/usr/bin/env sh
sketchybar -m --set $NAME label=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{printf("%.0f", 100-$5"%")}')% label.padding_left=5 label.padding_right=5
