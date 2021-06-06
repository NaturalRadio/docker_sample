# [FROM] 使用するイメージとバージョン
FROM ruby:2.7.1
# [RUN] コマンドの実行。railsに必要なnode,npm,yarnをインストールしています
RUN apt-get update -qq && \
    apt-get install -y nodejs \
                       npm && \
    npm install -g yarn
RUN mkdir /docker_sample
# [WORKDIR] 作業ディレクトリを設定
WORKDIR /docker_sample
# [COPY] ローカルのファイルをコンテナへコピー
COPY Gemfile* /docker_sample/Gemfile
COPY Gemfile.lock* /docker_sample/Gemfile.lock
RUN bundle install
COPY . /docker_sample

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
# [ENTRYPOINT] 一番最初に実行するコマンド（ここではentrypoint.shを参照）
ENTRYPOINT ["entrypoint.sh"]
# [EXPOSE] コンテナが参照するport番号
EXPOSE 3000
# [CMD] イメージ内部のソフトウェア実行（ここではRailsを指す）
CMD ["rails", "server", "-b", "0.0.0.0"]

