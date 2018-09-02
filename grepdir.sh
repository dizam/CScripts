#!/bin/bash

DIRECTORY="$1"
PATTERN="$2"
shift 2
OPTIONS="$@"

if [[ (-d $DIRECTORY) && (! -z $PATTERN) && ("${OPTIONS:0:1}" == "-" ) ]]; then
    for f in $(find "$DIRECTORY")
    do
	if [[ (-f "$f") ]]; then
	    grep $OPTIONS "$PATTERN" "$f";
	fi
    done
elif [[ (-d $DIRECTORY) && (! -z $PATTERN) && (-z $OPTIONS) ]]; then
    for f in $(find "$DIRECTORY")
    do
	if [[ (-f "$f") ]]; then
	    grep "$PATTERN" "$f";
	fi
    done
else
	echo "usage: grepdir.sh directory pattern [-grep option]*";
fi

