#!/bin/bash

# 設定ファイルの読み込み
. "./config.txt"
MY_BASE_FILE_PATH=${base_file_path}
MY_PROJECT=${project}
MY_TITLE=${title}
MY_ACCESS_TOKEN=${access_token}

# ページのスクショを取得する
filename=$(echo $(./lib/screenshot $1))
renamed_filename=$(echo "${filename}" | cut -c 2- | rev | cut -c 2- | rev)
filepath="${MY_BASE_FILE_PATH}${renamed_filename}"

# gyazoにファイルをuploadする
response_json=$(curl -is https://upload.gyazo.com/api/upload?access_token=${MY_ACCESS_TOKEN} -F "imagedata=@${filepath}" | awk 'END{print}')
image_url=$(echo "${response_json}" | jq -r '.url')

# ファイルをscrapboxに貼る
open "https://scrapbox.io/${MY_PROJECT}/${MY_TITLE}?body=[${image_url}]"

# 画像のアーカイブ
mv ${filepath} ${MY_BASE_FILE_PATH}images/
