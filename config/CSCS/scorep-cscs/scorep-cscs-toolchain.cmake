#-----------------------------------------------------------------------------
# Setting compilers
#-----------------------------------------------------------------------------
set(CMAKE_BUILD_TYPE RelWithAVX CACHE STRING "")

set(CMAKE_C_COMPILER       "${SPHFlow_SOURCE_DIR}/config/CSCS/scorep-cscs/cc-scorep.sh"  CACHE STRING "")
set(CMAKE_CXX_COMPILER     "${SPHFlow_SOURCE_DIR}/config/CSCS/scorep-cscs/cpp-scorep.sh"  CACHE STRING "")
set(CMAKE_Fortran_COMPILER "${SPHFlow_SOURCE_DIR}/config/CSCS/scorep-cscs/ftn-scorep.sh" CACHE STRING "")


set(CMAKE_MAKE_PROGRAM make CACHE STRING "")
set(CMAKE_USE_RELATIVE_PATHS ON CACHE BOOL "")
set(DOXYFILE_LATEX OFF CACHE BOOL "")

set(SPHFlow_SUPERBUILD OFF CACHE BOOL "")
set(CMAKE_BUILD_TYPE_STRINGS_EXTRA "") # to add new compile option combo

# INTEL COMPILER {{{
if("$ENV{PE_ENV}" STREQUAL INTEL)
  set(CMAKE_Fortran_FLAGS "" CACHE STRING "")

  set(CMAKE_Fortran_FLAGS_DEBUG "-g -O0 -check all -fpe0 -debug all -traceback" CACHE STRING "")

  set(INLINING_FLAGS " -inline-forceinline -no-inline-factor -no-inline-max-per-compile -no-inline-max-per-routine -no-inline-max-total-size -no-inline-max-size -no-inline-min-size")
  set(IPO_FLAGS "-ip -ipo")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -fp-model fast=2" CACHE STRING "")
  #set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -fp-model fast=2 ${INLINING_FLAGS} ${IPO_FLAGS}" CACHE STRING "")

  set(REMARK_DISABLING_FLAGS "-diag-disable 10346")

  set(REPORT_FLAGS " -opt-report=5 -opt-report-phase=loop,vec -opt-report-file=compil_report.txt")
  set(SIMD_FLAGS "-mavx -openmp ${REMARK_DISABLING_FLAGS} ${REPORT_FLAGS}")
  set(CMAKE_Fortran_FLAGS_RELWITHAVX   "${CMAKE_Fortran_FLAGS_RELEASE} ${SIMD_FLAGS}" CACHE STRING "")
  set(CMAKE_Fortran_FLAGS_RELWITHNOAVX "${CMAKE_Fortran_FLAGS_RELEASE} -no-vec -opt-report=0" CACHE STRING "")

  set(CMAKE_Fortran_FLAGS_DEBWITHGPROF "-pg -g ${CMAKE_Fortran_FLAGS_DEBUG}" CACHE STRING "")
  set(CMAKE_Fortran_FLAGS_RELWITHGPROF "-pg -g ${CMAKE_Fortran_FLAGS_RELEASE}" CACHE STRING "")

  set_property(SOURCE
      ./src/Interactions/Interaction_TVR_Fluid_Monaghan.F90
      APPEND_STRING PROPERTY COMPILE_FLAGS " -opt-report=5 -opt-report-phase=loop,vec -opt-report-file=monaghan_compil_report.txt")

  mark_as_advanced(CMAKE_Fortran_FLAGS_RELWITHAVX)
  mark_as_advanced(CMAKE_Fortran_FLAGS_RELWITHNOAVX)
  mark_as_advanced(CMAKE_Fortran_FLAGS_DEBWITHGPROF)
  mark_as_advanced(CMAKE_Fortran_FLAGS_RELWITHGPROF)
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithAVX")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithNOAVX")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "DebWithGprof")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithGprof")
endif()
#}}}

