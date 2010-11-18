#!/bin/sh

TOOLS_DIR=`dirname $0`
CODE_DIR=`dirname $TOOLS_DIR`

if [[ -z $1 || -z $2 ]]
then
	echo "usage: exec_on_change.sh <directory|file> 'comamnd to execute'";
	echo "i.e. sudo exec_on_change.sh src/ 'apachectl restart'"
	echo "Monitors a directory for changes then executes the command"
	exit 1;
fi

# Loop infinitely than sleep for 1 second
while [[ 1 ]];
do
# The guts, find files that:
# Have modification time less than 1 second ago
# Is a FILE not a directory/symlink/etc...
# Does not begin with a '.' (looking at you vim swap files)
OUTPUT=`find $1 -mtime '1s' -type f -name "[^.]*" ` 

if [ ! -z "$OUTPUT" ]
then
	DATE=`date "+%Y-%m-%d::%H%:%M:%S"`
	echo "$DATE\tChange detected. Executing $2..."
	$2
fi
sleep 1;
done
