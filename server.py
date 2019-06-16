# encoding: utf-8
from libs.frasco import Frasco, Response

app = Frasco(__name__)

# index: /
@app.get('/')
def index():
    return Response.html('html/index.html')

if __name__ == "__main__":
    app.run()
