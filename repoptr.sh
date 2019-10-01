#!/bin/bash

invalid_use () {
    echo "repoptr: Invalid use. See repoptr --help "
    exit
}

help_output() {
    #TODO
    exit
}

do_init() {
    if [[ -e .ptrs ]]; then
        echo "Reinitialized existing repo pointers in $PWD/.ptrs/"
    else
        echo "Initialized repo pointers in $PWD/.ptrs/"
    fi
    touch .ptrs
}

check_ptrs() {
    rm temp 2>>/dev/null
    while read line; do
        line="$(echo "$line"|tr -d '\n')" # strip \n
        echo $line
        #git ls-remote $line
        git clone $line
        echo $?
        #if [[ $? -ne 0 ]]; then
        echo $line >> temp
        #fi
    done < .ptrs
}

if [[ $# -lt 1 ]]; then
    invalid_use
fi
if [[ $1 == '--help' ]] || [[ $1 == '-h' ]]; then
    help_output
elif [[ $1 == 'init' ]]; then
    do_init
fi
