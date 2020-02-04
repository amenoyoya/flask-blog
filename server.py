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
