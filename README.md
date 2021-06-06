#1.はじめに
Dockerはweb開発者にとって必須と言ってもいいほど使用されているツールです。
こちらを通してDockerのrails6を動作させることができます。


#2.今回の目的
・Dockerの概念、操作方法を学ぶ
・Dockerでの開発環境構築方法を学ぶ


#3.今回の勉強会で必要なもの
MacOS 10.13以上のOS


#4.前提知識
あると良い知識
・Linuxの基礎知識
①cd,ls,pwdといった基礎的なコマンド
②yum, apt-getといったパッケージ管理ツールの管理コマンド
③ディレクトリ（フォルダ）の概念の理解
・ネットワークの基礎知識
①IPアドレスやサブネットの基礎知識
②ドメインやDNSの基礎知識


#5.dockerってなに？
・コンテナ型仮想環境を作成、実行、管理するためのプラットフォーム
・Dockerソフトウェアを使って素早くコンテナを起動し、様々なアプリケーションを実行することができる
・異なる環境（PCやサーバ）で簡単に同じ環境を再現できる
・Dockerのソフトウェア自体はGo言語で書かれている

##5-2Dockerのユースケース
・アプリケーション開発環境
・検証環境、本番環境
・Webサーバ、データベースサーバなどの環境
・各種プログラミング言語の実行環境
・その他の様々なミドルウェアの環境構築


##5-3Dockerを使うメリット
・プログラムの実行環境を素早く立ち上げることができる
・再現性のある環境を用意できる。→サーバで動かす場合も差異が生まれにくくエラーを予防できる
・設定ファイルを共有することでプロジェクトメンバー間で同じ環境を立ち上げることができる。
・PC環境を汚さなくてすむ


#6Dockerのインストール、起動確認
https://www.docker.com/にアクセス
Products→Docker Desctop→Mac with intelchipをダウンロード
APPからDockerを起動(起動中はアイコンが動いてます)
動作確認
ターミナル→docker run hello-world→Hello from Dockerが表示されていればOK※因みにターミナルはitern2がオススメです。https://orebibou.com/ja/home/201512/20151207_001/

#7Dockerを使ってRailsを起動してみよう！
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





