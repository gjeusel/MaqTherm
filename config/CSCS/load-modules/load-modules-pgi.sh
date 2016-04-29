#!/bin/bash

# Module convenience :
module load cmake/3.3.2

# Modules for GPU :
#module switch PrgEnv-cray/5.2.82 PrgEnv-pgi/5.2.82
module unload PrgEnv-cray/5.2.82
module load PrgEnv-pgi/5.2.82
module swap cray-mpich cray-mpich/7.2.2
module load craype-accel-nvidia35

# Variables d'environnement pour openACC :
export PGI_ACC_NOTIFY=1
export PGI_ACC_TIME=1

export CUDA_HOME=/opt/nvidia/cudatoolkit6.5/6.5.14-1.0502.9613.6.1

# more recent version of PGI with the associated MPICH version :
export PATH=/users/hck28/pgi/linux86-64/15.7/bin:$PATH
export LD_LIBRARY_PATH=/users/hck28/pgi/linux86-64/15.7/lib:$LD_LIBRARY_PATH
export MPICH_DIR=/users/hck28/pgi/linux86-64/15.7/mpi/mpich/

# in order to use nvprof :
unset COMPUTE_PROFILE
export PMI_NO_FORK=1



# configs pour SPH :
export PATH=/apps/ela/sandbox/jgp/SAVESPACE/doxygen/1.8.9.1/gnu_434/bin:$PATH
export CRAYPE_LINK_TYPE=dynamic
