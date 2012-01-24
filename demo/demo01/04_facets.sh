#!/bin/bash

# Import some functions
. ../utils/docurl.sh

docurlpost "Term facet on theme field" http://localhost:9200/$ESINDEXNAME/_search '{
	"query" : { "query_string" : {"query" : "*"} },
	"facets" : {
		"themes" : { "terms" : {"field" : "theme"} }
	}
}'



docurlpost "Term facet on theme speakers" http://localhost:9200/$ESINDEXNAME/_search '{
	"query" : { "query_string" : {"query" : "*"} },
	"facets" : {
		"speakers" : { "terms" : {"field" : "speakers"} }
	}
}'

docurlpost "Term facet on theme speakers and date histogram" http://localhost:9200/$ESINDEXNAME/_search '{
	"query" : { "query_string" : {"query" : "*"} },
	"facets" : {
		"speakers" : { "terms" : {"field" : "speakers"} },
		"years" : { "date_histogram" : { "field" : "date", "interval" : "year"} }
	}
}'

docurlpost "Term facet on theme speakers and date histogram with search criteria java maven" http://localhost:9200/$ESINDEXNAME/_search '{
	"query" : { "query_string" : {"query" : "java maven"} },
	"facets" : {
		"speakers" : { "terms" : {"field" : "speakers"} },
		"years" : { "date_histogram" : { "field" : "date", "interval" : "year"} }
	}
}'




