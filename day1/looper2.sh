#!/bin/bash
source lib/util.sh
slurpy="$(grep -v '^#' ./test|sort -n)"

TOTAL_WATE=0
TOTAL_XFUEL=0
TOTAL_CRUNCHED=0
while read WATE
do
  CRUNCHED=$(cruncher $WATE)
  XFUEL=$(xfuel $WATE)
  let TOTAL_WATE+=$WATE
  let TOTAL_XFUEL+=$XFUEL
  let TOTAL_CRUNCHED+=$CRUNCHED
  let TOTAL_FUEL+=$(($XFUEL + $CRUNCHED))
  printf "WATE=%d XFUEL=%d TOTAL_WATE=%d TOTAL_XFUEL=%d TOTAL_FUEL=%d TOTAL_CRUNCHED=%d\n" $WATE $XFUEL $TOTAL_WATE $TOTAL_XFUEL $TOTAL_FUEL $TOTAL_CRUNCHED
done <<< "$slurpy"
printf "end TOTAL_WATE=%d TOTAL_XFUEL=%d TOTAL_CRUNCHED=%d\n" $TOTAL_WATE $TOTAL_XFUEL $TOTAL_CRUNCHED
printf "TOTAL_FUEL=%d\n" $TOTAL_FUEL
