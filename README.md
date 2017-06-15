# JSON WEB TOKEN 使用

Openresty平台整合JSON WEB TOKEN 实例。一般情况下可以在  `access_by_lua_file` 阶段使用 jwt做权限管理。

Vue.js 项目也可以使用 ` access_by_lua_file` 做权限管理。从而解决登录过期跳转到登录页的问题。


参考链接：JSON WEB TOKEN ：https://github.com/SkyLothar/lua-resty-jwt

