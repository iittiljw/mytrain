#!/bin/bash
# A simple iptables firewall config
export PATH=/sbin:/usr/sbin:/bin:/usr/bin
#flush original rules
sudo iptables -F 
sudo iptables -X 
sudo iptables -Z 
sudo iptables -A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
sudo iptables -A OUTPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT
sudo iptables -A INPUT ,RELATED -j ACCEPT
#ICMP 
sudo iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED, RELATED -j ACCEPT  
#SSH 
sudo iptables -A OUTPUT tcp  --dport 31667  -j ACCEPT
#OPENVPN
sudo iptables -A OUTPUT tcp  --dport 17194  -j ACCEPT
sudo iptables -A OUTPUT tcp  --dport 5900  -j ACCEPT
#HTTP  
sudo iptables -A OUTPUT tcp  --dport 80  -j ACCEPT
#HTTPS 
sudo iptables -A OUTPUT tcp  --dport 443  -j ACCEPT
#Email
sudo iptables -A OUTPUT  tcp   --dport 25  -j ACCEPT
#FTP 
sudo iptables -A OUTPUT  tcp   --dport 20:21 -j ACCEPT
#DHCP
sudo iptables -A OUTPUT   udp   --sport 67 -j ACCEPT
sudo iptables -A OUTPUT   udp   --dport 68 -j ACCEPT
#TV
sudo iptables -A OUTPUT  tcp   --dport 5939 -j ACCEPT
sudo iptables -A OUTPUT  udp   --dport 5939 -j ACCEPT
sudo iptables -A OUTPUT  tcp   --dport 5938 -j ACCEPT
sudo iptables -A OUTPUT  udp   --dport 5938 -j ACCEPT
#URL
sudo iptables -A OUTPUT tcp  -m string --string  "api.epoque.cn" --algo bm -j ACCEPT
sudo iptables -A OUTPUT udp  -m string --string "api.epoque.cn" --algo kmp -j ACCEPT
sudo iptables -A OUTPUT tcp  -m string --string  "epoque-media.oss-cn-shenzhen.aliyuncs.com" --algo bm -j ACCEPT
sudo iptables -A OUTPUT udp  -m string --string "epoque-media.oss-cn-shenzhen.aliyuncs.com" --algo kmp -j ACCEPT
sudo iptables -A OUTPUT tcp  -m string --string  "boss.epoque.cn" --algo bm -j ACCEPT
sudo iptables -A OUTPUT udp  -m string --string "boss.epoque.cn" --algo kmp -j ACCEPT
sudo iptables -A OUTPUT tcp  -m string --string  "upload.epoque.cn" --algo bm -j ACCEPT
sudo iptables -A OUTPUT udp  -m string --string "upload.epoque.cn" --algo kmp -j ACCEPT

#DROP others
sudo iptables -A OUTPUT --match state --state NEW,INVALID -j LOG
sudo iptables -P OUTPUT DROP

sudo touch /etc/iptables.up.rule
sudo iptables-save >/etc/iptables.up.rule

sudo sed -i '$a \pre-up iptables-restore < /etc/iptables.up.rule' /etc/network/interfaces