#!/bin/bash

log_1(){
    echo ''
    echo '====================================='
    echo "$*"
    echo '====================================='
    echo ''
}

log_2(){
    echo ''
    echo '-------------------------------------'
    echo "$*"
    echo '-------------------------------------'
    echo ''
}

loop_parser(){
    while true
    do
       result=$(curl -s https://api.github.com/repos/"$authur_name"/"$formula_name"/releases/latest | grep "$1" | cut -d '"' -f 4)
       if [ ! -z "$result" ]; then
        echo $result
        break
       fi
    done
}

checker(){
    authur_name=$1
    formula_name=$2
    typeset -l file_name
    file_name=$formula_name
    
    log_2 "parser $formula_name download url"

    v_version=$( loop_parser "tag_name" )

    if [ -z "$v_version" ]; then

        log_2 'parser file version error, skip update.'
        exit 0

    fi

    download_url="https://github.com/$authur_name/$formula_name/archive/"$v_version".tar.gz"

    if [ -z "$download_url" ]; then

        log_2 'parser download url error.'
        exit 0

    fi

    log_2 "download url: $download_url  start downloading..."

    # wget -c $download_url -O $formula_name.$v_version.tar.gz
    curl -L  $download_url > $formula_name.$v_version.tar.gz

    if [ ! -e $formula_name.$v_version.tar.gz ]; then

        log_2 "file download failed!"
        exit 1

    fi

    v_hash256=$(sha256sum $formula_name.$v_version.tar.gz |cut  -d ' ' -f 1)

    log_2 "file hash: $v_hash256 parser $formula_name version..."

    log_2 "update config...."

    sed -i "s#^\s*version.*#  version \"$v_version\"#g" homebrew-taps/Formula/$file_name.rb
    sed -i "s#^\s*sha256.*#  sha256 \"$v_hash256\"#g" homebrew-taps/Formula/$file_name.rb

    log_2 "update config done."
}

git clone https://github.com/Mogeko/homebrew-taps.git

for file in ./Formula/*
do
    if test -f $file; then

        authur_name=$(cat $file | grep "url" | cut -d '/' -f 4)
        formula_name=$(cat $file | grep "url" | cut -d '/' -f 5)

        if [ $formula_name != "shadowsocks" ]; then

            log_1 "./checker.sh $authur_name $formula_name"
            checker $authur_name $formula_name

        fi

    fi
done

log_1 "start update repo..."

cd homebrew-taps

chmod +x tools/deploy.sh
tools/deploy.sh push

log_1 "done."