--
-- Created by IntelliJ IDEA.
-- User: mind
-- Date: 2017/6/16
-- Time: 14:03
-- To change this template use File | Settings | File Templates.
--


local jwt = require "resty.jwt"
local jwt_token = ngx.var.arg_jwt
local cjson = require("cjson")



if jwt_token then
    ngx.header['Set-Cookie'] = "jwt=" .. jwt_token
else
    jwt_token = ngx.var.cookie_jwt
end

--ngx.say(jwt_token)


local jwt_obj = jwt:verify("lua-resty-jwt", jwt_token)

-- 如果没有验证成功可以返回到登录页面去。
if not jwt_obj["verified"] then
    local site = ngx.var.scheme .. "://" .. ngx.var.http_host;
    local args = ngx.req.get_uri_args()
    ngx.status = ngx.HTTP_UNAUTHORIZED
    ngx.say(cjson.encode({ status = false, reason = jwt_obj.reason, site = site ,args = args}));
    ngx.exit(ngx.HTTP_OK)
end
