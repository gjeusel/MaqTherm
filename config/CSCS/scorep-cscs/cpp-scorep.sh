#!/bin/bash

if [ $SCOREP = "ON"  ] ; then
        #`which scorep` --mpp=mpi --cuda CC "$@"
        #`which scorep` --mpp=mpi --thread=omp CC "$@"
        #`which scorep` --mpp=mpi --thread=omp --nopreprocess CC "$@"
        #`which scorep` --mpp=mpi --user CC "$@"
        `which scorep` --mpp=mpi CC "$@"
        #`which scorep` CC "$@"
else
  CC "$@"
fi
