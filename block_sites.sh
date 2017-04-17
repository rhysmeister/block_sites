#!/usr/bin/env bash
# Author: Rhys Campbell
# Created: 2017-04-17
set -u;
set -e;

action=$1; 
declare -a domains=('facebook.com' 'linkedin.com');

function block_domains()
{
	domains=$1;
	for domain in "${domains[@]}"; do
		$(grep "$domain" /etc/hosts) || echo "127.0.0.1	$domain" >> /etc/hosts;
	done;
}

function unblock_domains()
{
	domains=$1;
	for domain in "${domains[@]}"; do
		sed -i.bak "/$domain/d" /etc/hosts
	done;	
}

if [ $action == "block" ]; then
	block_domains $domains;
elif [ $action == "unblock" ]; then
	unblock_domains $domains;
else
	echo "Unknown action: Must be block or unblock.";
fi;
