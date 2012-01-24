#!/bin/bash

# Import some functions
. ../utils/docurl.sh

ESINDEXNAME="twitter"

# Create the river index
docurlput "Creating index $ESINDEXNAME with mapping" http://localhost:9299/$ESINDEXNAME '{
    "settings" : {
        "number_of_shards" : 2,
        "number_of_replicas" : 1
    }
}'

# Create the river
docurlput "Creating twitter river for $ESINDEXNAME" http://localhost:9299/_river/$ESINDEXNAME/_meta '{
    "type" : "twitter",
    "twitter" : {
        "oauth" : {
        	"consumerKey" : "YPOyurY0gOwkhqEwKJV7Kg",
        	"consumerSecret" : "AZr3emRWRDYAuGGsyJZyxqb99HSPLPGxeaZUwL4",
	       	"accessToken" : "51172224-jUGrSoPbfDC6mG5gojLNgsgmD0eWQctN3qIWv4r4",
        	"accessTokenSecret" : "zypCsI08TerE0Pg5x1v0emeqdg2y8uf7eJWPb2RM7uU"
		},
		"filter" : {
             "follow" : [51172224,430542250]
        }
    },
    "index" : {
        "index" : "twitter",
        "type" : "status",
        "bulk_size" : 1
    }
}'


