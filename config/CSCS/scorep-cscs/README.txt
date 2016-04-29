# Obtaining a trace using scorep on daint with cmake on large applications
  takes 2 steps :
   - the first is a simple profiling of the code in order to gather informations
     about the amount of datas produced per function if tracing is one.
   - the second consist of creating a filterFile
     (Be carefull : function names depend on the compiler used)
   - Finally the tracing option of scorep can be set to true using this filter.

Step 1 :
Use the config/CSCS/scorep-cscs/scorep-cscs-toolchain.cmake toolchain
Load scorep and initialize options (see config/CSCS/scorep-cscs/load-scorep.sh -- Profiling Step)

> cmake -DCMAKE_TOOLCHAIN_FILE=[...]/config/CSCS/scorep-cscs/scorep-cscs-toolchain.cmake [...]
> source config/CSCS/scorep-cscs/load-scorep.sh
launch job


Step 2 :
Use cube to exploit the collected informations, and write a filter file
(see filter_monaghan.intel for an example)

> cube profile.cubex
> scorep-score -r profile.cubex  (give the trace memory max)
> scorep-score -f filter.intel -r profile.cubex  ( reduce the trace memory max )

Step 3 :
Then, to obtain the trace : set to true the scorep tracing option, select your metrics,
and add the filter file :
> export SCOREP_ENABLE_PROFILING        = false
> export SCOREP_ENABLE_TRACING          = true
> export SCOREP_METRIC_PAPI             = PAPI_TOT_CYC,PAPI_DP_OPS,PAPI_VEC_DP
> export SCOREP_METRIC_PAPI_PER_PROCESS = PAPI_DP_OPS
> export SCOREP_TOTAL_MEMORY            = 2GB    # 16000000 by default
> export SCOREP_FILTERING_FILE          = ${HOME}/sph-flow-feature-acc/config/CSCS/scorep-cscs/filter_monaghan.intel
launch job
