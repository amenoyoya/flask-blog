"""
HTTP パッケージを使った最小限の http サーバ
"""

using HTTP

println("Serving on http://127.0.0.1:8081")

HTTP.listen("127.0.0.1", UInt16(8081)) do http::HTTP.Stream
    # debug
    @show http.message
    @show HTTP.header(http, "Content-Type")
    while !eof(http)
        println("body data: ", String(readavailable(http)))
    end

    # / => 200 OK: "Hello, world"
    if http.message.target === "/"
        HTTP.setstatus(http, 200)
        HTTP.setheader(http, "Content-Type" => "text/html; charset=utf-8")
        startwrite(http)
        write(http, "Hello, world")
        return
    end
    
    # 静的ファイル配信
    filename = HTTP.unescapeuri(http.message.target[2:end]) # ファイル名は先頭の'/'を抜いた部分
    if isfile(filename)
        HTTP.setstatus(http, 200)
        HTTP.setheader(http, "Content-Type" => "text/plain")
        startwrite(http)
        write(http, read(filename))
        return
    end
    HTTP.setstatus(http, 404)
end
