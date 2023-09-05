default: steps

# `### `で始まるコメントを目印に、スクリプトをステップに分割
steps:
	bash -xe scripts/divide.azcli
# ステップをインタラクティブに実行
run:
	bash run.sh
# step-*.sh をノンインタラクティブに実行し、実行結果例を作成
example:
	bash -xe scripts/example.azcli
# step-*.sh をノンインタラクティブに実行し、実行結果例と比較
test:
	bash -xe scripts/test.azcli
# ソースコードを code フォルダにバックアップ
backup:
	bash -xe scripts/backup.azcli
# プロジェクトを作成する前の状態に戻す
reset:
	bash -xe scripts/reset.azcli
