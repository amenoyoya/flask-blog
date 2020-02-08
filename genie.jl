"""
Genie Web Framework を使ったサーバ
"""

using Genie
import Genie.Router: route
import Genie.Renderer.Json: json

# route: / => {message: "Hello, Genie!"}
route("/") do
    (:message => "Hello, Genie!") |> json
end

# Genie設定: http://localhost:8080
Genie.config.run_as_server = true
Genie.config.server_port = 8080
Genie.config.server_host = "0.0.0.0"
# Nginxのように静的ファイルを配信: ./*
Genie.config.server_handle_static_files = true
Genie.config.server_document_root = "./"

# Genie起動
Genie.startup()
