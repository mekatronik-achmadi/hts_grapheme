#!/bin/bash

export UNUSED="1384 1481"
export DATASET="vibid_fena"

for i in `echo $UNUSED`;do
	rm -vf data/raw/${DATASET}_${i}.raw
	rm -vf data/txt/${DATASET}_${i}.txt
	rm -vf data/utts/${DATASET}_${i}.utt
done
