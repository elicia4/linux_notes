#!/bin/bash

myname="John"
myage="30"

echo "Hello, my name is $myname."
echo "I am $myage years old."
echo 'I am $myage years old.'

word="great"

echo "Linux is $word"
echo "Videogames are $word"
echo "Sunny days are $word"

files=$(ls)
echo "The contents of current directory are:"
echo $files

now=$(date)

echo "The system time and date is:"
echo $now

name="Jay"
now=$(date)
echo "Hello $name"
echo "The system time and date is:"
echo $now
echo "Your username is: $USER"
