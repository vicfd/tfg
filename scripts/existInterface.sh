#!/bin/sh

if [ -d "/sys/class/net/$1" ]; then
	echo 1
else
	echo 0
fi
