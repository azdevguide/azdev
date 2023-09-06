### Step 8: App Configurationにアクセスできるようになるまで待つ

# ロール割り当てが ID（サービスプリンシパル）に対して
# 行われた後、実際にそれが反映され、この ID を使用して
# App Configuration に格納されているデータにアクセスできるように
# なるまで、最大で 15 分かかる場合があります。

endpoint=$(az appconfig list -g $g --query '[].endpoint' -otsv)
proj99-azdev-tool wait-app-configuration --endpoint "$endpoint"
