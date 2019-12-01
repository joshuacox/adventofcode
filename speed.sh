#!/bin/bash
source lib/util.sh
#slurpy="$(grep -v '^#' ./test|sort -n)"
slurpy="$(cat ./test)"

main () {
  TOTAL_CRUNCHED=0
  while read WATE
  do
    CRUNCHED=$(cruncher $WATE)
    let TOTAL_CRUNCHED+=$CRUNCHED
  done <<< "$slurpy"
  printf "TOTAL_CRUNCHED=%d\n" $TOTAL_CRUNCHED
}

time main $@
