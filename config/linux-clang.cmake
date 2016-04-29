set(CMAKE_BUILD_TYPE Debug CACHE STRING "")

# setting compilers
set(CMAKE_C_COMPILER       clang   CACHE STRING "")
set(CMAKE_CXX_COMPILER     clang++  CACHE STRING "")

set(GFORTRAN_WARNINGS "-Warray-bounds -Wcharacter-truncation -Wconversion -Wimplicit-interface  -Wimplicit-procedure  -Wline-truncation -Wintrinsics-std  -Wsurprising  -Wno-tabs  -Wunderflow -Wunused-parameter")
set(CMAKE_CXX_FLAGS_DEBUG "${GFORTRAN_WARNINGS} -g -pipe -fno-omit-frame-pointer  -fbounds-check -fbacktrace" CACHE STRING "")
set(CMAKE_CXX_FLAGS_RELEASE "-pipe -O3 -ftree-vectorize" CACHE STRING "")

set(REPORT_FLAGS " -opt-report=5 -opt-report-phase=loop,vec -opt-report-file=compil_report.txt")
set(SIMD_FLAGS "-fopenmp ${REMARK_DISABLING_FLAGS} ${REPORT_FLAGS}")
set(CMAKE_CXX_FLAGS_RELWITHAVX   "${CMAKE_CXX_FLAGS_RELEASE} ${SIMD_FLAGS}" CACHE STRING "")
set(CMAKE_CXX_FLAGS_RELWITHNOAVX "${CMAKE_CXX_FLAGS_RELEASE} -no-vec -opt-report=0" CACHE STRING "")

set(CMAKE_CXX_FLAGS_DEBWITHGPROF "-pg -g ${CMAKE_CXX_FLAGS_DEBUG}" CACHE STRING "")
set(CMAKE_CXX_FLAGS_RELWITHGPROF "-pg -g ${CMAKE_CXX_FLAGS_RELEASE}" CACHE STRING "")

mark_as_advanced(CMAKE_CXX_FLAGS_RELWITHAVX)
mark_as_advanced(CMAKE_CXX_FLAGS_RELWITHNOAVX)
mark_as_advanced(CMAKE_CXX_FLAGS_DEBWITHGPROF)
mark_as_advanced(CMAKE_CXX_FLAGS_RELWITHGPROF)
set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithAVX")
set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithNOAVX")
set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "DebWithGprof")
set(CMAKE_BUILD_TYPE_STRINGS_EXTRA ${CMAKE_BUILD_TYPE_STRINGS_EXTRA} "RelWithGprof")
