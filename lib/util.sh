#!/bin/bash
cruncher () {
  numbo=$1
  answer=$(echo "($numbo / 3) - 2"|bc)
  echo "$answer"
}
