#!/bin/bash

mkdir -p utts/
FNAME=vibid_fyat
for futts in `cat list_used.txt`;do
    cp -vf utts_all/${FNAME}_${futts}.utt utts/
done
