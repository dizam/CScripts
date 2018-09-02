#!/bin/bash

DIRECTORY1="$1"
DIRECTORY2="$2"
DIRECTORY3="$3"
shift 3
EXTRA="$@"

if [[ (! -d $DIRECTORY1) || (! -d $DIRECTORY2) || (-f $DIRECTORY3) || (! -z $EXTRA) ]]; then
    echo "usage: cpdirs.sh source_directory1 source_directory2 dest_directory";
else
    for f in "$DIRECTORY1"/*; do
	filename="$(basename "$f")"
	if [[ (-f "$DIRECTORY2/$filename") && (-e "$DIRECTORY2/$filename") ]]; then
	    if [[ ("$f" -nt "$DIRECTORY2/$filename") ]]; then
		cp "$f" "$DIRECTORY3";
	    else
		cp "$DIRECTORY2/$filename" "$DIRECTORY3";
	    fi
	fi
    done 
    string=$(diff "$DIRECTORY1" "$DIRECTORY2")
    tokens=($string)
    n=0
    for i in $string; do
	if [[ ("$i" == *:) ]]; then
	    path1=${tokens[n]%?}
	    path2=${tokens[n+1]}
	fi
	let n=$n+1
	if [[ (-f "$path1/$path2") ]]; then
	    cp "$path1/$path2" "$DIRECTORY3";
	fi
    done
fi
  
