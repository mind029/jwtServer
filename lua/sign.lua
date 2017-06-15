--
-- Created by IntelliJ IDEA.
-- User: mind
-- Date: 2017/6/15
-- Time: 10:41
-- To change this template use File | Settings | File Templates.
--


local cjson = require "cjson"
local jwt = require "resty.jwt"

local now = ngx.now()
local exp = now + 120

local jwt_token = jwt:sign("lua-resty-jwt",
    {
        header = { typ = "JWT", alg = "HS256" },
        payload = { foo = "bar", id = 1, name = "mind029", exp = exp }
    })


ngx.say(cjson.encode({ toten = jwt_token }))

