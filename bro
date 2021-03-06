#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );
mode=none
exchange=default
exchange=""
routing_key="";
cert=""
key=""
while getopts :m:e:r:c:k:j opt; do
  case $opt in
    m)
      mode=$OPTARG
      ;;
    e)
      exchange=$OPTARG
     ;;
    #although we are using fanout we might
    #want to use it in the future for other modes
    r)
      routing_key=$OPTARG
     ;;
    c)
      cert="--ssl --sslcert=$OPTARG"
     ;;
    k)
      key="--sslkey=$OPTARG"
     ;;
    \?)
      echo "Invalid flag: -$OPTARG" >&2
      exit 1;
      ;;
  esac
done
if [ $mode == "publisher" ];
then
	"$DIR"/websocketdBro/"$mode".py $exchange $rooting_key
fi
if [[ $mode == "consumer" ]];
then
	 websocketd --port=7777 $cert $key "$DIR"/websocketdBro/"$mode".py $exchange $rooting_key
fi
