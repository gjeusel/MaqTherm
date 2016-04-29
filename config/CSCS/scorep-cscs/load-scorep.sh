#!/bin/bash

##################
# Using scorep on daint with cmake :
# load scorep
# configure toolchain same way as scorep-cscs
# > export SCOREP=ON
# > make
# profiling = true && launch job
# cube profile.cubex
# scorep-score -r profile.cubex  (give the trace memory max)
# scorep-score -f filter.intel -r profile.cubex  ( reduce the trace memory max )
# then, to obtain the trace :
# export SCOREP_ENABLE_PROFILING=false
# export SCOREP_ENABLE_TRACING=true
# export SCOREP_FILTERING_FILE=path_to/filter.intel
# export SCOREP_TOTAL_MEMORY= memory max found earlier
# launch job
##################

#######  PROFILING STEP : #######
module unload scorep/1.4.1
module load scorep/1.4.1
export PATH=/apps/daint/5.2.UP02/scorep/1.4.2/int1501sci1304mpi722cuda6514acc311otf151opa114cube431/bin:$PATH
export SCOREP=ON
export SCOREP_ENABLE_PROFILING=true
export SCOREP_ENABLE_TRACING=false
export SCOREP_VERBOSE=true
export SCOREP_EXPERIMENT_DIRECTORY="${PWD}/scorep-results"
export SCOREP_OVERWRITE_EXPERIMENT_DIRECTORY=true


######  TRACING STEP : #########
export SCOREP_ENABLE_PROFILING=false
export SCOREP_ENABLE_TRACING=true
export SCOREP_METRIC_PAPI=PAPI_TOT_CYC,PAPI_DP_OPS,PAPI_VEC_DP
export SCOREP_METRIC_PAPI_PER_PROCESS=PAPI_DP_OPS
export SCOREP_TOTAL_MEMORY=2GB    # 16000000 by default
export SCOREP_FILTERING_FILE=${HOME}/sph-flow-feature-acc/config/CSCS/scorep-cscs/filter_monaghan.intel


####### MORE OPTIONS : #######
#export SCOREP_OPENCL_ENABLE=yes
#export SCOREP_CUDA_ENABLE=yes
#export SCOREP_CUDA_ENABLE=driver,kernel,kernel_counter,memcpy,sync,gpumemusage
#export SCOREP_CUDA_BUFFER=1GB
#export SCOREP_METRIC_PLUGINS=

