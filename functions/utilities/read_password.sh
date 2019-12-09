#!/bin/bash

read_password () {
    password=''
    while IFS= read -r -s -n1 char; do
        [[ -z $char ]] && { printf '\n'; break; }
        if [[ $char == $'\x7f' ]]; then
            [[ -n $password ]] && password=${password%?}
            printf '\b \b' 
        else
            password+=$char
            printf '*'
        fi
    done
}