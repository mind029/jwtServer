local content_length = tonumber(ngx.req.get_headers()['content-length'])
local method = ngx.req.get_method()
local ngxmatch = ngx.re.match
if whiteip() then
elseif blockip() then
elseif denycc() then
elseif ngx.var.http_Acunetix_Aspect then
    ngx.exit(444)
elseif ngx.var.http_X_Scan_Memo then
    ngx.exit(444)
elseif whiteurl() then
elseif ua() then
elseif url() then
elseif args() then
elseif cookie() then
elseif PostCheck then
    if method == "POST" then
        local boundary = get_boundary()
        if boundary then
            local len = string.len
            local sock, err = ngx.req.socket()
            if not sock then
                return
            end
            ngx.req.init_body(128 * 1024)
            sock:settimeout(0)
            local content_length = nil
            content_length = tonumber(ngx.req.get_headers()['content-length'])
            local chunk_size = 4096
            if content_length < chunk_size then
                chunk_size = content_length
            end
            local size = 0
            while size < content_length do
                local data, err, partial = sock:receive(chunk_size)
                data = data or partial
                if not data then
                    return
                end
                ngx.req.append_body(data)
                if body(data) then
                    return true
                end
                size = size + len(data)
                local m = ngxmatch(data, [[Content-Disposition: form-data;(.+)filename="(.+)\\.(.*)"]], 'ijo')
                if m then
                    fileExtCheck(m[3])
                    filetranslate = true
                else
                    if ngxmatch(data, "Content-Disposition:", 'isjo') then
                        filetranslate = false
                    end
                    if filetranslate == false then
                        if body(data) then
                            return true
                        end
                    end
                end
                local less = content_length - size
                if less < chunk_size then
                    chunk_size = less
                end
            end
            ngx.req.finish_body()
        else
            ngx.req.read_body()
            local args = ngx.req.get_post_args()
            if not args then
                return
            end
            for key, val in pairs(args) do
                if type(val) == "table" then
                    if type(val[1]) == "boolean" then
                        return
                    end
                    data = table.concat(val, ", ")
                else
                    data = val
                end
                if data and type(data) ~= "boolean" and body(data) then
                    body(key)
                end
            end
        end
    end
else
    return
end




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

