#!/bin/bash

log(){
    echo ''
    echo '====================================='
    echo "$*"
    echo '====================================='
    echo ''
}

for file in ./Formula/*
do
    if test -f $file
    then
        authur_name=$(cat $file | grep "url" | cut -d '/' -f 4)
        formula_name=$(cat $file | grep "url" | cut -d '/' -f 5)

        log "./checker.sh $authur_name $formula_name"
        ./checker.sh $authur_name $formula_name
    fi
done
