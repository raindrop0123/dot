#!/bin/zsh

memory=$(memory_pressure | awk '/^System-wide memory free percentage: /{ printf("%d\n", 100-$5) }')
case $memory in
  9?|100) mem_color=0xffe06c75 ;;
  8?) mem_color=0xfffca2aa ;;
  6[6-9]|7?) mem_color=0xffe7c787 ;;
  *) mem_color=0xff7eca9c ;;
esac
sketchybar --set memory label=$memory% icon.color=$mem_color