# GNU COMPILER {{{
if("$ENV{PE_ENV}" STREQUAL GNU)
  set(CMAKE_Fortran_FLAGS "" CACHE STRING "")

  set(GFORTRAN_WARNINGS "-Warray-bounds -Wcharacter-truncation -Wconversion -Wimplicit-interface  -Wimplicit-procedure  -Wline-truncation -Wintrinsics-std  -Wsurprising  -Wno-tabs")

  set(CMAKE_Fortran_FLAGS_DEBUG "${GFORTRAN_WARNINGS} -g -pipe -fno-omit-frame-pointer -fbounds-check -fbacktrace" CACHE STRING "")
  set(CMAKE_Fortran_FLAGS_RELEASE "-pipe -O3 -ftree-vectorize" CACHE STRING "")

  set(CMAKE_Fortran_FLAGS_DEBWITHGPROF "-pg -g ${CMAKE_Fortran_FLAGS_DEBUG}" CACHE STRING "")
  set(CMAKE_Fortran_FLAGS_RELWITHGPROF "-pg -g ${CMAKE_Fortran_FLAGS_RELEASE}" CACHE STRING "")

  mark_as_advanced(CMAKE_Fortran_FLAGS_DEBWITHGPROF)
  mark_as_advanced(CMAKE_Fortran_FLAGS_RELWITHGPROF)
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "DebWithGprof")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithGprof")
endif()
#}}}

# PGI COMPILER {{{
if("$ENV{PE_ENV}" STREQUAL PGI)

  # Choice : acc desactivated by default
  set(CMAKE_Fortran_FLAGS "-Mpreprocess -Kieee -noacc -nomp" CACHE STRING "")

  set(AVX_FLAGS "-Mvect=simd -Munroll -Mcache_align -Mipa=align -Minfo=vect")
  set(ACC_FLAGS "-acc -ta=nvidia -Minfo=accel")
  set(CUDA_F_FLAGS "-Mcuda -L$ENV{CUDA_HOME}/lib64/ -lcudart")
  set(OMP_FLAGS "-mp")

  set(CMAKE_Fortran_FLAGS_DEBUG "-g -C -Mbounds -Mchkptr" CACHE STRING "")
  set(CMAKE_Fortran_FLAGS_RELEASE "-fast -O4 -Mipa=fast,inline" CACHE STRING "")

  set(CMAKE_Fortran_FLAGS_DEBWITHCUFACC "${CMAKE_Fortran_FLAGS_DEBUG}   ${ACC_FLAGS} ${CUDA_F_FLAGS}" CACHE STRING "")
  set(CMAKE_Fortran_FLAGS_RELWITHCUFACC "${CMAKE_Fortran_FLAGS_RELEASE} ${ACC_FLAGS} ${CUDA_F_FLAGS}" CACHE STRING "")

  set(CMAKE_Fortran_FLAGS_DEBWITHAVX   "${CMAKE_Fortran_FLAGS_DEBUG}   ${AVX_FLAGS}" CACHE STRING "")
  set(CMAKE_Fortran_FLAGS_RELWITHNOAVX "${CMAKE_Fortran_FLAGS_RELEASE} ${AVX_FLAGS}" CACHE STRING "")

  set(CMAKE_Fortran_FLAGS_DEBWITHACC "${CMAKE_Fortran_FLAGS_DEBUG}   ${ACC_FLAGS} -Mnobounds" CACHE STRING "")
  # -Mnobounds to avoid : "pgf90-Warning-CUDA Fortran or OpenACC GPU targets disables -Mbounds"
  set(CMAKE_Fortran_FLAGS_RELWITHACC "${CMAKE_Fortran_FLAGS_RELEASE} ${ACC_FLAGS}" CACHE STRING "")

  set(CMAKE_Fortran_FLAGS_DEBWITHOMP "${CMAKE_Fortran_FLAGS_DEBUG}   ${OMP_FLAGS}" CACHE STRING "")
  set(CMAKE_Fortran_FLAGS_RELWITHOMP "${CMAKE_Fortran_FLAGS_RELEASE} ${OMP_FLAGS}" CACHE STRING "")

  mark_as_advanced(CMAKE_Fortran_FLAGS_DEBWITHCUFACC)
  mark_as_advanced(CMAKE_Fortran_FLAGS_RELWITHCUFACC)
  mark_as_advanced(CMAKE_Fortran_FLAGS_DEBWITHAVX)
  mark_as_advanced(CMAKE_Fortran_FLAGS_RELWITHAVX)
  mark_as_advanced(CMAKE_Fortran_FLAGS_DEBWITHACC)
  mark_as_advanced(CMAKE_Fortran_FLAGS_RELWITHACC)
  mark_as_advanced(CMAKE_Fortran_FLAGS_DEBWITHOMP)
  mark_as_advanced(CMAKE_Fortran_FLAGS_RELWITHOMP)
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "DebWithCUFACC")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithCUFACC")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "DebWithACC")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithACC")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "DebWithAVX")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithAVX")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "DebWithOMP")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithOMP")
endif()
#}}}

