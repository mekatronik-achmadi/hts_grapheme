#!/bin/bash

chmod a+x clean_reset.sh
./clean_reset.sh

chmod a+x configure
./configure \
--with-fest-search-path=/home/elokhts/.hts_sptk/festival/examples \
--with-sptk-search-path=/home/elokhts/.hts_sptk/bin \
--with-hts-search-path=/home/elokhts/.hts_sptk/bin \
--with-hts-engine-search-path=/home/elokhts/.hts_sptk/bin

export NMFILE="$(date +'%d%m%Y_%H%M')"

make all 2>&1 | tee log_prepare_$NMFILE.txt

scriptpath=$(pwd)
perl scripts/Training.pl $scriptpath/scripts/Config.pm 2>&1 | tee log_synthesis_$NMFILE.txt
