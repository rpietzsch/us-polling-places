#!/bin/bash

## delete graph at the beginning
cmemc -c cmem-sa.eccenca.dev graph delete urn:rp-polling-places

for y in "2012" "2014" "2016" "2018"
do
  for i in $(find . -name "*$y.csv") 
  do
    cmemc -c cmem-sa.eccenca.dev dataset delete rpietzsch:Polling-Places
    cmemc -c cmem-sa.eccenca.dev dataset create --project rpietzsch --type csv --replace --id Polling-Places $i
    cmemc -c cmem-sa.eccenca.dev workflow execute rpietzsch:wf-polling-places-$y --wait
  done
done

