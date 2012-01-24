#!/bin/bash

# Import some functions
. ../utils/docurl.sh

ESNODENAME="node3"

rm -r $ESNODENAME
../utils/startNode.sh -n $ESNODENAME -c $ESCLUSTERNAME


