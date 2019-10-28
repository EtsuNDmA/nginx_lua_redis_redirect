ngx.status = ngx.HTTP_OK
ngx.header.content_type = "application/json; charset=utf-8"
ngx.say(string.format("Hello World from Lua!\nWelcome to %s\n", ngx.var.uri))

for k, v in pairs(ngx.req.get_uri_args()) do
    ngx.say(string.format("%s: %s", k, v))
end

return ngx.exit(ngx.HTTP_OK)
