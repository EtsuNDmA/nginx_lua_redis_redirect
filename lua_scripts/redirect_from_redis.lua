-- Get redirect urls from redis
-- see:
--    https://agileweboperations.com/2014/10/13/supporting-millions-of-pretty-url-rewrites-in-nginx-with-lua-and-redis/
--    https://github.com/openresty/lua-nginx-module
--    https://github.com/openresty/lua-resty-redis

local redis = require "resty.redis"
local red = redis:new()

-- setup redis connection
local ok, err = red:connect("redis", 6379)
if not ok then
    ngx.log(ngx.ERR, "failed to connect to redis: ", err)
    return ngx.exit(500)
end

-- get redirect for current uri
local redirect_to, err = red:hget('redirects', ngx.var.uri)

if redirect_to == ngx.null then
    return ngx.exit(404)
else
    if ngx.var.args then
        redirect_to = redirect_to .. "?" .. ngx.var.args
    end
    ngx.log(ngx.ERR, string.format("REDIRECT  \"%s\" to  \"%s\"", ngx.var.uri, redirect_to))
    ngx.redirect(redirect_to);
end