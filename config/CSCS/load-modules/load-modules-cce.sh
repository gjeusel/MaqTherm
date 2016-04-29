#!/bin/bash

# Module convenience :
module load cmake/3.3.2

# Modules for GPU :
module switch PrgEnv-cray/5.2.82 PrgEnv-cray/5.2.82
module swap cray-mpich cray-mpich/7.2.2
module load craype-accel-nvidia35

#export CRAY_ACC_DEBUG=3
#module load ddt
