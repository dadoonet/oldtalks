#!/bin/bash

# Import some functions
. ../utils/docurl.sh

# Then create it
docurlpost "Analyzer whitespace" http://localhost:9200/$ESINDEXNAME/_analyze?analyzer=whitespace '﻿Une phrase en français concernant le monde Java.'
docurlpost "Analyzer whitespace" http://localhost:9200/$ESINDEXNAME/_analyze?analyzer=standard '﻿Une phrase en français concernant le monde Java.'
docurlpost "Analyzer whitespace" http://localhost:9200/$ESINDEXNAME/_analyze?analyzer=simple '﻿Une phrase en français concernant le monde Java.'
docurlpost "Analyzer whitespace" http://localhost:9200/$ESINDEXNAME/_analyze?analyzer=french '﻿Une phrase en français concernant le monde Java.'

