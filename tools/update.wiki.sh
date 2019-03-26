#!/bin/bash

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
        wiki_commit "Updated" $2

    fi
}

wiki_commit(){
    cd homebrew-taps.wiki
    git add .
    status=`git status | grep "working tree clean" &> /dev/null; echo "$?"`
    if [ "$status" == "1" ]; then
        [ "$1" = "Updated" ] && git commit -m "Updated $2 (markdown)"
        [ "$1" = "Created" ] && git commit -m "Created $2 (markdown)"
    fi
    cd ..
}

updete_wiki(){
    cd homebrew-taps.wiki
    git push --quiet "https://${GITHUB_TOKEN}@${GH_WIKI}" master:master
    cd ..
}

[ "$0" = "tools/update.wiki.sh" ] && git clone https://${GH_WIKI}
[ "$0" = "tools/update.wiki.sh" ] && wiki_commit "Updated" "Home"
[ "$0" = "tools/update.wiki.sh" ] && updete_wiki
