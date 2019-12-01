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
