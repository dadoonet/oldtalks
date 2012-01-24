#!/bin/bash

# define some globals
ESCLUSTERNAME="parisjug"
ESINDEXNAME="parisjug"
ESTYPE="talk"

function pause() {
	read -p "$*" keypressed
}

function docurl() {
	echo "#################################################"
	echo "$1"
	shift 1
	echo curl $*
	curl $*
	echo 
	pause "Press any key to continue..."
}

function docurlpost() {
	echo "#################################################"
	echo "$1"
	shift 1
	curlurl=$1
	shift 1
	curldata=$*
	
	echo $* | grep '?' >/dev/null; if [ $? == 1 ]; then curlurl=$curlurl"&pretty=true"; else curlurl=$curlurl"?pretty=true"; fi 
	
	echo curl -XPOST "$curlurl" -d "'$curldata'"
	curl -XPOST "$curlurl" -d "$curldata"
	echo 
	pause "Press any key to continue..."
}

function docurlput() {
	echo "#################################################"
	echo "$1"
	shift 1
	curlurl=$1
	shift 1
	curldata=$*
	echo curl -XPUT "$curlurl?pretty=true" -d "$curldata"
	curl -XPUT "$curlurl?pretty=true" -d "$curldata"
	echo 
	pause "Press any key to continue..."
}

