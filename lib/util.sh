#!/bin/bash
cruncher () {
  numbo=$1
  answer=$(echo "($1 / 3) - 2"|bc)
  echo "$answer"
}
