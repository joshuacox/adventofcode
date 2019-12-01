#!/bin/bash
source lib/util.sh
#slurpy="$(grep -v '^#' ./test|sort -n)"
slurpy="$(cat ./test)"

main () {
  while read WATE
  do
    XFUEL=$(xfuel $WATE)
    let TOTAL_XFUEL+=$XFUEL
  done <<< "$slurpy"
  printf "TOTAL_XFUEL=%d\n" $TOTAL_XFUEL
}

time main $@
