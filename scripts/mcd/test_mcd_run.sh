#!/bin/bash

export DIRLIST=$(ls -1 data_test/)
export RESFNAME=mcd_test_result.txt

export PYTHONPATH=.
chmod a+x bin/*

echo "MCD Test Result" > $RESFNAME

for i in `echo $DIRLIST`;do
    echo "" >> $RESFNAME
    echo "========================" >> $RESFNAME
    echo "" >> $RESFNAME

    echo "Testing ${i}" >> $RESFNAME
    echo "Testing ${i}"

    cat data_test/${i}/test_data/corpus.lst | \
    xargs bin/get_mcd_plain_new \
    data_test/${i}/test_data/ref-examples \
    data_test/${i}/test_data/aligned-synth-examples | grep -i "overall MCD" >> $RESFNAME
done




