#!/bin/bash

source tools/checker.sh
source tools/update.repo.sh
source tools/update.wiki.sh


log_0(){
    echo ''
    echo '====================================='
    echo "$*"
    echo '====================================='
    echo ''
}

EXCLUDE_LIST=("shadowsocks")
EXCLUDE=($(printf '%s\n' "${EXCLUDE_LIST[@]}" | sort))

log_0 "Start"

git clone https://${GH_REF}
git clone https://${GH_WIKI}

set i=0
for file in ./Formula/*
do
    formula_desc=$(cat $file | grep "desc" | cut -d '"' -f 2)
    authur_name=$(cat $file | grep "url" | cut -d '/' -f 4)
    formula_name=$(cat $file | grep "url" | cut -d '/' -f 5)

    if [ "$formula_name" = "${EXCLUDE[$i]}" ]; then

        log_0 "Passing ${EXCLUDE[$i]}"
        i=$i+1

    elif test -f $file; then

        log_0 "Checking $formula_name"

        checker $authur_name $formula_name

        readme_checker $formula_name $v_version

        wiki_checker $authur_name $formula_name $v_version
        
    fi
done

log_0 "done."