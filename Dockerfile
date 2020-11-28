FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential imagemagick nodejs

# プロジェクトのディレクトリをコンテナに作成、作成したディレクトリを作業ディレクトリに指定
RUN mkdir /search_laundry
WORKDIR /search_laundry

# Gemfileを作業ディレクトリにコピー
COPY Gemfile /search_laundry/Gemfile
COPY Gemfile.lock /search_laundry/Gemfile.lock

# gemのインストール
RUN gem install bundler && bundle install
COPY . /search_laundry