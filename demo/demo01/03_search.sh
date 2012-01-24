#!/bin/bash

ESINDEXNAME="parisjug"
ESTYPE="talk"

# Import some functions
. ../utils/docurl.sh

docurl "Counting talks" -XGET "http://localhost:9200/$ESINDEXNAME/_count?q=*&pretty=1"

docurl "Looking for word 'java'" -XGET "http://localhost:9200/$ESINDEXNAME/_search?q=java&pretty=1"

docurl "Searching talks with speaker arnaud" -XGET "http://localhost:9200/$ESINDEXNAME/_search?q=speakers:arnaud&pretty=1"
 


