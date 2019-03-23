#!/bin/bash

config(){
    git config --global user.name "$USERNAME" 
    git config --global user.email "$EMAIL"
}

push(){
    git commit -am "travis automated update" || exit 0
    git push  --quiet "https://${GITHUB_TOKEN}@${GH_REF}" master:master
}

$*