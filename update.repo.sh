#!/bin/bash

update_repo(){
    cd homebrew-taps
    status=`git status | grep "working tree clean" &> /dev/null; echo "$?"`
    if [ "$status" == "1" ]; then
        git commit -am "${formula_name} ${v_version}" || exit 0
        git push  --quiet "https://${GITHUB_TOKEN}@${GH_REF}" master:master
    fi
    cd ..
}


[ "$0" = "update.repo.sh" ] && git clone https://${GH_REF}
[ "$0" = "update.repo.sh" ] && update_repo

