FROM julia:latest

# Docker実行ユーザID取得
ARG UID
# Projectディレクトリ
ARG PRJDIR=/var/www/app/

RUN : 'www-dataユーザのIDをDocker実行ユーザIDと合わせる' && \
    usermod -u $UID www-data && \
    : 'www-dataユーザをsudoersに追加' && \
    apt-get update && apt-get install -y sudo && \
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

RUN : 'Install Julia packages' && \
    julia -e 'using Pkg; Pkg.add("HTTP"); Pkg.add("PyCall"); Pkg.add("Genie");' && \
    : 'Activate Julia/PyCall Anaconda3' && \
    . ~/.julia/conda/3/bin/activate && \
    : 'Install Python packages' && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Serve Julia HTTP Server
EXPOSE 8080
CMD ["julia", "server.jl"]
