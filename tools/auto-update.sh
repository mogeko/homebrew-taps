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

log_0 "Start"

git clone https://${GH_REF}
git clone https://${GH_WIKI}

for file in ./Formula/*
do
    if test -f $file; then

        authur_name=$(cat $file | grep "url" | cut -d '/' -f 4)
        formula_name=$(cat $file | grep "url" | cut -d '/' -f 5)
        formula_desc=$(cat $file | grep "desc" | cut -d '"' -f 2)

        if [ $formula_name != "shadowsocks" ]; then

            log_0 "checker $authur_name $formula_name"
            checker $authur_name $formula_name

            log_0 "update README.md..."
            readme_checker $formula_name $v_version
            log_0 "update README.md done."

            log_0 "update Wiki..."
            wiki_checker $authur_name $formula_name $v_version
            log_0 "update Wiki done."

        fi

    fi
done

log_0 "done."