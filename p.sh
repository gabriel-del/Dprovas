#!/bin/bash
# set -x

tre() { tree -fi $* | sed -n "2,+$(tree -fi $* | sed '1,4'd | wc -l)"p ;}
pwd="$(pwd)"

for i in $(seq 926) ;do 
# for i in $(seq 9) ;do 
# for i in $(seq 3) ;do 
pasta="$(tre -L 3 | sed -n "$i"p )" 
if [[ "$(echo $pasta | cut -d\/ -f 3)" =~ u1|u2|u3|uf|us ]] && [[ -n "$(echo $pasta | cut -d\/ -f 4)" ]] ;then 
	cd "$pasta" || exit
	echo "$pasta"

	while [ -n "$(ls | grep '\.PDF$')" ] ;do
	file="$(ls -1 | grep .PDF | sed -n 1p)"
	mv "$file" "$(echo "$file" | sed 's/.PDF/.pdf/g')" 
	done

	while [ -n "$(ls | grep '\.pdf$')" ] ;do
	a="$(ls -1 | grep .pdf | sed -n 1p)"
	ax="$(echo "$a" | sed 's/.pdf//g')"
	mkdir -p "$ax"
	mv "$a" "$ax"
	cd "$ax" || exit
	abiword --to=txt "$a"	
	mv "$ax.txt" "prova.md"
	sed -i '1s/^/---\n/g' "prova.md"
	sed -i "1s/^/title: $ax\n/g" "prova.md"
	sed -i '1s/^/---\n/g' "prova.md"
	mkdir img
	pdfimages -j "$a" ./img/
	[[ -z "$(ls img)" ]] && rm -rf img




	cd .. || exit
	done




cd "$pwd" || exit
fi
done

