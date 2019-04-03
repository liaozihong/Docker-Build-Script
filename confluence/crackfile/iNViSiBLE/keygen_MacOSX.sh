#!/bin/sh

JAVA=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/bin/java
JAR=confluence_keygen.jar

DIR=`echo $0 | sed -E 's/\/[^\/]+$/\//'`
if [ "X$0" != "X$DIR" ]; then
	cd $DIR
fi

RUN=true
while [ $RUN == "true" ]; do
	$JAVA -jar $JAR
	if [ $? -ne 10 ]; then RUN=false; fi
done