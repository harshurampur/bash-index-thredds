#!/bin/bash


filename='thredds.list'
n=1
link="http://dapds00.nci.org.au/thredds/catalog/if87/"
exclude1=".*ARD-METADATA.yaml" 
exclude2='.*NBAR.*'
exclude3='.*SUPPLEMENTARY.*'
exclude4='.*NBART.*'
exclude='.*/QA/.*'
while read line; do
# reading each line
thredds-to-tar -c $link$line -t $exclude1 --outfile metadata.tar.gz -w 8 -s $exclude2 -s $exclude3 -s $exclude4 -s $exclude &
wait
dc-index-from-tar --protocol "http" metadata.tar.gz
n=$((n+1))
done < $filename
