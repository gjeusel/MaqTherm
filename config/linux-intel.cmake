##! @file linux-intel.cmake.dox Intel tool chain for linux machines
##! @page linuxIntelPage Intel compilers on linux machines
##!
##! @section EnvConfig Configure your account
##!
##! @subsection nixosIntelSec NixOS linux
##! NixOS is a Nix-based Linux distribution. Thanks to Nix, it supports atomic
##! upgrades, rollbacks and multi-user package management, and it has a
##! declarative approach to system configuration management that makes it easy to
##! reproduce a configuration on another machine.
##!
##!@verbatim
##! $ nix-env -i env-sphflow-intel@endverbatim
##!
##! Each time, you log in you have to load this environment
##!
##!@verbatim
##! $ load-env-sphflow-intel@endverbatim
##!
##! @subsection genericIntelSec Other linux
##!
##! On any linux distribution, install the intel compilers.
##!
##! @section BuildSec Build SPH-flow
##!
##! And use this file as
##!@verbatim
##! $ mkdir build
##! $ cd build
##! $ cmake -DCMAKE_TOOLCHAIN_FILE=../config/linux-intel.cmake ..@endverbatim

set(CMAKE_BUILD_TYPE Release CACHE STRING "")
# setting compilers
set(CMAKE_Fortran_COMPILER ifort CACHE STRING "")
set(CMAKE_C_COMPILER       icc   CACHE STRING "")
set(CMAKE_CXX_COMPILER     icpc  CACHE STRING "")
set(CMAKE_AR               xiar  CACHE STRING "" FORCE)

set(CMAKE_Fortran_FLAGS_DEBUG "-O0 -CA -CU -CB -fpe0 -debug full -traceback" CACHE STRING "")
set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -msse4.2 -ip -ipo -vec-report0 -fp-model fast=2 -inline-forceinline -no-inline-factor -no-inline-max-per-compile -no-inline-max-per-routine -no-inline-max-total-size -no-inline-max-size -no-inline-min-size" CACHE STRING "")
set(CMAKE_Fortran_FLAGS_RELWITHNOVEC "-g -no-vec -xAVX -ip -ipo -vec-report0 -fp-model fast=2 -inline-forceinline -no-inline-factor -no-inline-max-per-compile -no-inline-max-per-routine -no-inline-max-total-size -no-inline-max-size -no-inline-min-size" CACHE STRING "")
set(CMAKE_Fortran_FLAGS_RELWITHAVX   "-g -xAVX         -ip -ipo -vec-report0 -fp-model fast=2 -inline-forceinline -no-inline-factor -no-inline-max-per-compile -no-inline-max-per-routine -no-inline-max-total-size -no-inline-max-size -no-inline-min-size" CACHE STRING "")

set_property(SOURCE
    ./src/Interactions/Interaction_TVR_Fluid_Riemann.F90
    APPEND_STRING PROPERTY COMPILE_FLAGS " -vec-report3")
set_property(SOURCE
    ./src/Interactions/Interaction_MUSCL_Renorm.F90
    APPEND_STRING PROPERTY COMPILE_FLAGS " -vec-report3")

set(CMAKE_Fortran_FLAGS_DEBWITHGPROF "-pg -g ${CMAKE_Fortran_FLAGS_DEBUG}" CACHE STRING "")
set(CMAKE_Fortran_FLAGS_RELWITHGPROF "-pg -g ${CMAKE_Fortran_FLAGS_RELEASE}" CACHE STRING "")

set(CMAKE_BUILD_TYPE_STRINGS_EXTRA "RelWithNoVec" "RelWithAVX" "DebWithGPROF" "RelWithGPROF")

set(JOB_TEMPLATE ${SPHFlow_SOURCE_DIR}/config/job.sh.in CACHE FILEPATH "")
