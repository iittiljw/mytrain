#!/bin/bash
##touch sources.list
echo "/etc/apt/sources.list"
cd /etc/apt/
sudo mv sources.list sources.list.back
sudo touch sources.list
##update sources.list
echo "# deb cdrom:[Ubuntu 16.04 LTS _Xenial Xerus_ - Release amd64 (20160420.1)]/ xenial main restricted" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse"                   >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse"          >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse"           >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse"          >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse"         >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse"               >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse"      >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse"       >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse"      >> /etc/apt/sources.list
echo "deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse"     >> /etc/apt/sources.list
##install 
cd /home/dlo
sudo apt-get update
sudo apt-get install -y vim && echo true||echo false
sudo apt-get install  -y openssh-server && echo true||echo false
sudo sed -i 's/Port 22/Port 31667/' /etc/ssh/sshd_config && echo true||echo false
sudo sed -i '$i \/usr/sbin/sshd' /etc/rc.local && echo true||echo false
sudo service sshd  restart
##open vpn
sudo sed -i '$i \sudo openvpn --config /etc/openvpn/client.ovpn --daemon &> /dev/null ' /etc/rc.local
sudo openvpn --config /etc/openvpn/client.ovpn --daemon &> /dev/null
##alter sudoers
sudo sed -i '$a \%dlo ALL=(ALL) NOPASSWD: /home/dlo,/sbin/iptables ,/sbin/iptables-save,/sbin/iptables-restore,/bin/bash ,/usr/bin/vim'  /etc/sudoers
##check
ps -ef|grep sshd && echo true||echo false
echo `cat /etc/rc.local|grep "openvpn"` && echo true||echo false
echo `ss -ltn |grep ":31667"` && echo true||echo false
##chmod
sudo chmod +x set_iptables.sh
sudo chmod +x ping_monitor.sh
##passwd dlo
echo dlo:L83%_h4cg|chpasswd && echo true||echo false
echo "SUCCES"
su dlo
rm -rf alter_install.sh
