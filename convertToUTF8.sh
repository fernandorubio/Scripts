#!/bin/bash

TYPE=""
CHAR=""
FILE=""

UTF="UTF-8"
ASCII="US-ASCII"
TEX="text"


find . -type f -exec file -bi {} \; -print0 | while read -d $'\0' info
do
	CHAR=$( echo $info | awk '{ print toupper($2) }' | cut -d "=" -f 2 )
	TYPE=$( echo $info | awk '{ print $1 }' | cut -d "/" -f 1 )
	FILE=$( echo $info | awk '{ print $3 }')
		
	if [ $TYPE == $TEX ]; then
		if [ $CHAR != $UTF ] && [ $CHAR != $ASCII ]; then
			$( iconv -f $CHAR -t $UTF $FILE -o $FILE )
			echo "Convert $CHAR $TYPE $FILE"
		fi
	fi
	
done 

exit 0
