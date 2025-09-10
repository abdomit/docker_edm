#!/bin/bash

if [ ! -f "$EXTENSIONS_FNAME" ]; then
	echo "File '$EXTENSIONS_FNAME' not found, downloading it from DLS Confluence"
	apt-get install curl -yq --force-yes \
	&& apt-get clean -y
	curl -L -o $EXTENSIONS_FNAME "https://diamondlightsource.atlassian.net/wiki/download/attachments/852014/extensions.tgz"
fi
