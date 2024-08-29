#!/bin/sh

mem=$(memory_pressure | awk '/^System-wide memory free percentage: /{ printf("%d\n", 100-$5) }')
case $mem in
  9?|100) mem_color=0xffff453a;;
  8?) mem_color=0xffff9d0a;;
  6[6-9]|7?) mem_color=0xffffd60a;;
  *) mem_color=0xff007aff;;
esac
sketchybar --set memory label=$mem% icon.color=$mem_color
