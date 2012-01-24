#!/bin/bash

ES_VERSION="0.18.7"
ES_NODENAME="elasticsearch"
ES_CLUSTERNAME="elasticsearch"

CDPATH=""
SCRIPT="$0"

# Parse any command line options.
args=`getopt h:v:n:c:D:X: "$@"`
eval set -- "$args"

while true; do
    case $1 in
        -n)
            ES_NODENAME="$2"
            shift 2
        ;;
        -c)
            ES_CLUSTERNAME="$2"
            shift 2
        ;;
        -v)
            ES_VERSION="$2"
            shift 2
        ;;
        -h)
            echo "Usage: $0 [-n nodename] [-c clustername] [-v version] [-h]"
            exit 0
        ;;
        -D)
            properties="$properties -D$2"
            shift 2
        ;;
        -X)
            properties="$properties -X$2"
            shift 2
        ;;
        --)
            shift
            break
        ;;
        *)
            echo "Error parsing arguments!" >&2
            exit 1
        ;;
    esac
done


# SCRIPT may be an arbitrarily deep series of symlinks. Loop until we have the concrete path.
while [ -h "$SCRIPT" ] ; do
  ls=`ls -ld "$SCRIPT"`
  # Drop everything prior to ->
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    SCRIPT="$link"
  else
    SCRIPT=`dirname "$SCRIPT"`/"$link"
  fi
done

# determine elasticsearch home
ES_HOME=`dirname "$SCRIPT"`/../elasticsearch-"$ES_VERSION"

# make ELASTICSEARCH_HOME absolute
ES_HOME=`cd "$ES_HOME"; pwd`
ES_NODEDIR=`pwd`
ES_NODEDIR=$ES_NODEDIR/$ES_NODENAME

if [ ! -e $ES_NODEDIR ]; then
	mkdir $ES_NODEDIR
fi

echo "Launching ElasticSearch $ES_VERSION..."
echo " - node       : $ES_NODENAME"
echo " - cluster    : $ES_CLUSTERNAME"
echo " - options    : $properties"

$ES_HOME/bin/plugin -install elasticsearch/elasticsearch-river-twitter/1.0.0



