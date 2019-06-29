#!/bin/bash

export PYTHONPATH=.
cat test_data/corpus.lst | xargs bin/get_mcd_plain_new test_data/ref-examples test_data/aligned-synth-examples
