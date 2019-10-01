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

do_add() {
    if [[ -e .ptrs ]]; then
        for arg in $@; do
            echo $arg >> .ptrs
        done
    else
        echo "repoptr: fatal. repoptr not initilized"
        invalid_use
    fi
}

do_rm() {
    if [[ -e .ptrs ]]; then
        for arg in $@; do
            grep -q "$arg" < .ptrs
            if [[ $? -eq 0 ]]; then
                sed -i "/$arg/d" .ptrs
                echo $arg 'no longer pointed to'
            else
                echo 'Nothing to be removed'
            fi
        done
    else
        echo "repoptr: fatal. repoptr not initilized"
        invalid_use
    fi
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
elif [[ $1 == 'add' ]]; then
    do_add ${@:2}
elif [[ $1 == 'rm' ]]; then
    do_rm ${@:2}
fi


