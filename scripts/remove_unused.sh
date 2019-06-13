#!/bin/bash

export UNUSED="0465 1051 1095 1127 1165 1168 1249 1272 1285 1293 1313 1384 1481"
export DATASET="vibid_fena"

for i in `echo $UNUSED`;do
	rm -vf data/raw/${DATASET}_${i}.raw
	rm -vf data/txt/${DATASET}_${i}.txt
	rm -vf data/utts/${DATASET}_${i}.utt
done
