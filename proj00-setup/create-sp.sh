#!/bin/bash
set -euo pipefail

az account show && :
if [ $? -ne 0 ]; then
	echo '事前にaz loginを実行してください。'
	exit 1
fi

function setenvcmd () {
	printf '環境変数を設定します. キー: [%s], 値: [%s]\n' "$1" "$2"
	case `uname` in
		MINGW*|CYGWIN* ) setx "$1" "$2" ;;
		Darwin )
			if [ -f ~/.bashrc ]; then
				echo "export $1=$2" >> ~/.bashrc
			fi
			if [ -f ~/.zshrc ]; then
				echo "export $1=$2" >> ~/.zshrc
			fi
			;;
		* ) echo 'エラー: OSの判別に失敗しました'; exit 1
	esac
}

echo 'サービスプリンシパルの名前を生成します'
spname=azdevsp-$(date|shasum|head -c6)
echo 生成されたサービスプリンシパル名: $spname
setenvcmd 'AZDEVSP_NAME' "$spname"

echo "サービスプリンシパル $spname を作成します"
az ad sp create-for-rbac \
--name "$spname" \
--create-cert --years 3 \
-oyaml |while read -r line; do
	key=`echo "$line" |cut -d: -f1`
	value=`echo "$line" |cut -d: -f2- |sed 's/^ //'|tr -d '\r\n'`
	case "$key" in
		"appId" )                     envkey='AZURE_CLIENT_ID' ;;
		"fileWithCertAndPrivateKey" ) envkey='AZURE_CLIENT_CERTIFICATE_PATH' ;;
		"tenant" )                    envkey='AZURE_TENANT_ID' ;;
		* )                           continue ;;
	esac
	setenvcmd "$envkey" "$value"
	# for Dev Container
	if [ "$envkey" = "AZURE_CLIENT_CERTIFICATE_PATH" ]; then
		cp "$value" ~/.azure/sp.pem
	fi
done

value=`az ad sp list --filter "displayName eq '$spname'" --query '[].id' -otsv|tr -d '\r\n'`
setenvcmd 'AZDEVSP_OBJECT_ID' "$value"
setenvcmd 'AZDEVSP_NAME' "$spname"

cat <<'EOF'
環境変数の設定が完了しました。
Windowsの場合は「環境変数」
（システムのプロパティ＞環境変数＞[ユーザー名]のユーザー環境変数）、
macOSの場合はファイル`~/.zshrc`にて、設定された値を確認できます。
Visual Studio Codeにてこの環境変数を反映させるため、
Visual Studio Codeを完全に終了させてから、再度開いてください。
EOF
