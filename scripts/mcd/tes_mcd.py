#!/usr/bin/python2

import numpy as np
import mcd.metrics_fast as mt

#####################################################

paramOrder = 1
#paramOrder = 1

ext = 'mgc'
natDir = 'test_data/ref-examples/'
synthDir = 'test_data/aligned-synth-examples/'

#uttId = 'cmu_us_arctic_slt_a0003'
uttId = 'vibid_fena_0001'

len_same = True
cut_zero = False
costTot = 0.0
framesTot = 0

costFn = mt.logSpecDbDist

#####################################################
#
#self.dtypeFile=np.float32
#
#def readFile(self, vecSeqFile):
#        """Reads a raw vector sequence file.
#
#        The dtype of the returned numpy array is always the numpy default
#        np.float, which may be 32-bit or 64-bit depending on architecture, etc.
#        """
#        return np.reshape(
#            np.fromfile(vecSeqFile, dtype=self.dtypeFile),
#            (-1, self.vecSize)
#        ).astype(np.float)
#
#####################################################
#
#cdef double logSpecDbConst = 10.0 / log(10.0) * sqrt(2.0)
#
#@cython.boundscheck(False)
#def logSpecDbDist(cnp.ndarray[cnp.float64_t, ndim=1] x,
#                  cnp.ndarray[cnp.float64_t, ndim=1] y):
#    cdef unsigned int k, size
#    cdef double diff, sumSqDiff, dist
#
#    size = x.shape[0]
#    assert y.shape[0] == size
#
#    sumSqDiff = 0.0
#    for k in range(size):
#        diff = x[k] - y[k]
#        sumSqDiff += diff * diff
#
#    dist = sqrt(sumSqDiff) * logSpecDbConst
#    return dist
#
#####################################################

def array_samelen(arr_in,arr_ref):
    i_In2 = int(len(arr_in)/2)
    i_Ref2 = int(len(arr_ref)/2)

    arr_out_H = arr_in[i_In2:i_In2+i_Ref2:1]

    arr_in_rev = arr_in[::-1]
    arr_out_L_rev = arr_in_rev[i_In2:i_In2+i_Ref2:1]
    arr_out_L = arr_out_L_rev[::-1]

    arr_out = np.concatenate((arr_out_L, arr_out_H), axis=0)

    return arr_out

#####################################################

print('processing %s' % uttId)

natFile = natDir + "/" + uttId + "." + ext
synthFile = synthDir + "/" + uttId + "." + ext

natf = np.fromfile(natFile, dtype=np.float32)
synthf = np.fromfile(synthFile, dtype=np.float32)

l_nat0 = len(natf)
l_synth0 = len(synthf)

nat0 = np.reshape(natf,(-1, paramOrder)).astype(np.float)
synth0 = np.reshape(synthf,(-1, paramOrder)).astype(np.float)

if cut_zero:
      nat = nat0[:, 1:]
      synth = synth0[:, 1:]
else:
      nat = nat0
      synth = synth0

# Achmadi's here
if len(nat) == len(synth):
    assert len(nat) == len(synth)
    print("array length already same \n")
else:
    print("array length is not same \n")
    natNew = np.fromfile(natFile, dtype=np.float32)
    synthNew = np.fromfile(synthFile, dtype=np.float32)
    
    if len_same:
        print('manipulating array length\n')
        if len(nat) > len(synth):
            natNew = array_samelen(natNew,synthNew)
        elif len(nat) < len(synth):
            synthNew = array_samelen(synthNew,natNew)
        
    l_nat = len(natNew)
    l_synth = len(synthNew)
    
    nat = np.reshape(natNew,(-1, paramOrder)).astype(np.float)
    synth = np.reshape(synthNew,(-1, paramOrder)).astype(np.float)

    if cut_zero:
          nat = nat[:, 1:]
          synth = synth[:, 1:]
    
cost = sum([
        costFn(natFrame, synthFrame)
        for natFrame, synthFrame in zip(nat, synth) ])
frames = len(nat)

costTot += cost
framesTot += frames    

print('overall MCD = %f (%d frames)' % (costTot / framesTot, framesTot))
