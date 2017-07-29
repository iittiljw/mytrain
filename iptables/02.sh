#!/bin/bash
# A simple iptables firewall config
export PATH=/sbin:/usr/sbin:/bin:/usr/bin

#flush original rules
sudo iptables -F 
sudo iptables -X 
sudo iptables -Z 
#sudo iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
sudo iptables -A OUTPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
#sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#ICMP 
#sudo iptables -A INPUT -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT  


#SSH
#sudo iptables -A INPUT -p tcp --dport 31667 -j ACCEPT  
sudo iptables -A OUTPUT -p tcp --sport 31667 -j ACCEPT 

#OPENVPN
#sudo iptables -A INPUT -s 10.8.0.0/24 -j ACCEPT 
#sudo iptables -A OUTPUT -d 10.8.0.0/24 -j ACCEPT

#HTTP/HTTPS
#sudo iptables -A INPUT -p tcp  -m multiport --dport 80,443,53,5938  -j ACCEPT  
sudo iptables -A OUTPUT -p tcp -m multiport --sport 80,443,53,5938 -j ACCEPT

#Email
sudo iptables -A OUTPUT  -p tcp   -m multiport --sport 25,110  -j ACCEPT

#FTP 
#sudo iptables -A INPUT -p tcp  -m multiport --dports 20,21 -j ACCEPT 
#sudo iptables -A OUTPUT -p tcp   -m multiport --sport 20,21  -j ACCEPT

#DHCP
sudo iptables -A INPUT  -p udp   -m multiport --dport 67,68 -j ACCEPT
sudo iptables -A OUTPUT   -p udp   -m multiport --sport 67,68 -j ACCEPT

#URL
sudo iptables -A OUTPUT -p tcp  -m string --string  "api.epoque.cn" --algo bm -j ACCEPT
sudo iptables -A OUTPUT -p udp  -m string --string "api.epoque.cn" --algo kmp -j ACCEPT
sudo iptables -A OUTPUT -p tcp  -m string --string  "epoque-media.oss-cn-shenzhen.aliyuncs.com" --algo bm -j ACCEPT
sudo iptables -A OUTPUT -p udp  -m string --string "epoque-media.oss-cn-shenzhen.aliyuncs.com" --algo kmp -j ACCEPT
sudo iptables -A OUTPUT -p tcp  -m string --string  "boss.epoque.cn" --algo bm -j ACCEPT
sudo iptables -A OUTPUT -p udp  -m string --string "boss.epoque.cn" --algo kmp -j ACCEPT
sudo iptables -A OUTPUT -p tcp  -m string --string  "upload.epoque.cn" --algo bm -j ACCEPT
sudo iptables -A OUTPUT -p udp  -m string --string "upload.epoque.cn" --algo kmp -j ACCEPT

#DROP others
sudo iptables -A OUTPUT --match state --state NEW,INVALID -j LOG
sudo iptables -P OUTPUT DROP

sudo touch /etc/iptables.up.rule
sudo iptables-save >/etc/iptables.up.rule

sudo sed -i '$a \pre-up iptables-restore < /etc/iptables.up.rule' /etc/network/interfaces
