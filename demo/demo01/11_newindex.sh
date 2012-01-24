#!/bin/bash

# Import some functions
. ../utils/docurl.sh

ESINDEXNAME="shardsreplicas"

# First delete index
curl -XDELETE http://localhost:9200/$ESINDEXNAME?pretty=1

# Then create it
docurlput "Creating index $ESINDEXNAME with mapping" http://localhost:9200/$ESINDEXNAME '{
    "settings" : {
        "number_of_shards" : 3,
        "number_of_replicas" : 1
    },
    "mappings" : {
        "talk" : {
            "_source" : { "enabled" : true },
            "properties" : {
				"date": {
					"type":"date",
					"format":"YYYY-MM-dd"
				},
				"theme": {
					"type":"string",
					"analyzer":"french"
				},
		        "talks" : {
					"properties" : {
						"talk" : {
							"properties" : {
								"sujet" : {
									"type" : "string",
									"analyzer":"french"
								},
								"speakers" : {
									"type" : "string",
									"analyzer":"keyword"
								}
							}
						}
					}
				}
			}
        }
    }
}'

# Index all json documents
for filename in talks/talk*.json
do
   curl -XPOST http://localhost:9200/$ESINDEXNAME/$ESTYPE?pretty=1 -d @$filename
done

