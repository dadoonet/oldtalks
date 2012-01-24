#!/bin/bash

# Import some functions
. ../utils/docurl.sh

ESNODENAME="node1"
ESCLUSTERNAME="twitterdemo"

rm -r $ESNODENAME
../utils/startNode.sh -n $ESNODENAME -c $ESCLUSTERNAME -Des.path.conf=./config


