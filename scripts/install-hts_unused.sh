#!/bin/sh

sudo apt-get install gawk
sudo apt-get install sox
sudo apt-get install libx11-dev
sudo apt-get install gcc-multilib
# sudo apt-get install ia32-libs #perlukah?
sudo apt-get install libncurses5-dev

mkdir HTS-2.3
cd HTS-2.3

tar zxvf ../SPTK-3.10.tar.gz
tar zxvf ../HTK-3.4.1.tar.gz
tar zxvf ../HDecode-3.4.1.tar.gz
tar zxvf ../HTK-samples-3.4.1.tar.gz
tar jxvf ../HTS-2.3_for_HTK-3.4.1.tar.bz2
tar zxvf ../hts_engine_API-1.10.tar.gz
tar zxvf ../speech_tools-2.4-release.tar.gz
tar zxvf ../festival-2.4-release.tar.gz
tar zxvf ../festlex_CMU.tar.gz
tar zxvf ../festlex_POSLEX.tar.gz
tar zxvf ../festlex_OALD.tar.gz
tar zxvf ../festvox_kallpc16k.tar.gz
tar zxvf ../festvox_rablpc16k.tar.gz
tar zxvf ../festvox_kedlpc16k.tar.gz
tar zxvf ../festvox_cmu_us_ahw_cg.tar.gz
tar zxvf ../festvox_cmu_us_aup_cg.tar.gz
tar zxvf ../festvox_cmu_us_awb_arctic_hts.tar.gz
tar zxvf ../festvox_cmu_us_awb_cg.tar.gz
tar zxvf ../festvox_cmu_us_axb_cg.tar.gz
tar zxvf ../festvox_cmu_us_bdl_cg.tar.gz
tar zxvf ../festvox_cmu_us_clb_cg.tar.gz
tar zxvf ../festvox_cmu_us_fem_cg.tar.gz
tar zxvf ../festvox_cmu_us_gka_cg.tar.gz
tar zxvf ../festvox_cmu_us_jmk_cg.tar.gz
tar zxvf ../festvox_cmu_us_ksp_cg.tar.gz
tar zxvf ../festvox_cmu_us_rms_cg.tar.gz
tar zxvf ../festvox_cmu_us_rxr_cg.tar.gz
tar zxvf ../festvox_cmu_us_slt_cg.tar.gz
tar zxvf ../festvox-2.7.0-release.tar.gz
tar jxvf ../flite-2.0.0-release.tar.bz2

cd SPTK-3.10
./configure --prefix=/opt/hts_sptk
make
sudo make install
#untuk ngechek kalau sudah terinstall
#impulse -h
cd ..

#move HTS-2.3_for_HTK-3.4.1.patch ke folder htk
cd htk
patch -p1 -d . < HTS-2.3_for_HTK-3.4.1.patch
export CC=gcc-4.7 CXX=g++-4.7 
./configure CFLAGS="-DARCH=linux"
make all
sudo make install
make hdecode
sudo make install-hdecode

cd samples
cd HTKDemo
mkdir accs
mkdir hmms
cd hmms
mkdir hmm.0
mkdir hmm.1
mkdir hmm.2
mkdir hmm.3
mkdir tmp
cd ..
mkdir proto
mkdir test
#change MakeProtoHMMSet with this script
#----------------------------------------------
# WriteStates: Write the contents of the states
#----------------------------------------------
sub WriteStates {
    local($i,$j)=0;

    for ($i=1; $i<=$nStates; $i++){
    printf(PROTO "  <State> %d\n",$i+1);
#        for ($k=1; $k<=$nStreams; $k++){z
#        printf(PROTO "%d ",$mixes[$k]);
#    }
#    printf(PROTO "\n");
    for ($j=1; $j<=$nStreams; $j++){
        printf(PROTO "  <Stream> %d\n",$j);
        printf(PROTO "  <NumMixes> %d\n",$mixes[$j]);
        if ($hsKind =~ /^[Dd]/){
        &WriteDProbs($j);
        }elsif ($hsKind =~ /^[pP]/){
        if ($cKind =~ /^[dD]/){
            &WriteDiagCMixtures($j);
        }else{
            &WriteFullCMixtures($j);
        }
        }elsif ($hsKind =~ /^[Tt]/){
        &WriteTiedWghts($j);
        }
    }
    }
}

#Then run the demo
./runDemo configs/monPlainM1S1.dcf
cd ..

cd hts_engine_API-1.10
./configure
make
make install
cd ..

cd speech_tools
./configure
make
make test
cd ..

cd festival
./configure
make
make test
cd ..

cd festvox
./configure
make
  cd docbook
    make doc

cd flite-2.0.0-release
./configure
make
cd ..
