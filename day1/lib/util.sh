#!/bin/bash
cruncher () {
  numbo=$1
  #answer=$(echo "($numbo / 3) - 2"|bc)
  preanswer=$(($numbo / 3))
  answer=$(( $preanswer - 2 ))
  #return $answer
  #echo $answer
  printf "%d" $answer
}

xfuel () {
  this_crunch=$(cruncher $1)
  if [[ $this_crunch > 0 ]]; then
    req_xfuel=$this_crunch
  else
    req_xfuel=0
  fi
  #echo "this req_fuel $req_xfuel"
  #echo 'starting loop'
  while [[ $this_crunch -gt 0 ]]; do
    this_crunch=$(cruncher $this_crunch)
  #  echo "this crunch $this_crunch"
    if [[ $this_crunch -lt 0 ]]; then
      break
    elif [[ $this_crunch -gt 0 ]]; then
      req_xfuel=$((req_xfuel + this_crunch))
  #    echo "this req_fuel $req_xfuel"
    fi
  done
  echo "$req_xfuel"
}
