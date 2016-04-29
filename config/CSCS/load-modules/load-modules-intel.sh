#!/bin/bash

# Module convenience :
module load cmake/3.3.2

module unload PrgEnv-cray/5.2.82
module load PrgEnv-intel/5.2.82

module swap cray-mpich cray-mpich/7.2.2

export CRAYPE_LINK_TYPE=dynamic
