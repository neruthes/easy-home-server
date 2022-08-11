#!/bin/bash

function _generate() {
    for texFilePath in $(find contents/ -name '*.tex' | sort); do
        echo '\input'"{./${texFilePath}}"
    done
}
_generate > contents.tex


function makePdf() {
    echo "[INFO] Making PDF..."
    ntex EasyHomeServer.tex >/dev/null
}

function uploadOss() {
    echo "[INFO] Uploading to OSS..."
    saveFileToNasOSS _dist/EasyHomeServer.pdf -P
}

if [[ -z $1 ]]; then
    echo "[INFO] Using the default build procedure."
    makePdf; makePdf; uploadOss
    exit 0
fi

if [[ "$1" == *'b'* ]]; then
    makePdf
fi
if [[ "$1" == *'B'* ]]; then
    makePdf; makePdf
fi
if [[ "$1" == *'u'* ]]; then
    uploadOss
fi
