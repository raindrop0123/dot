#!/bin/zsh

memory=$(memory_pressure | awk '/^System-wide memory free percentage: /{ printf("%d\n", 100-$5) }')
sketchybar --set memory label=$memory%
