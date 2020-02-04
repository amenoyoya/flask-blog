# WSGI API Server

Python の標準ライブラリで API サーバ実装

## Environment

- OS:
    - Windows 10
    - Ubuntu 18.04
- Python: `3.6.10` (Anaconda `4.7.12`)

***

## wsgiref 標準ライブラリによる http サーバ

### server.py
```python
# encoding: utf-8
from wsgiref.simple_server import make_server

def app(environ, start_response):
    status = '200 OK'
    headers = [('Content-type', 'text/plain; charset=utf-8')]
    start_response(status, headers)
    return [b"Hello World"]

with make_server('', 8000, app) as httpd:
    print("Serving on http://localhost:8000 ...")
    httpd.serve_forever()
```

以下のコマンドでサーバ実行

```bash
$ python server.py

# => Serving on http://localhost:8000 ...
```
