#!/bin/bash
# set -e ：「エラーが発生するとスクリプトを終了する」の意
set -e
# rm -f...：「railsのpidが存在している場合に削除する」処理
rm -f /myapp/tmp/pids/server.pid
# exec "$@"：DockerfileのCMDで渡されたコマンド（→Railsのサーバー起動）を実行
exec "$@"