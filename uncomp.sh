#!/bin/bash

FILELIST="$@"

if [[ (-z $FILELIST) ]]; then
    echo "usage: uncomp {filelist}+";
fi

for f in $FILELIST; do
    if [[ ("$f" == *.tar) ]]; then
	tar -xf "$f";
    elif [[ ("$f" == *.tar.gz) || ("$f" == *.tgz) ]]; then
	tar -xzf "$f";
    elif [[ ("$f" == *.gz) ]]; then
	gunzip "$f";
    elif [[ ("$f" == *.zip) ]]; then
	unzip -q "$f";
    else
	echo "uncomp: $f has no compression extension.";
    fi
done
