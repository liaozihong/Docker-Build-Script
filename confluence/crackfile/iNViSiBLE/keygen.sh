#!/bin/bash
jarfile=confluence_keygen.jar
check=`which java`
if [ -f `pwd`/$jarfile ]
then
	if [ -n "$check" ]
	then
		java -jar $jarfile
	else
		echo -e "Failed to locate java executable!\nPlease install Java Runtime Environment (JRE) and try again."
	fi
else
	echo "Failed to locate $jarfile."
fi
