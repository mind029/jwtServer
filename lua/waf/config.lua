RulePath = "/mnt/hgfs/manager/jwtServer/lua/waf/wafconf/"
attacklog = "on"
logdir = "/mnt/hgfs/manager/jwtServer/logs/hack/"
UrlDeny="on"
Redirect="on"
CookieMatch="on"
postMatch="on" 
whiteModule="on" 
black_fileExt={"php","asp","jsp","aspx"}
ipWhitelist={"127.0.0.1"}
ipBlocklist={"1.0.0.1"}
CCDeny="off"
CCrate="100/60"
html=[[
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>网站防火墙</title>
<style>
p {
	line-height:20px;
}
ul{ list-style-type:none;}
li{ list-style-type:none;}
</style>
</head>

<body style=" padding:0; margin:0; font:14px/1.5 Microsoft Yahei, 宋体,sans-serif; color:#555;">
 bad request
</body></html>
]]
