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

readme_checker(){
    old_version=$(cat README.md | grep "$1" | cut -d ' ' -f 4)

    if [ "$old_version" = "" ]; then

        sed -i "- ['$1'](https://github.com/Mogeko/homebrew-taps/wiki/'$1') - '$2' - '"$formula_desc" homebrew-taps/README.md"
        sed -i "- ['$1'](https://github.com/Mogeko/homebrew-taps/wiki/'$1') - '$2' - '"$formula_desc" homebrew-taps.wiki/Home.md"
        wiki_commit "Updated" "Home"

    else

        sed -i "s/$1) \- ${old_version}/$1) - $2/g" homebrew-taps/README.md
        sed -i "s/$1) \- ${old_version}/$1) - $2/g" homebrew-taps.wiki/Home.md
        wiki_commit "Updated" "Home"

    fi
}

wiki_checker(){
    if [ ! -f "homebrew-taps.wiki/$2.md" ]; then

        touch "homebrew-taps.wiki/$2.md"
        echo "> Github: [$1/$2](https://github.com/$1/$2)<br>" >> "homebrew-taps.wiki/$2.md"
        echo "> Author: [$1](https://github.com/$1)<br>" >> "homebrew-taps.wiki/$2.md"
        echo "> Version: $3<br>" >> "homebrew-taps.wiki/$2.md"
        echo "" >> "homebrew-taps.wiki/$2.md"
        echo "$formula_desc" >> "homebrew-taps.wiki/$2.md"
        echo "" >> "homebrew-taps.wiki/$2.md"
        echo "## Install" >> "homebrew-taps.wiki/$2.md"
        echo "" >> "homebrew-taps.wiki/$2.md"
        echo "\`\`\`" >> "homebrew-taps.wiki/$2.md"
        echo "brew install $2" >> "homebrew-taps.wiki/$2.md"
        echo "\`\`\`" >> "homebrew-taps.wiki/$2.md"
        echo "" >> "homebrew-taps.wiki/$2.md"
        wiki_commit "Created" $2

    else

        sed -i "s/^> Version: .*$/> Version: $3<br>/g" "homebrew-taps.wiki/$2.md"
        wiki_commit "Created" $2

    fi
}

wiki_commit(){
    cd homebrew-taps.wiki

    git add .
    [ "$1" = "Updated" ] && git commit -m "Updated $2 (markdown)"
    [ "$1" = "Created" ] && git commit -m "Created $2 (markdown)"

    cd ..
}


log_1 "Start"

git clone https://${GH_REF}
git clone https://${GH_WIKI}

for file in ./Formula/*
do
    if test -f $file; then

        authur_name=$(cat $file | grep "url" | cut -d '/' -f 4)
        formula_name=$(cat $file | grep "url" | cut -d '/' -f 5)
        formula_desc=$(cat $file | grep "desc" | cut -d '"' -f 2)

        if [ $formula_name != "shadowsocks" ]; then

            log_1 "checker $authur_name $formula_name"
            checker $authur_name $formula_name

            log_1 "update README.md..."
            readme_checker $formula_name $v_version
            log_1 "update README.md done."

            log_1 "update Wiki..."
            wiki_checker $authur_name $formula_name $v_version
            log_1 "update Wiki done."

        fi

    fi
done


log_1 "start update repo..."

cd homebrew-taps
git commit -am "travis automated update" || exit 0
git push  --quiet "https://${GITHUB_TOKEN}@${GH_REF}" master:master
cd ..

log_1 "update done."


log_1 "start update wiki..."

cd homebrew-taps.wiki
git push --quiet "https://${GITHUB_TOKEN}@${GH_WIKI}" master:master
cd ..

log_1 "update done."


log_1 "done."