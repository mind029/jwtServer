--
-- Created by IntelliJ IDEA.
-- User: mind
-- Date: 2017/6/15
-- Time: 10:41
-- 用于 JSON WEB TOKEN 生成 token 返回给前端。



--


local cjson = require "cjson"
local jwt = require "resty.jwt"

-- 这个是私钥，用于加密
local Secret = "lua-resty-jwt"


local now = ngx.now()
-- 生成 token 的有效期
local exp = now + 1200

local jwt_token = jwt:sign(Secret,
    {
        header = { typ = "JWT", alg = "HS256" },
        payload = { foo = "bar", id = 1, name = "mind029", exp = exp }
    })


ngx.say(cjson.encode({ toten = jwt_token }))