#補足用語補足用語解説
デプロイ
作成したプログラムをサーバーに配置して、設定、起動を行い利用できる状態にすることをデプロイと言います。「Webアプリケーションをデプロイする」といった文脈では、新規に作成したアプリケーション、もしくは機能追加等の変更を行ったプログラムをサーバーに反映して新しいWebアプリケーションを利用できる様に配置する作業を行うことを指します。
仮想環境
パソコンやサーバなど一つのハードウェアの中で、仮想的な環境を構築したものをいいます。例えば、1台のサーバーのなかに複数の仮想環境を作ることで、1つのハードウェアで複数のサーバーを仮想的に動作させることができます。CPUやメモリ、ハードディスクといった物理的なリソースは、仮想環境ごとに論理的に割り当てて利用することになります。
Docker Desktop
PCでDockerを動作させるために使用するソフトウェアです。
Docker Toolbox
Docker Desktopと同様にPCでDockerを動作させるために使用するソフトウェアです。ただし、Docker ToolboxはDocker Desktopが使用できないOSバージョンの場合に使用可能なもので、Docker Desktopには機能的に劣る部分があります。可能な限りはDocker Desktopの使用が推奨されています。
レガシーソフトウェア
レガシーソフトウェアとは、過去の技術や仕組みで構築されているソフトウェアを指します。PC用のDockerソフトウェアとしては、Docker Toolboxはレガシーなソフトウェアです。Docker Desktopに対応していないOSの為に使うことができますが、機能的にはあまり進化しておらず、新しい機能などはDocker Desktopでないと使えないケースもあります。
Dockerイメージ
Dockerコンテナを作成するための雛形となるものです。Dockerイメージは、アプリケーション、ライブラリ、設定ファイルなどのアプリケーション実行に必要なもの一式をまとめたものになります。出来上がったアプリケーションをDockerイメージとして保存して、別のサーバーに持っていくことで同じ環境（コンテナ）を別のサーバー上で再現することができます。
Dockerコンテナ
Dockerイメージを元に作成されるコンテナ型仮想環境のことをDockerコンテナ、または単にコンテナと呼びます。イメージからコンテナを作成することで、何度でも簡単に同じコンテナ（仮想環境）を作成することができます。コンテナを起動することで、予めイメージにセットアップしたアプリケーションの機能を提供することができます。
Docker Hub
Dockerイメージを保存するための機能などを提供しているサービスです。ベンダーや他のユーザーが作ったイメージも公開されており、公開されているイメージをダウンロードすることで様々なコンテナを起動することができます。また、Docker Hubの様にイメージを保管するための機能を持ったものをレジストリと呼びます。
nginx
Webサーバーのソフトウェアです。ホームページの公開や、アプリケーションサーバーの前段でアクセスを捌く場合などに利用されます。
Apache
nginxと同様にWebサーバーのソフトウェアです。
MySQL
データベースサーバーのソフトウェアです。RDBMS（リレーショナルデータベースマネジメントシステム）の一種です。Webアプリケーションのデータ保存先としてよく使用されます。
Postgresql
MySQLと同様にデータベースサーバーのソフトウェアです。
Ubuntu
Linux OSのディストリビューションの1つです。
Redis
Key-Value型でデータを保存するキーバリューストアと呼ばれるデータベースシステムの一種です。メモリ上にデータを保持して高速に動作します。アプリケーションのデータのキャッシュや、セッション情報の保存によく使用されます。
Node.js
Javascriptの実行環境で、サーバー上でJavascriptのプログラムを実行することができます。
ホストOS
仮想化において、仮想サーバーを起動させる側のOSのことをホストOSと言います。ホストOS上に仮想化のソフトウェアをインストールすることで、仮想マシンを作成して複数の仮想環境を起動することができます。
ゲストOS
仮想化において、ホストOS上に作成された仮想マシン上で動作するOSのことをゲストOSと言います。
Virtual Machine（VM）
仮想環境のことをVirtual Machineや略してVMと呼びます。一般的にはホスト型仮想化の仮想マシンのことを指します。
ホスト型仮想化
ホストOSにハイパーバイザーと呼ばれる仮想化の機能を用意して行う仮想化のことをホスト型仮想化と言います。ハイパーバイザーの機能を提供するソフトウェアとしては、Virtual Box、Hyper-V、VMwareなどがあります。ホストOSに依存せずに仮想マシンに好きなOSをインストールできる点や、仮想マシン間の分離レベルが高い点などがコンテナ仮想化と異なります。
コンテナ型仮想化
Dockerといったコンテナ仮想化を行うソフトウェアを用いて行う仮想化をコンテナ型仮想化と言います。Dockerの場合はDockerエンジンによってコンテナの作成、削除などの管理が行われます。ホスト型とは異なり、ゲストOSというものはなく、ホストOSのカーネルを共有してアプリケーションが実行されます。
ハイパーバイザー
ホスト型仮想化の仮想マシンを管理するための機能を提供するものがハイパーバイザーです。ホストOSとゲストOSの間を仲介する形でハイパーバイザーが機能します。
Dockerエンジン
Dockerにおいてコンテナ型仮想化を実現するためのコアとなる機能を持った部分がDockerエンジンです。Dockerエンジンによってコンテナ作成などの機能が提供されます。
オーバーヘッド
コンピュータで何らかの処理を行う際に、その処理を行うために余計に費やされるシステムへかかる負荷や処理時間などのことを言います。
ミドルウェア
コンピュータの基本的な制御を行うオペレーティングシステムと、各業務処理を行うアプリケーションソフトウェアとの中間に入るソフトウェアのことをミドルウェアと言います。Webアプリケーションでは、データベースサーバーやWebサーバー、アプリケーションサーバーの機能を提供するミドルウェアなどが頻繁に使われます。
カーネル
OSのコアとなる部分をカーネルと言います。ハードディスクやメモリーなど、コンピューターリソースの管理や、プログラムの実行プロセスへのリソースの割り当てなどを行います。
パッケージ
特定の機能を提供するために、必要なプログラムをまとめたものをパッケージと言います。Linuxサーバーなどでは、公開されている様々なパッケージをインストールすることで、サーバーとしての機能を追加することができます。またプログラミングでは、他者が公開しているパッケージを再利用することで、全てを自前で作成せずに部分的にパッケージの機能を利用してアプリケーションを作成することができます。
Dockerデーモン
Dockerの常駐型プログラムで、Dockerコンテナの作成やDockerイメージの作成などDockerに対する操作はこのDockerデーモンが受け取り、実際の処理を行います。Docker DesktopやDocker ToolboxといったソフトをインストールすることでDockerデーモンが起動します。Dockerデーモンが起動していないとDockerに対する操作を受け取れないためエラーになります。そのため、もし停止している場合には事前に起動しておく必要があります。
Dockerクライアント
Dockerの利用者がDockerに指示を出すためのクライアントソフトのことを言います。一般的にはdockerコマンドを用いてDockerに指示を出します。
バインドマウント
DockerにおいてホストOS（Dockerデーモンが動作しているOS）上のファイルをコンテナに共有する機能をバインドマウントと言います。ソフトウェアの開発時など、PCでソースコードを変更してDockerコンテナ上で実行したい場合などに、ソースコードのあるフォルダをコンテナにバインドマウントしてプログラムを実行するといった使い方がよくされます。
Kubernetes
コンテナのオーケストレーションツールです。オーケストレーションツールとは、主に複数のコンテナを効率良く管理するための機能が備わったツールのことです。様々なコンテナが多数動作する環境において、使用するイメージ、コンテナへのCPUやメモリの割り当て、コンテナ停止時の復旧処理、パスワードなどの秘匿情報の管理、ストレージの割り当て、コンテナの稼働状況の監視等々様々なことを考慮する必要が出てくるため、管理するのは難しくなります。Kuberntesはこういったコンテナ管理の機能を持ったソフトウェアであり、コンテナを管理するための設定ファイルを書くことで、様々なコンテナ管理の機能を利用することができます
ファイルシステム
コンピューター上でファイルを管理するための機能のことをファイルシステムといいます。
通常ファイルシステムの機能はOSに備わっています。
ストレージドライバ
ハードディスクなどのストレージにデータを書き込むための機能を持ったソフトウェアのこと。ストレージドライバによってデータの書き込み形式や管理方法が異なります。
AUFS
Dockerで使用できるストレージドライバの一種です。
Dockerの説明においてはファイルシステムの一種として解説されているものもあります。
Dockerイメージをどのようにストレージに保持するのかを司るソフトウェアとしてAUFSという選択肢があるという風に理解していただければと思います。
