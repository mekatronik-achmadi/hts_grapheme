#!/bin/bash

# sudo apt-get install csh
# sudo apt-get install gawk
# sudo apt-get install sox
# sudo apt-get install libx11-dev
# sudo apt-get install build-essential
# sudo apt-get install libncurses5-dev

export SOURCE_DIR=~/HTS/install
export TARGET_DIR=~/.hts_sptk

mkdir -p $TARGET_DIR

tar zxvf $SOURCE_DIR/SPTK-3.10.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/HTK-3.4.1.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/HDecode-3.4.1.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/HTK-samples-3.4.1.tar.gz -C $TARGET_DIR
tar jxvf $SOURCE_DIR/HTS-2.3_for_HTK-3.4.1.tar.bz2 -C $TARGET_DIR
tar zxvf $SOURCE_DIR/hts_engine_API-1.10.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/speech_tools-2.5.0-release.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festival-2.5.0-release.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festlex_CMU.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festlex_POSLEX.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festlex_OALD.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_kallpc16k.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_rablpc16k.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_kedlpc16k.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_ahw_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_aup_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_awb_arctic_hts.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_awb_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_axb_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_bdl_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_clb_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_fem_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_gka_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_jmk_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_ksp_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_rms_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_rxr_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox_cmu_us_slt_cg.tar.gz -C $TARGET_DIR
tar zxvf $SOURCE_DIR/festvox-2.8.0-release.tar.gz -C $TARGET_DIR
tar jxvf $SOURCE_DIR/flite-2.0.0-release.tar.bz2 -C $TARGET_DIR

cd $TARGET_DIR/SPTK-3.10
./configure --prefix=$TARGET_DIR
make all
make install

cd $TARGET_DIR/htk
patch -p1 < ../HTS-2.3_for_HTK-3.4.1.patch
./configure CFLAGS=-DARCH=linux --prefix=$TARGET_DIR
make all
make install
make hdecode
make install-hdecode

cd $TARGET_DIR/hts_engine_API-1.10
./configure --prefix=$TARGET_DIR
make all
make install

cd $TARGET_DIR/flite-2.0.0-release
./configure --prefix=$TARGET_DIR
make all
make install

cd $TARGET_DIR/speech_tools
./configure --prefix=$TARGET_DIR
make all
make install

cd $TARGET_DIR/festival
./configure --prefix=$TARGET_DIR
make all
make install

cd $TARGET_DIR/festvox
./configure --prefix=$TARGET_DIR
sed -i "s#NUL)#NULL)#g" src/vc/src/sub/gmm_sub.cc
make all

export TOOLS_DIR=~/.hts_sptk
export PATH=$TOOLS_DIR/bin:$PATH
export PATH=$TOOLS_DIR/festival/bin:$PATH
export PATH=$TOOLS_DIR/speech_tools/bin:$PATH
export FESTVOXDIR=$TOOLS_DIR/festvox
export FESTDIR=$TOOLS_DIR/festival
export ESTDIR=$TOOLS_DIR/speech_tools
export PATH=$FESTDIR/examples:$PATH

sed -i "55s#( J#( j#" $FESTVOXDIR/src/grapheme/sampa.table
sed -i "82s#( j#( y#" $FESTVOXDIR/src/grapheme/sampa.table

sed -i "26s#(( A )))#(( a )))#" $FESTVOXDIR/src/grapheme/unicode_sampa_mapping.scm
sed -i "28s#(( ch )))#(( c )))#" $FESTVOXDIR/src/grapheme/unicode_sampa_mapping.scm
sed -i "35s#(( dZ )))#(( j )))#" $FESTVOXDIR/src/grapheme/unicode_sampa_mapping.scm
sed -i "50s#(( j )))#(( y )))#" $FESTVOXDIR/src/grapheme/unicode_sampa_mapping.scm
