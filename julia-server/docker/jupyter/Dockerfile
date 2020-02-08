FROM debian:stretch-slim

# Docker実行ユーザID取得
ARG UID
# Projectディレクトリ
ARG PRJDIR=/var/www/note/

# julia, conda, python コマンド実行可能にする bash スクリプトを準備
COPY jash /bin/

# JupyterNotebook 実行スクリプトを /tmp/ にコピー
COPY jupyter-notebook.sh /tmp/
# JupyterNotebook 設定ファイルを ~/.jupyter/ にコピー
COPY jupyter_notebook_config.py /var/www/.jupyter/

RUN : '必要なパッケージのインストール' && \
    apt-get update && apt-get install -y vim curl wget && \
    : '/bin/jash に実行権限付与' && \
    chmod +x /bin/jash && \
    : 'www-dataユーザのIDをDocker実行ユーザIDと合わせる' && \
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

# 作業ディレクトリ: $PRJDIR => host://./note/
WORKDIR $PRJDIR

# JupyterNotebook用ポート
EXPOSE 8888

# 起動時 JupyterNotebook インストール＆実行
## juliaコンテナの /var/www/.julia/ とディレクトリが共有されてから行う
CMD ["bash", "/tmp/jupyter-notebook.sh"]
