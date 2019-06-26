#!/bin/bash

export TOOLS_DIR=~/.hts_sptk
export PATH=$TOOLS_DIR/bin:$PATH
export PATH=$TOOLS_DIR/festival/bin:$PATH
export PATH=$TOOLS_DIR/speech_tools/bin:$PATH
export FESTVOXDIR=$TOOLS_DIR/festvox
export FESTDIR=$TOOLS_DIR/festival
export ESTDIR=$TOOLS_DIR/speech_tools
export PATH=$FESTDIR/examples:$PATH

chmod a+x clean_reset.sh
./clean_reset.sh

chmod a+x configure
./configure \
--with-fest-search-path=$TOOLS_DIR/festival/examples \
--with-sptk-search-path=$TOOLS_DIR/bin \
--with-hts-search-path=$TOOLS_DIR/bin \
--with-hts-engine-search-path=$TOOLS_DIR/bin \
SAMPFREQ=16000 FRAMELEN=400 FRAMESHIFT=80 WINDOWTYPE=1 \
NORMALIZE=1 FFTLEN=1024 FREQWARP=0.42 GAMMA=1 \
MGCORDER=24 LNGAIN=1 LOWERF0=75 UPPERF0=600 \
DATASET=vibid SPEAKER=fena

export NMFILE="$(date +'%d%m%Y_%H%M')"

sed -i "45s#all: data voice#all: data#" Makefile
make all 2>&1 | tee log_prepare_$NMFILE.txt

scriptpath=$(pwd)
perl scripts/Training.pl $scriptpath/scripts/Config.pm 2>&1 | tee log_synthesis_$NMFILE.txt
