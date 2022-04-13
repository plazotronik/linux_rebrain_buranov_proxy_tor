#!/bin/bash

DOMAINS="2ip.ru"

DOMAINS_FOR_IPSET=$DOMAINS
DOMAINS_FOR_BIRD=$DOMAINS

#echo "create to_tor hash:net family inet hashsize 131072 maxelem 1000000000 comment" > /etc/iptables/rules.ipset
echo "create to_tor hash:net family inet hashsize 16777216 maxelem 16777216 comment" > /etc/iptables/rules.ipset

for i in `/usr/bin/dig A $DOMAINS_FOR_IPSET +short`
 do 
  echo "add -exist to_tor $i/32 comment \"DOMAINS_FOR_IPSET\"" >> /etc/iptables/rules.ipset
 done

> /etc/bird/static.conf; 

for i in `dig A $DOMAINS_FOR_BIRD +short`
 do 
  echo $i | /usr/bin/awk '{printf "route "; printf $1"/32 "; print "via 192.168.101.4;"}' >> /etc/bird/static.conf
 done;

/usr/sbin/netfilter-persistent reload
/usr/sbin/birdc config
