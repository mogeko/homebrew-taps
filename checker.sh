
#!/bin/bash

typeset -l FILE_NAME

AUTHUR_NAME=$1
FORMULA_NAME=$2
FILE_NAME=$FORMULA_NAME

log(){
    echo ''
    echo '-------------------------------------'
    echo "$*"
    echo '-------------------------------------'
    echo ''
}

loop_parser(){
    while true
    do
       result=$(curl -s https://api.github.com/repos/"$AUTHUR_NAME"/"$FORMULA_NAME"/releases/latest | grep "$1" | cut -d '"' -f 4)
       if [ ! -z "$result" ]; then
        echo $result
        break
       fi
    done
}

log "parser $FORMULA_NAME download url"

V_VERSION=$( loop_parser "tag_name" )

# V_VERSION=$(echo ${V_VERSION:1})

if [ -z "$V_VERSION" ]; then

    log 'parser file version error, skip update.'
    exit 0

fi

DOWNLOAD_URL="https://github.com/Wind4/vlmcsd/archive/"$V_VERSION".tar.gz"

if [ -z "$DOWNLOAD_URL" ]; then

    log 'parser download url error, skip updv2ray-coreate.'
    exit 0

fi

log "download url: $DOWNLOAD_URL  start downloading..."

curl -L  $DOWNLOAD_URL > $FORMULA_NAME.source.tar.gz


if [ ! -e $FORMULA_NAME.source.tar.gz ]; then
    log "file download failed!"
    exit 1
fi

V_HASH256=$(sha256sum $FORMULA_NAME.source.tar.gz |cut  -d ' ' -f 1)

log "file hash: $V_HASH256 parser $FORMULA_NAME version..."

log "file version: $V_VERSION start clone..."

git clone https://github.com/Mogeko/homebrew-taps.git

log "update config...."

sed -i "s#^\s*version.*#  version \"$V_VERSION\"#g" homebrew-taps/Formula/$FILE_NAME.rb
sed -i "s#^\s*sha256.*#  sha256 \"$V_HASH256\"#g" homebrew-taps/Formula/$FILE_NAME.rb


log "update config done. start update repo..."

cd homebrew-taps
git commit -am "travis automated update"
git push  --quiet "https://${GITHUB_TOKEN}@${GH_REF}" master:master

log "update repo done."