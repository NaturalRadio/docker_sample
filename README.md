# 1.はじめに
Dockerはweb開発者にとって必須と言ってもいいほど使用されているツールです。   
  こちらを通してDockerのrails6を動作させることができます。


# 2.今回の目的
・Dockerの概念、操作方法を学ぶ
・Dockerでの開発環境構築方法を学ぶ


# 3.今回の勉強会で必要なもの
MacOS 10.13以上のOS


# 4.前提知識
あると良い知識
・Linuxの基礎知識
①cd,ls,pwdといった基礎的なコマンド
②yum, apt-getといったパッケージ管理ツールの管理コマンド
③ディレクトリ（フォルダ）の概念の理解
・ネットワークの基礎知識
①IPアドレスやサブネットの基礎知識
②ドメインやDNSの基礎知識


# 5.dockerってなに？
・コンテナ型仮想環境を作成、実行、管理するためのプラットフォーム
・Dockerソフトウェアを使って素早くコンテナを起動し、様々なアプリケーションを実行することができる
・異なる環境（PCやサーバ）で簡単に同じ環境を再現できる
・Dockerのソフトウェア自体はGo言語で書かれている

## 5-2.Dockerのユースケース
・アプリケーション開発環境
・検証環境、本番環境
・Webサーバ、データベースサーバなどの環境
・各種プログラミング言語の実行環境
・その他の様々なミドルウェアの環境構築


## 5-3.Dockerを使うメリット
・プログラムの実行環境を素早く立ち上げることができる
・再現性のある環境を用意できる。→サーバで動かす場合も差異が生まれにくくエラーを予防できる
・設定ファイルを共有することでプロジェクトメンバー間で同じ環境を立ち上げることができる。
・PC環境を汚さなくてすむ


# 6.Dockerのインストール、起動確認
https://www.docker.com/ にアクセス
Products→Docker Desctop→Mac with intelchipをダウンロード
APPからDockerを起動(起動中はアイコンが動いてます)
動作確認
ターミナル→docker run hello-world→Hello from Dockerが表示されていればOK※因みにターミナルはitern2がオススメです。https://orebibou.com/ja/home/201512/20151207_001/

# 7.Dockerを使ってRailsを起動してみよう！
では実際にDockerを使ってrailsを実行してみましょう。

①任意のディレクトリにdocker_sampleディレクトリ作成
②作成したディレクトリに以下のファイルを作成
Dockerfile
Docker-compose.yml
Gemfile
Gemfile.lock
③[こちら](https://github.com/NaturalRadio/docker_sample)のGitから記述をコピー
記述の解説はgitファイル内に記述
④ターミナルにて
docker-compose run web rails new . --force --database=mysql —forceは、既存のファイルを上書きするオプション、—database=mysqlは、MySQLを使用する設定を入れるオプション
⑤docker-compose buildでコンテナにbundle installさせる
⑥config/databese.ymlの以下の箇所を修正
```
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  <!-- ここから修正 -->
  username: <%= ENV.fetch("MYSQL_USERNAME", "root") %>
  password: <%= ENV.fetch("MYSQL_PASSWORD", "admin") %>
  <!-- ここまで修正 -->
  host: <%= ENV.fetch("MYSQL_HOST", "db") %>
```
⑦docker-compose run web rails db:create
⑧docker-compose upでコンテナを起動⑨localhost::3000で立ち上がっているか確認

以上で動作確認完了です。