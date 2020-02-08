# Python 3.7 + Debian ベース
FROM python:3.7-slim-buster

# Docker実行ユーザID取得
ARG UID
# Projectディレクトリ
ARG PRJDIR=/var/www/app/

# Julia 1.3 インストール
WORKDIR /usr/src/
RUN apt-get update && apt-get install -y wget && \
    : 'Install Julia' && \
    wget -O - https://julialang-s3.julialang.org/bin/linux/x64/1.3/julia-1.3.1-linux-x86_64.tar.gz | tar xvzf - && \
    ln -s /usr/src/julia-1.3.1/bin/julia /usr/local/bin/julia && \
    : 'www-dataユーザのIDをDocker実行ユーザIDと合わせる' && \
    usermod -u $UID www-data && \
    : 'www-dataユーザをsudoersに追加' && \
    echo 'www-data ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    : 'www-dataユーザのパスワードを`password`に変更' && \
    echo 'www-data:password' | chpasswd  && \
    : '作業ディレクトリのパーミッション変更' && \
    mkdir -p $PRJDIR && \
    chown -R www-data /var/www/

# 作業者: www-dataユーザ
USER www-data

# 作業ディレクトリ: $PRJDIR => host://./app/
WORKDIR $PRJDIR

# Pythonパッケージ記述ファイルをプロジェクトにコピー
COPY requirements.txt $PROJDIR

RUN : 'Install Python packages' && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    : 'Install Julia packages' && \
    julia -e 'using Pkg; Pkg.add("HTTP"); Pkg.add("PyCall"); Pkg.add("Genie");'

# Serve Julia HTTP Server
EXPOSE 8080
CMD ["julia", "server.jl"]
