#!/bin/bash

code_length=0
code=0

clear

echo "Welcome, please select a code length.\n\n1 for 1 digits || 2 for 2 digits || 3 for 3 digits || 4 for 4 digits ||"
printf "\n"
echo "1. 3 digits"
echo "2. 4 digits"
echo "3. 5 digits"
echo "4. 6 digits"
printf "\n"
read code_length

printf "\n"
echo "Okay, let's get started with a $code_length digit long code."

if [ "$code_length" != "3"] || ["$code_length" != "4"] || ["$code_length" != "5"] || ["$code_length" != "6"]
then
    sleep 1
    if [ "$code_length" = "3" ]
    then
        code="echo $((1 + RANDOM % 100))"
    elif [ "$code_length" = "4" ]
    then
        code="echo $((1 + RANDOM % 1000))"
    elif [ "$code_length" = "5" ]
    then
        code="echo $((1 + RANDOM % 10000))"
    elif [ "$code_length" = "6" ]
    then
        code="echo $((1 + RANDOM % 100000))"
    fi
fi

echo "Alright, I've come up with a code. Now it's time for your to guess it!"

sleep 1

echo "Please enter a $code_length long code to guess"
read code_guess