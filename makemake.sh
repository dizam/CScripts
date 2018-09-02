#!/bin/bash

EXECNAME="$1"
shift 1
PARAMETERS="$@"

if [[ (-z $EXECNAME) ]]; then
    echo "Executable name required.";
    echo "usage: makemake.sh executable_name";
else
   # FILENAMES=$(find . -name '*.cpp' | cut -d "/" -f2 | cut -d "." -f1)
    FILENAMES=$(ls *.cpp)
    echo -n "$EXECNAME :" >> Makefile
    for f in $FILENAMES; do
	echo -n " ${f%.*}.o" >> Makefile
    done
    echo "  " >> Makefile
    if [[ (-z $PARAMETERS) ]]; then
	echo -en "\tg++ -ansi -Wall -g -o $EXECNAME$PARAMETERS" >> Makefile
    else
	echo -en "\tg++ -ansi -Wall -g -o $EXECNAME $PARAMETERS" >> Makefile
    fi
    for f in $FILENAMES; do
	echo -n " ${f%.*}.o" >> Makefile
    done
    echo -en "  " >> Makefile
    for g in $FILENAMES; do
	echo -e "\n" >> Makefile
	echo -n "${g%.*}.o : $g " >> Makefile
	echo -n `grep '#include \"' "$g" | cut -d '"' -f2` >> Makefile
	echo -n " " >> Makefile
	if [[ (-z $PARAMETERS) ]]; then
	    echo -en "\n\tg++ -ansi -Wall -g -c$PARAMETERS $g" >> Makefile
	else
	    echo -en "\n\tg++ -ansi -Wall -g -c $PARAMETERS $g" >> Makefile
	fi
    done
    echo -e "\n" >> Makefile
    echo "clean : " >> Makefile
    echo -en "\trm -f $EXECNAME " >> Makefile
    for h in $FILENAMES; do
	echo -n "${h%.*}.o  " >> Makefile
    done
    echo " " >> Makefile
fi



