#!/bin/bash

export SRC_DIR=~/Achmadi_HTS/build_utts/festival/utts
export DES_DIR=data/utts
export DATA_SET=vibid_fena
export DATA_EXT=utt

for i in {1052..1500};do
	cp -vf $SRC_DIR/${DATA_SET}_${i}.$DATA_EXT $DES_DIR/
done
