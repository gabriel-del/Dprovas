#!/bin/bash
# set -x

for (( k=1; k<=$(ls -1 | wc -l); k++)) ;do
# for (( k=1; k<=8; k++)) ;do
k2="$(ls -1 | sed -n "$k"p)"
[[ -n $(ls "$k2" | grep u1) ]] && continue
cd "$k2" || exit
# MATERIAS

while [ -n "$(ls --ignore={u1,u2,u3,us,uf,ux})" ] ;do
    i2="$(ls -1 | sed -n 1p)"
    cd "$i2" || exit 
# PASTAS DATADAS

    while [ -n "$(ls)" ] ;do
	a="$(ls -1 | sed -n 1p)"
	d="x"
	for l in 1 2 3 ;do
	[[ -n $( echo "$a" | grep -E ""$l"ee|"$l"o|"$l"º|"$l"a|EE"$l"|"$l"ª|P"$l"|p"$l"|prova"$l"|"$l"E|"$l"Avaliacao|Prova "$l"|"$l" EE|"$l"_Aval|Gab_"$l"|esc. "$l"|"$l"°|Prova"$l"|"$l"prova|Gab"$l"|pfgab") ]] && d="$l"
         done
	 [[ -n $( echo "$a" | grep -E 'rimeir') ]] && d=1
	[[ -n $( echo "$a" | grep -E 'egund') ]] && d=2
	[[ -n $( echo "$a" | grep -E 'erceir') ]] && d=3 
	[[ -n $( echo "$a" | grep -E 'cham|Cham|2C') ]] && d=s 
	[[ -n $( echo "$a" | grep -E 'Final|final|PF') ]] && d=f 
	[[ $d == 2 ]] && [[ -n $( echo "$a" | grep -E 'chamada') ]] && d=s
	echo "$k2: $i2: $a -> $d"
	mkdir -p "../u$d" ; mkdir -p "../u$d/$i2"
	mv "$a" "../u$d/$i2" || exit
    done
    cd ..
    [[ -z "$(ls "$i2")" ]] && rm -rf "$i2" || exit

# FIM
done
cd ..
[[ -z $(pwd | grep Provas) ]] && exit
done
