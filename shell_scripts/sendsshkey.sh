#!/bin/bash
##############################################################
# File Name: /server/scripts/sendsshkey.sh
# Version: V1.0
# Author: niugengtian
# Organization: 18939703@qq.com
# Created Time : 2017-12-04 16:49:29
# Description:
##############################################################
#!/bin/bash
source /etc/init.d/functions
rm /root/.ssh/id_rsa* -f
#ssh-keygen -t rsa -f /root/.ssh/id_rsa -N "" &>/dev/null
ssh-keygen -t rsa -f /root/.ssh/id_rsa -N "" -q
for ip in `awk '$0~172.16 {print $1}' /etc/hosts`
do
    sshpass -p111111 ssh-copy-id -i /root/.ssh/id_rsa.pub "$ip" -o StrictHostKeyChecking=no  &>/dev/null
    if [ $? -eq 0  ]
    then
        action  "$ip copy key end." /bin/true
        echo ""
    else
        action  "$ip already copy." /bin/false
    fi
done
