#!/bin/bash

update_repo(){
    cd homebrew-taps
    status=`git status | grep "working tree clean" &> /dev/null; echo "$?"`
    if [ "$status" == "1" ]; then
        git commit -am "travis automated update" || exit 0
        git push  --quiet "https://${GITHUB_TOKEN}@${GH_REF}" master:master
    fi
    cd ..
}


[ "$0" = "tools/update.repo.sh" ] && git clone https://${GH_REF}
[ "$0" = "tools/update.repo.sh" ] && update_repo

