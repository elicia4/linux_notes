#!/bin/bash

for doc in $(/usr/bin/ls)
do
	mv $doc "$doc.md"
done

echo "done"
