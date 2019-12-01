#!/bin/bash
source lib/util.sh
slurpy="$(grep -v '^#' ./test|sort -n)"

TOTAL_WATE=0
TOTAL_CRUNCHED=0
while read WATE
do
  CRUNCHED=$(cruncher $WATE)
  let TOTAL_WATE+=$WATE
  let TOTAL_CRUNCHED+=$CRUNCHED
  printf "WATE=%d TOTAL_WATE=%d TOTAL_CRUNCHED=%d\n" $WATE $TOTAL_WATE $TOTAL_CRUNCHED
done <<< "$slurpy"
printf "end  TOTAL_WATE=%d TOTAL_CRUNCHED=%d\n" $TOTAL_WATE $TOTAL_CRUNCHED
