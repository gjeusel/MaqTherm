#!/bin/bash

if [ $SCOREP = "ON"  ] ; then
        #`which scorep` --mpp=mpi --cuda cc "$@"
        #`which scorep` --mpp=mpi --thread=omp cc "$@"
        #`which scorep` --mpp=mpi --thread=omp --nopreprocess cc "$@"
        #`which scorep` --mpp=mpi --user cc "$@"
        `which scorep` --mpp=mpi cc "$@"
        #`which scorep` cc "$@"
else
  cc "$@"
fi

