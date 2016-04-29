#!/bin/bash

# Perftools : performance analysis tools provided by Cray
module load perftools/6.3.0


##############################
#####   USING  CRAYPAT   #####
##############################

# ------> 0 step : define those environment variables before sourcing this file :
# > export INSTR_SPHFLOW_DIR= && export PAT_RT_EXPFILE_DIR=

# Where : INSTR_SPHFLOW_DIR is the path to sphflow binary
#         PAT_RT_EXPFILE_DIR is the path for output profiling files

# ------> 1st step : compile with the -h profile_generate compile option

# ------> 2nd step : instrument your application :
#  > pat_build ${INSTR_SPHFLOW_DIR}/sphflow
export PAT_BUILD_OPTIONS="-f -w -o ${INSTR_SPHFLOW_DIR}/sphflow+pat"

# PAT_BUILD_OPTIONS : Specifies the pat_build options that are evaluated before
#                     any options on the command line.

# -f : If the output file instr_program already exists, overwrite it.
# -o instr_program : The resulting instrumented program. If the -o option
#     is not specified, and the instrumented program name is not otherwise
#     specified as the final argument, the resulting instrumented program
#     is written to the file program+pat.
# -w : Make tracing the default experiment and create new trace intercept
#      routines for those functions for which no trace intercept routine already exists.


# ------> 3rd step : run your application, *.xf result stored in PAT_RT_EXPFILE_DIR
#export PAT_RT_EXPFILE_DIR=${PWD}/pat-results


# ------> 4th step : create report :
export PAT_REPORT_OPTIONS="-i ${INSTR_SPHFLOW_DIR}/sphflow+pat -O profile,loop_times,calltree -H -P -d time%@0.05"

# > pat_report -O profile,accelerator,accpc,acc_time,ca+src,ct+src -H *.xf
# > pat_report *.xf > log

#  PAT_REPORT_OPTIONS :
#              If the -z option is specified on the pat_report command
#              line, this environment variable is ignored.

#              If the -z option is not specified, then, if this environment
#              variable is set before pat_report is invoked, the options in
#              this environment variable are evaluated before any other
#              options on the command line.

#  PAT_REPORT_PRUNE_NAME :
#              Prune (remove) functions by name from a report. If not set
#              or set to an empty string, no pruning is done. Set this
#              variable to a comma-delimited list (__pat_, __wrap_, etc.)
#              to supercede the default list, or begin this list with a
#              comma (,) to append this list to the default list. A name
#              matches if it has a list item as a prefix.

#  -O profile : Show data by function name only
#  -O accelerator : Show calltree of accelerator performance data
#                   sorted by host time. (Cray XK systems only)
#  -O ca+src : Show line numbers in callers
#  -O ct+src : Show line numbers in calltree
#  -O calltree (or ct) : Show calltree (top-down view)
#  -O loop_times : Inclusive and Exclusive Time in Loops. If the compiler -h profile_generate option
#                  was used when compiling and linking the program, then this table will be included in a default report

#  -C : Add table_caption as a caption to a table specified using
#       the -b and -d options.

#  -H : By default, if hardware performance counter information was
#       collected, it is displayed. To suppress the display of this
#       information and improve the clarity of the calltree and
#       callers table, use the -H option.

#  -d time%@0.05 : treshhold to 0.05% total time

#  -T : Set to zero all thresholds specified in -d options using the
#       @ syntax (for example, -d time%@0.05). The effect is that
#       only values that are truly zero are suppressed. This option
#       can be helpful when you want to see the parts of a table
#       that are hidden by the default thresholds.

