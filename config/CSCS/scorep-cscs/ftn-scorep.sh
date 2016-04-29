#!/bin/bash

if [ $SCOREP = "ON" ] ; then 
        #`which scorep` --mpp=mpi --cuda ftn "$@"
        #`which scorep` --mpp=mpi --thread=omp ftn "$@"
        #`which scorep` --mpp=mpi --thread=omp --nopreprocess ftn "$@"
        #`which scorep` --mpp=mpi --user ftn "$@"
        `which scorep` --mpp=mpi ftn "$@"
        #`which scorep` ftn "$@"
else
        ftn "$@"
fi
