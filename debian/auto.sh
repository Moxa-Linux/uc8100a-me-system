#!/bin/bash
files="$(find . -iname 'uc8100me*')"
for i in $files
do
	mv $i $(echo $i | sed 's/.\/uc8100me/uc8100a-me/')
done
