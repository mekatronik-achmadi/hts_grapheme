#!/usr/bin/python3

import numpy as np

def array_samelen(arr_in,arr_ref):
    i_In2 = int(len(arr_in)/2)
    i_Ref2 = int(len(arr_ref)/2)
    
    arr_out_H = arr_in[i_In2:i_In2+i_Ref2:1]
    
    arr_in_rev = arr_in[::-1]
    arr_out_L_rev = arr_in_rev[i_In2:i_In2+i_Ref2:1]
    arr_out_L = arr_out_L_rev[::-1]
    
    arr_out = np.concatenate((arr_out_L, arr_out_H), axis=0)
    
    return arr_out

# vecsize = 40
vecsize = 20

#===========================================

tes_nat = np.fromfile('test_data/ref-examples/cmu_us_arctic_slt_a0003.mgc',dtype=np.float32)
tes_nat_re = np.reshape(tes_nat,(-1,vecsize)).astype(np.float)
tes_nat_len = len(tes_nat_re[:,1:])

tes_synth = np.fromfile('test_data/aligned-synth-examples/cmu_us_arctic_slt_a0003.mgc',dtype=np.float32)
tes_synth_re = np.reshape(tes_synth,(-1,vecsize)).astype(np.float)
tes_synth_len = len(tes_synth_re[:,1:])

#==========================================

nat = np.fromfile('test_data/ref-examples/vibid_fena_0001.mgc',dtype=np.float32)
synth = np.fromfile('test_data/aligned-synth-examples/vibid_fena_0001.mgc',dtype=np.float32)

nat_re = np.reshape(nat,(-1,vecsize)).astype(np.float)
nat_len = len(nat_re[:,1:])

synth_re = np.reshape(synth,(-1,vecsize)).astype(np.float)
synth_len = len(synth_re[:,1:])

uttId = 'vibid_fena_0001'

if not len(nat) == len(synth):
      print("array length is not same, manipulating\n")
      
      natFile = "test_data/ref-examples/" + uttId + ".mgc"
      synthFile = "test_data/aligned-synth-examples/" + uttId + ".mgc"
      
      print(natFile)
      print(synthFile)
      
      natNew = np.fromfile(natFile, dtype=np.float32)
      synthNew = np.fromfile(synthFile, dtype=np.float32)
      
      if len(nat) > len(synth):
          natNew = array_samelen(natNew,synthNew)
      elif len(nat) < len(synth):
          synthNew = array_samelen(synthNew,natNew)
      
      nat = np.reshape(natNew,(-1, 20)).astype(np.float)
      synth = np.reshape(synthNew,(-1, 20)).astype(np.float)
      
      nat = nat[:, 1:]
      synth = synth[:, 1:]
