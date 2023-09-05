#!/bin/bash
export MSYS_NO_PATHCONV=1
mkdir -p logs
echo 'すべてのステップを順に実行します。'
read -p 'Enterを押してください: ' input
if [ "$input" != "y" ]; then clear; fi
for file in step-*.sh; do
    echo '===================================================' $file
    cat "$file"
    echo '==================================================='
    read -p 'このステップを実行します。Enterを押してください: '
    set -x
    source "$file"
    result=$?
    set +x

    input=''
    if [ $result -eq 0 ]; then
        read -p 'ステップの実行が完了しました。Enterを押してください: ' input
    else
        read -p 'エラーが発生しました。Enterで続行、Ctrl + Cで終了: ' input
    fi

    if [ "$input" != "y" ]; then clear; fi
done

echo 'すべてのステップの実行が終わりました。'
