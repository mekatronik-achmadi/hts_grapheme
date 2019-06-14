#!/bin/bash

export DATASET=vibid
export SPEAKER=mdpa

export DATANAME=${DATASET}_${SPEAKER}
touch $DATANAME.txt

cd $SPEAKER/
for i in `ls *.txt`;do
    cat $i >> ../$DATANAME.txt
done
