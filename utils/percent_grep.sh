#!/bin/sh

if [[ -z "$1" || -z "$2" ]];
then
	echo "usage: percent_greph.sh <expression> <file>"
	echo "  spits out the % byte offset expression appears in the file"
	exit 1;
fi


BYTES=`wc -c $2 | sed -e 's/^ *//' | cut -f 1 -d ' '`
GREP=`grep -b "$1" $2`


for x in $GREP;
do
	OFFSET=`echo $x | cut -f 1 -d ':'`
	PERCENT=$(($OFFSET * 100 / $BYTES))
	LINE=`echo $x | cut -f 2 -d ':'`
	echo "$PERCENT%: $LINE"
done
