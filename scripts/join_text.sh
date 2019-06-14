#!/bin/bash

export DATASET=vibid
export SPEAKER=mdpa

export DATANAME=${DATASET}_${SPEAKER}
rm $DATANAME.txt
touch $DATANAME.txt

cd $SPEAKER/
for i in `ls *.txt`;do
    export TEXT=$(cat $i)
    echo $TEXT >> ../$DATANAME.txt
done
