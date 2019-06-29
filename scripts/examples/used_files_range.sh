#!/bin/bash

mkdir -p used_fyat/{txt,utts,raw}
FNAME=vibid_fyat
SRCDIR=data_fyat
for i in {402..600};do
    cp -vf $SRCDIR/raw/${FNAME}_${i}.raw used_fyat/raw/
    cp -vf $SRCDIR/txt/${FNAME}_${i}.txt used_fyat/txt/
    cp -vf $SRCDIR/utts/${FNAME}_${i}.utt used_fyat/utts/
done
