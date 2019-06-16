# Simple blog system by Flask

## What's this?

Python + Flask によるシンプルなブログシステム

***

## Environment

- OS: CentOS `7.6`
- Python: `3.6.8`
    - Flask(WebFramework): `1.0.3`
        ```bash
        $ pip install flask
        ```
    - uWSGI(ServerProtocol): `2.0.18`
        ```bash
        $ pip install uwsgi

        # in Anaconda environment
        $ conda install -c conda-forge uwsgi
        ```
- Nginx(WebServer): `1.16.0`

***

## Nginx + uWSGI でWebサーバー公開

```bash
# 作業ディレクトリに移動
$ cd /path/to/mysite

# このgitリポジトリをクローン
$ git init
$ git remote add origin https://github.com/amenoyoya/flask-blog.git
$ git pull origin master

# バックグラウンドでuwsgi実行
$ uwsgi --ini uwsgi.ini &
## => 127.0.0.1:5000 でサーバー実行される
## => 別のポートで実行する場合は uwsgi.ini を編集する

# nginx の設定を追加する
$ sudo cp nginx.conf /etc/nginx/conf.d/mysite.conf

# 必要に応じてドメイン名の編集をする
$ sudo vim /etc/nginx/conf.d/mysite.conf
~~~
server {
    server_name  mysite.example.com; # <= ドメイン名を設定する

    proxy_set_header  Host  $host;
    proxy_set_header  X-Real-IP  $remote_addr;
    proxy_set_header  X-Forwarded-Host    $host;
    proxy_set_header  X-Forwarded-Server  $host;
    proxy_set_header  X-Forwarded-For  $proxy_add_x_forwarded_for;

    location / {
        proxy_pass    http://127.0.0.1:5000; # <= 転送先ポート（uwsgi実行ポート）を指定
    }
}
~~~

# nginx 再起動
$ sudo systemctl restart nginx.service
```
