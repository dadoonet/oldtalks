#!/bin/bash

ESINDEXNAME="parisjug"
ESTYPE="talk"

# First delete index
curl -XDELETE http://localhost:9200/$ESINDEXNAME?pretty=1

# Then create it
curl -XPUT http://localhost:9200/$ESINDEXNAME?pretty=1

# Index all json documents
for filename in talks/talk*.json
do
   curl -XPOST http://localhost:9200/$ESINDEXNAME/$ESTYPE?pretty=1 -d @$filename
done

