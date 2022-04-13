#!/bin/bash

DOMAINS="2ip.ru"

DOMAINS_FOR_IPSET=$DOMAINS

echo "create to_tor hash:net family inet hashsize 16777216 maxelem 16777216 comment" > /etc/iptables/rules.ipset

for i in `/usr/bin/dig A $DOMAINS_FOR_IPSET +short`
 do 
  echo "add -exist to_tor $i/32 comment \"DOMAINS_FOR_IPSET\"" >> /etc/iptables/rules.ipset
 done

/usr/sbin/netfilter-persistent reload
