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
  if [[ $this_crunch -gt 0 ]]; then
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

shift_array() {
  # Create nameref to real array
  local -n arr="$1"
  local n="${2:-1}"
  arr=("${arr[@]:${n}}")
}

printer2 () {
  echo printer2
  countzero=0
  for i in "${orig_slurpy[@]}"
  do
    printf "$countzero \t-\t$i "
    #echo -n "${orig_slurpy[$i]},"
    echo "${orig_slurpy[$i]}"
    ((++countzero))
  done
  echo done
}

printer1 () {
  countzero=0
  local new_slurpy=(${slurpy[@]})
  local function_set=0
  local first_term=0
  local second_term=0
  for i in "${new_slurpy[@]}"
  do
    printf "$countzero \t-\t$i "
    #echo ${slurpy[$i]}
    echo " "
    if [[ $countzero = 0 ]]; then
      if [[ $i -eq 1 ]]; then
        echo 'Adder engaged'
        function_set=1
      elif [[ $i -eq 2 ]]; then
        echo 'Multiplier engaged'
        function_set=2
      elif [[ $i -eq 99 ]]; then
        echo 'Full stop engaged'
        function_set=99
      fi
    elif [[ $countzero = 1 ]]; then
        echo 'second'
        first_term=$i
        echo "First term is $i"
    elif [[ $countzero = 2 ]]; then
        echo 'third'
        second_term=$i
        echo "Second term is $i"
    elif [[ $countzero = 3 ]]; then
        echo 'fourth'
        processor2 $function_set $first_term $second_term
        shift_array slurpy 4
        printer1
        #break
    fi
    ((++countzero))
  done
}

processor2 () {
  local set_function=$1
  local first_term=$2
  local second_term=$3
  local destination_term=$4
  local answer_return=0
  if [[ $set_function -eq 1 ]]; then
    answer_return=$(( ${orig_slurpy[${first_term}]} + ${orig_slurpy[${second_term}]} ))
    #printf "%d\t+ %d\t\t= %d into destination %d\n" ${orig_slurpy[${first_term}]} ${orig_slurpy[${second_term}]}  $answer_return $destination_term
    orig_slurpy["${destination_term}"]=${answer_return}
  elif [[ $set_function -eq 2 ]]; then
    answer_return=$(( ${orig_slurpy[${first_term}]} * ${orig_slurpy[${second_term}]} ))
    #answer_return=$(echo "${orig_slurpy[${first_term}]} * ${orig_slurpy[${second_term}]}" | bc)
    #printf "%d\t* %d\t\t= %d into destination %d\n" ${orig_slurpy[${first_term}]} ${orig_slurpy[${second_term}]}  $answer_return $destination_term
    orig_slurpy["${destination_term}"]=${answer_return}
  elif [[ $set_function -eq 99 ]]; then
    #echo halt
    local_havok=0
    #break
  fi
  #printf "orig_slurpy[%d] = %d\n" $destination_term ${orig_slurpy[$destination_term]}
}

processor1 () {
  countzero=0
  local new_slurpy=(${slurpy[@]})
  local function_set=0
  local first_term=0
  local second_term=0
  for i in "${new_slurpy[@]}"
  do
    if [[ $countzero -eq 0 ]]; then
      if [[ $i -eq 1 ]]; then
  #      echo -n 'Adder engaged, '
        function_set=1
      elif [[ $i -eq 2 ]]; then
  #      echo -n 'Multiplier engaged, '
        function_set=2
      elif [[ $i -eq 99 ]]; then
  #      echo -n 'Full stop engaged, '
        function_set=99
      fi
    elif [[ $countzero -eq 1 ]]; then
        first_term=$i
        #echo -n "First term is $i"
    elif [[ $countzero -eq 2 ]]; then
        second_term=$i
        #echo -n "Second term is $i"
    elif [[ $countzero -eq 3 ]]; then
        processor2 $function_set $first_term $second_term $i
        countzero=0
        shift_array slurpy 4
        processor1
        #break
    fi
    ((++countzero))
  done
}

tester1 () {
  echo one
}
