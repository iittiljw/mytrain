#!/bin/bash
# A simple iptables firewall config
export PATH=/sbin:/usr/sbin:/bin:/usr/bin
#flush original rules
sudo sed -i '/^pre-up.*/d' /etc/network/interfaces
sudo sed -i '/^sudo bash home*.*/d' /etc/rc.local
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -F 
sudo iptables -X 
sudo iptables -Z
##ICMP
sudo iptables -A OUTPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
sudo iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
##SSH
sudo iptables -A OUTPUT  -p tcp -m tcp --dport 31667 -j ACCEPT
sudo iptables -A OUTPUT  -p tcp -m tcp --sport 31667 -m state --state ESTABLISHED -j ACCEPT
##DNS
sudo iptables -A OUTPUT -p udp -m udp --dport 53 -j ACCEPT
#WEB
#sudo iptables -A OUTPUT -p tcp -m tcp --sport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A OUTPUT -p tcp -m tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT  
#sudo iptables -A OUTPUT -p tcp -m multiport --dport 80,443  -j ACCEPT
#Teamviewer
sudo iptables -A OUTPUT  -p tcp -m tcp --dport 5938 -j ACCEPT
##OPENVPN
sudo iptables -A OUTPUT  -p tcp -m tcp --dport 17194 -j ACCEPT
sudo iptables -A OUTPUT  -p tcp -m tcp --sport 5900 -j ACCEPT
##URL
sudo iptables -A OUTPUT -p tcp --dport 80 -d api.epoque.cn  -j ACCEPT
sudo iptables -A OUTPUT -p udp --dport 80 -d api.epoque.cn  -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 80 -d boss.epoque.cn -j ACCEPT
sudo iptables -A OUTPUT -p udp --dport 80 -d boss.epoque.cn -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 80 -d qrimg.epoque.cn  -j ACCEPT
sudo iptables -A OUTPUT -p udp --dport 80 -d qrimg.epoque.cn  -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 80 -d upload.epoque.cn -j ACCEPT
sudo iptables -A OUTPUT -p udp --dport 80 -d upload.epoque.cn -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 80 -d epoque-media.oss-cn-shenzhen.aliyuncs.com -j ACCEPT
sudo iptables -A OUTPUT -p udp --dport 80 -d epoque-media.oss-cn-shenzhen.aliyuncs.com -j ACCEPT
##5G
sudo iptables  -A OUTPUT -o  enp3s0  -p udp    -j ACCEPT
sudo iptables  -A OUTPUT -o `cat /etc/network/interfaces|grep -E "auto.*wlx|wlx.*auto"|awk '{print $2}'`  -p udp  -j ACCEPT
##DROP
sudo iptables -P OUTPUT DROP
##SET IPTABLES AUTOUP
sudo touch /etc/iptables.rule
sudo iptables-save >/etc/iptables.rule
sudo sed -i '$a \pre-up iptables-restore < /etc/iptables.rule' /etc/network/interfaces
sudo sed -i '$i \sudo bash home/dlo/set_iptables.sh' /etc/rc.local
