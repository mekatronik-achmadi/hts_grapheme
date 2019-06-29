#!/bin/bash

export TOOLS_DIR=~/.hts_sptk
export PATH=$TOOLS_DIR/bin:$PATH
export PATH=$TOOLS_DIR/festival/bin:$PATH
export PATH=$TOOLS_DIR/speech_tools/bin:$PATH
export FESTVOXDIR=$TOOLS_DIR/festvox
export FESTDIR=$TOOLS_DIR/festival
export ESTDIR=$TOOLS_DIR/speech_tools
export PATH=$FESTDIR/examples:$PATH

cd $TOOLS_DIR/samples/HTKDemo/
mkdir -p {accs,proto,test,hmms/{hmm.0,hmm.1,hmm.2,hmm.3,tmp}}

sed -i "255s@for@#for@" MakeProtoHMMSet
sed -i "256s@printf@#printf@" MakeProtoHMMSet
sed -i "257s@}@#}@" MakeProtoHMMSet
sed -i "258s@printf@#printf@" MakeProtoHMMSet

./runDemo configs/monPlainM1S1.dcf
