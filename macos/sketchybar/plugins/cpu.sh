#!/bin/zsh

declare -A COLOR
COLOR=(
  [red]=0xffe06c75
  [orange]=0xfffca2aa
  [yellow]=0xffe7c787
  [green]=0xff98c379
)
ncpu=$(sysctl -n machdep.cpu.thread_count)
cpu_info=$(ps -eo pcpu,user)
# cpu_sys=$(echo $cpu_info | awk -v ncpu=$ncpu -v user=$USER '{ if ($2 != user) sum+=$1 } END {print sum/ncpu}')
# cpu_user=$(echo $cpu_info | awk -v ncpu=$ncpu -v user=$USER '{ if ($2 == user) sum+=$1 } END {print sum/ncpu}')
cpu_total=$(echo $cpu_info | awk -v ncpu=$ncpu '{ sum += $1 } END {printf("%2d\n", sum / ncpu)}')
case $cpu_total in
  [7-9]?|100) cpu_color=$COLOR[red] ;;
  [4-6]?) cpu_color=$COLOR[orange] ;;
  [2-3]?) cpu_color=$COLOR[yellow] ;;
  *) cpu_color=$COLOR[green] ;;
esac
sketchybar --set cpu label=$cpu_total% icon.color=$cpu_color
