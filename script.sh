#!/bin/bash
for i in $(seq 18)
do
  pasta="$(ls -1 | sed -n "$i"p)"
  cd "$pasta" || exit
  for j in $(ls)
  do
    cd "$j" || exit
    for k in $(ls)
    do
      [[ "$(ls "$k" | wc -l ) " -ne 1 ]] && echo "$i - $j - $k"
    done
  cd .. || exit
done
cd .. || exit
done
