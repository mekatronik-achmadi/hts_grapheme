#!/bin/bash

# buat skrip configure menjadi executable
chmod a+x configure

# tes environment dan generate Makefile
./configure \
--with-fest-search-path=/home/elokhts/.hts_sptk/festival/examples \
--with-sptk-search-path=/home/elokhts/.hts_sptk/bin \
--with-hts-search-path=/home/elokhts/.hts_sptk/bin \
--with-hts-engine-search-path=/home/elokhts/.hts_sptk/bin

# tanggal dan jam/menit untuk nama log file
export NMFILE="$(date +'%d%m%Y_%H%M')"

# jalankan Makefile
make all 2>&1 | tee log_prepare_$NMFILE.txt

# buat alamat absolut untuk Perl script
scriptpath=$(pwd)
perl scripts/Training.pl $scriptpath/scripts/Config.pm 2>&1 | tee log_synthesis_$NMFILE.txt
