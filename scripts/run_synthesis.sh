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
--with-fest-search-path=/home/elokhts/.hts_sptk/festival/examples \
--with-sptk-search-path=/home/elokhts/.hts_sptk/bin \
--with-hts-search-path=/home/elokhts/.hts_sptk/bin \
--with-hts-engine-search-path=/home/elokhts/.hts_sptk/bin \
DATASET=vibid SPEAKER=fena

export NMFILE="$(date +'%d%m%Y_%H%M')"

make all 2>&1 | tee log_prepare_$NMFILE.txt

scriptpath=$(pwd)
perl scripts/Training.pl $scriptpath/scripts/Config.pm 2>&1 | tee log_synthesis_$NMFILE.txt
