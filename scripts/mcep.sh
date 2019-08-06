#!/bin/bash

export TOOLS_DIR=~/.hts_sptk
export PATH=$TOOLS_DIR/bin:$PATH
export PATH=$TOOLS_DIR/festival/bin:$PATH
export PATH=$TOOLS_DIR/speech_tools/bin:$PATH
export FESTVOXDIR=$TOOLS_DIR/festvox
export FESTDIR=$TOOLS_DIR/festival
export ESTDIR=$TOOLS_DIR/speech_tools
export PATH=$FESTDIR/examples:$PATH

export WAVDIR=${1}

echo "resample to 16kHz"
for f in `ls -1 $WAVDIR/*.wav`;do
    sox -t wav $f -r 16000 -c 1 ${f%.wav}re.wav
done

echo "convert wav to raw"
for f in `ls -1 $WAVDIR/*re.wav`;do
    wav2raw +s $f
done

echo "convert raw to short"
for f in `ls -1 $WAVDIR/*.raw`;do 
    x2x +s $f > ${f%re.raw}.short
done

echo "convert short to float"
for f in `ls -1 $WAVDIR/*.short`;do
    x2x +sf < $f > ${f%.short}.float
done

echo "convert short to pitch"
for f in `ls -1 $WAVDIR/*.short`;do
    x2x +sf $f | pitch > ${f%.short}.pitch
done

echo "convert short to mcep"
for f in `ls -1 $WAVDIR/*.short`;do 
    x2x +sf < $f | \
    frame -l 400 -p 80 | \
    window -l 400 -L 512 | \
    mcep -l 512 -m 20 -a 0.42 -e 0.001 \
    > ${f%.short}.mcep
done

echo "plot waveform from short"
for f in `ls -1 $WAVDIR/*.short`;do
    gwave +s -i 1 $f | psgr > ${f%.short}.eps
done

echo "plot pitch"
for f in `ls -1 $WAVDIR/*.pitch`;do
    fdrw < $f | psgr > ${f%.pitch}pitch.eps
done

echo "plot mcep"
for f in `ls -1 $WAVDIR/*.short`;do 
    ( x2x +sf < $f | \
    frame -l 400 -p 80 | \
    bcut +f -l 400 -s 65 -e 65 | \
    window -l 400 -L 512 | \
    spec -l 512 | \
    glogsp -l 512 -x 8 -p 2;\
    \
    bcut +f -n 20 -s 65 -e 65 < ${f%.short}.mcep | \
    mgc2sp -l 512 -m 20 -a 0.42 -g 0 | \
    glogsp -l 512 -x 8 ) | \
    psgr > ${f%.short}ceps.eps
done