# CCE Cray COMPILER {{{
if("$ENV{PE_ENV}" STREQUAL CRAY)

  # Choice : acc desactivated by default
  set(CMAKE_Fortran_FLAGS "-h noacc,noomp" CACHE STRING "")

  set(VERBOSITY_FLAGS "-h msgs")

  set(CMAKE_Fortran_FLAGS_DEBUG "-g -R b -R c -R s -R p" CACHE STRING "")
# -eD option enables all debugging options : equivalent to specifying the -G0 or -g with the -m2, -rl and -R bcdsp options.
# -vector0 : Minimal automatic vectorization. Characteristics include low compile time and small compile size.
  set(CMAKE_Fortran_FLAGS_RELEASE "-O3,fp3" CACHE STRING "")

  set(PAT_FLAGS "-h profile_generate") # Cray profiler
  set(CMAKE_Fortran_FLAGS_PATPROF "${CMAKE_Fortran_FLAGS_RELEASE} ${PAT_FLAGS}" CACHE STRING "")

  set(REVEAL_FLAGS "-h pl=sphflow.pl") # Cray analysis tools
  set(CMAKE_Fortran_FLAGS_REVEAL "${CMAKE_Fortran_FLAGS_PATPROF} ${REVEAL_FLAGS}" CACHE STRING "")

  set(ACC_FLAGS "-h acc -hacc_model=auto_async_none -h lista=a")
  # export CRAY_ACC_DEBUG 3 : Write accelerator-related activity to stdout for debugging
  #                           purposes. Valid output levels range from 0, which indicates
  #                           no output, through 3, which indicates verbose. Default is 0
  set(CMAKE_Fortran_FLAGS_DEBWITHACC "${CMAKE_Fortran_FLAGS_DEBUG}   ${ACC_FLAGS}" CACHE STRING "")
  set(CMAKE_Fortran_FLAGS_RELWITHACC "${CMAKE_Fortran_FLAGS_RELEASE} ${ACC_FLAGS}" CACHE STRING "")

  #set(CMAKE_Fortran_FLAGS_WITHAVX "-O 2 -hvector2 -h list=m -rm" CACHE STRING "")
  #set(CMAKE_Fortran_FLAGS_WITHNOAVX "-O 2 -hvector0 -hpf0" CACHE STRING "")
  #set(CMAKE_Fortran_FLAGS_WITHACC "-h acc,noomp -hacc_model=auto_async_none:deep_copy -h list=a -h keepfiles -fpic -h vector0 -h nopattern -dynamic -G2 -h msgs" CACHE STRING "")
  #set(CMAKE_Fortran_FLAGS_WITHNOACC "-h noacc,noomp -h list=m -h keepfiles -fpic -dynamic -G2 -h msgs" CACHE STRING "")

  mark_as_advanced(CMAKE_Fortran_FLAGS_PATPROF)
  mark_as_advanced(CMAKE_Fortran_FLAGS_REVEAL)
  mark_as_advanced(CMAKE_Fortran_FLAGS_DEBWITHACC)
  mark_as_advanced(CMAKE_Fortran_FLAGS_RELWITHACC)
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "PatProf")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "Reveal")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "DebWithACC")
  set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithACC")
endif()
#}}}


#-----------------------------------------------------------------------------
# External libraries
#-----------------------------------------------------------------------------
# Directories
set(_MPI_HOME $ENV{MPICH_DIR} CACHE STRING "")
list(APPEND CMAKE_FIND_ROOT_PATH ${_MPI_HOME} CACHE STRING "")
