#!/bin/sh
# check nginx server status
 
# 个别服务器上，再次运行脚本时会kill掉上次未退出的脚本，为防止被kill掉，最好trap一下SIGTERM。
trap -- '' SIGTERM
 
NGINX=/usr/sbin/nginx
PORT=80
  
nmap localhost -p $PORT | grep "$PORT/tcp open"
#echo $?
if [ $? -ne 0 ];then
  $NGINX -s stop
  $NGINX
  sleep 3
  nmap localhost -p $PORT | grep "$PORT/tcp open"
  [ $? -ne 0 ] && killall keepalived
fi