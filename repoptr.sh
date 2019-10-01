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
            grep -q "^$arg$" < .ptrs
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

do_list() {
    if [[ -e .ptrs ]]; then
        cat .ptrs
    else
        echo "repoptr: fatal. repoptr not initilized"
        invalid_use
    fi
}

do_update(){
    if [[ -e .ptrs ]]; then
        if [[ $1 == '--all' ]]; then
            repos=(`cat ".ptrs"`)
        else
            for repo in $@; do
                grep -q "^$repo$" < .ptrs
                if [[ $? -eq 0 ]]; then
                    repos+=($repo)
                else
                    echo "repoptr: $repo not pointed to"
                fi
            done
        fi
        for repo in $repos; do
            git clone $repo
        done
    else
        echo "repoptr: fatal. repoptr not initilized"
        invalid_use
    fi
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
elif [[ $1 == 'list' ]]; then
    do_list
elif [[ $1 == 'update' ]]; then
    do_update ${@:2}
fi