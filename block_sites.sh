#!/usr/bin/env bash
# Author: Rhys Campbell
# Created: 2017-04-17
set -u;
set -e;

declare -a domains=('facebook.com' 'instagram.com');

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

#block_domains $domains;
unblock_domains $domains;
