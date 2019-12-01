#!/bin/bash
source lib/util.sh
#slurpy="$(grep -v '^#' ./test|sort -n)"
slurpy="$(cat ./test)"

main () {
  while read WATE
  do
    CRUNCHED=$(cruncher $WATE)
    XFUEL=$(xfuel $WATE)
    let TOTAL_XFUEL+=$XFUEL
    let TOTAL_CRUNCHED+=$CRUNCHED
    let TOTAL_FUEL+=$(($XFUEL + $CRUNCHED))
  done <<< "$slurpy"
  printf "TOTAL_FUEL=%d\n" $TOTAL_FUEL
}

time main $@
