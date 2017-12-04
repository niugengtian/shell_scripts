#!/bin/bash
##############################################################
# File Name: sanlan.sh
# Version: V1.0
# Author: niugengtian
# Organization: 18939703@qq.com
# Created Time : 2017-12-04 22:01:34
# Description:
##############################################################
source /etc/init.d/functions
file=/tmp/sanlan.txt
touch "$file"
echo "~~~~~~~~~~~~ `date +%c` ~~~~~~~~~~~~" >>"$file"
cmd="ping -c 1 -W 1 "
read -p "请输入您要扫描的网段: " LAN
lan=`echo $LAN|awk -F'.' -v OFS='.' '{print $1,$2,$3}'`
for ip in {1..254}
do
        {
        $cmd $lan.$ip >/dev/null
        if [ $? -eq 0 ]
        then
                action "$lan.$ip"      /bin/true
                echo   "$lan.$ip" >>"$file"
        fi
        }&
done
sleep 1
cat "$file"
