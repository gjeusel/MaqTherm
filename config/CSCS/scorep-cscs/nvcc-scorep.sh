#!/bin/bash

if [ $SCOREP = "ON" ] ; then 
        `which scorep` --cuda nvcc "$@"
else
        nvcc "$@"
fi
