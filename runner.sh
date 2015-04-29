#!/bin/bash
if [ "$#" -ne 2 ]; then
  echo "Required Params: the number of nodes and the number of files"
  exit 1
fi

nodes=$1
total=$2
n=0
for ((i=1;i<=nodes;i++)); do
	node="host$i"
	let start=$n*$total/$nodes
	let n=$n+1 
	let end=$n*$total/$nodes;
	ssh root@$node "apt-get install git -y; git clone https://github.com/tonyabra/node-downloader.git; cd ./node-downloader; nohup ./downloader.sh $start $end > foo.out 2> foo.err < /dev/null &"	
done