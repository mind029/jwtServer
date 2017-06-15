--
-- Created by IntelliJ IDEA.
-- User: mind
-- Date: 2017/6/15
-- Time: 9:52
-- To change this template use File | Settings | File Templates.
--

local cjson = require('cjson')

local obj = {
    name = "mind",
    age = 26,
    hobby = {
        {id = 1,game = "gamae1"},
        {id = 2,game = "gamae2"},
        {id = 3,game = "gamae3"}
    }
}

ngx.say(cjson.encode(obj))