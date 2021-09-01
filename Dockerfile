#
# ubuntu イメージ
#
FROM ubuntu:20.04
#
# ライブラリインストール
#
RUN apt update && apt install -y libffi-dev \
    libssl-dev \
    openssl \
    libsqlite3-dev \
    libreadline6-dev \
    libbz2-dev \
    libncursesw5-dev \
    libdb-dev \
    libexpat1-dev \
    zlib1g-dev \
    liblzma-dev \
    libgdbm-dev \
    libmpdec-dev \
    python3-pip \
    libmariadb-dev-compat \
    libmariadb-dev \
    libjpeg-dev \
    iputils-ping \
    net-tools \
    mariadb-server \
    curl \
    wget
#
# ディレクトリ移動
#
WORKDIR /opt/
#
# Python インストール
#
RUN wget https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tar.xz && \
    xz -dc Python-3.9.5.tar.xz| tar xfv - && \
    cd Python-3.9.5 && \
    ./configure && \
    make && \
    make install

WORKDIR /app/
#
# 事前にインストールしておきたいライブラリは requirements.txt に列挙
#
COPY requirements.txt /app/
#
# パスの設定、パッケージインストール
#
RUN ln -s /usr/local/bin/python3 /usr/local/bin/python && \
    ln -s /usr/local/bin/pip3.9 /usr/local/bin/pip && \
    pip install --upgrade pip && \
    pip install -r requirements.txt
#
# コンテナがリッスンするポート
#
EXPOSE 8080
#
# サーバーのユーザー名
#
USER $USER
#
# コンテナ作成時に bash を立ち上げる。
#
CMD ["/bin/bash"]
