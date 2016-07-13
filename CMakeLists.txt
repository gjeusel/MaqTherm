cmake_minimum_required(VERSION 3.3)

# Handle superbuild first
option(USE_SUPERBUILD "Whether or not a superbuild should be invoked" ON)

#if(USE_SUPERBUILD)
#  project(SUPERBUILD NONE)
#  # execute the superbuild (this script will be invoked again without the USE_SUPERBUILD option this time)
#  include(cmake/SuperBuild.cmake)
#  return() # stop processing this file further
#else()
#  project(maqTherm)
#endif()

project(maqTherm)
enable_language(CXX C)

# Nomination of the version by the date of the release
set(maqTherm_MAJOR_VERSION 16)
set(maqTherm_MINOR_VERSION 05)
set(maqTherm_PATCH_VERSION 0)
set(maqTherm_VERSION ${maqTherm_MAJOR_VERSION}.${maqTherm_MINOR_VERSION}.${maqTherm_PATCH_VERSION})

# Sanitize the build directory
set(MAQTHERM_BUILD_NAME     "" CACHE STRING "maqTherm configuration name")
set(MAQTHERM_BUILD_NAME_DIR .  CACHE STRING "maqTherm configuration directory")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib-maqTherm CACHE PATH "Single directory for all static libraries.")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib-maqTherm CACHE PATH "Single directory for all libraries.")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin CACHE PATH "Single directory for all executables.")
#set(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath,\$ORIGIN/../lib:\$ORIGIN/../../lib:\$ORIGIN")

#-----------------------------------------------------------------------------
# - Compiling types availables

# CMAKE_BUILD_TYPE_STRINGS_EXTRA can be altered by the toolchain to add compile types
set(CMAKE_BUILD_TYPE_STRINGS " " "Debug" "Release" ${CMAKE_BUILD_TYPE_STRINGS_EXTRA})
set(CMAKE_BUILD_TYPE_PREFIX_STRINGS "")
foreach(type ${CMAKE_BUILD_TYPE_STRINGS})
  list (APPEND CMAKE_BUILD_TYPE_PREFIX_STRINGS "_${type}" )
endforeach()
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "" ${CMAKE_BUILD_TYPE_STRINGS})

foreach(type "" ${CMAKE_BUILD_TYPE_PREFIX_STRINGS})
  string(TOUPPER "${type}" type_UP)
  set(CMAKE_CXX_FLAGS${type_UP} "${CMAKE_CXX_FLAGS${type_UP}} ${CMAKE_CXX_FLAGS${type_UP}_${CMAKE_CXX_COMPILER_ID}}")
  message(STATUS "CMAKE_CXX_FLAGS${type_UP}=${CMAKE_CXX_FLAGS${type_UP}}")
endforeach()

#-----------------------------------------------------------------------------
# Compilers details

if(CMAKE_CXX_COMPILER MATCHES "gfortran" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -ffree-line-length-none")
endif()

#-----------------------------------------------------------------------------
# Pré-compile options handling :

# macro to simplify options_list appending
macro(add_option opt default desc)
  list(APPEND options_list ${opt})
  set(${opt}_DEFAULT ${default} CACHE INTERNAL "")
  set(${opt}_DESC    ${desc} CACHE INTERNAL "")
  set(${opt}_VALUES  ${ARGN} CACHE INTERNAL "")
endmacro()

# pré-compile options :
add_option(maqTherm_CALC 3D "Dimensionality" 2D;3D)

# name's formalism about pre-compile options
include(FeatureSummary)
file(WRITE "${maqTherm_BINARY_DIR}/maqTherm_options.cmake" "")
foreach(opt ${options_list})
  if("${${opt}_VALUES}" MATCHES "ON;OFF")
    option(${opt} ${${opt}_DESC} ${${opt}_DEFAULT})
    add_feature_info(${opt} ${${opt}} "")
    file(APPEND "${maqTherm_BINARY_DIR}/maqTherm_options.cmake"
    "set(${opt} ${${opt}} CACHE BOOL \"${${opt}_DESC}\" FORCE)
")
  else() # combo box
    set(${opt} ${${opt}_DEFAULT} CACHE STRING "${${opt}_DESC} (${${opt}_VALUES})")
    set_property(CACHE ${opt} PROPERTY STRINGS ${${opt}_VALUES})
    add_feature_info(${opt}_${${opt}} ON "")
    file(APPEND "${maqTherm_BINARY_DIR}/maqTherm_options.cmake"
        "set(${opt} ${${opt}} CACHE STRING \"${${opt}_DESC} (${${opt}_VALUES})\" FORCE)
")

    # check wether ${opt} as a valid value
    set(${opt}_valid OFF)
    foreach(val ${${opt}_VALUES})
      if("${${opt}}" MATCHES ${val})
          set(${opt}_valid ON)
      endif()
    endforeach()

    if(NOT ${${opt}_valid})
      message(FATAL_ERROR "  ${opt}=${${opt}} should be one of ${${opt}_VALUES}  ")
    endif()
  endif()
endforeach()

FEATURE_SUMMARY(WHAT ENABLED_FEATURES  DESCRIPTION "Enable Features:")
FEATURE_SUMMARY(WHAT DISABLED_FEATURES DESCRIPTION "Disabled features:")

get_property(ENABLED_KEYWORDS GLOBAL PROPERTY ENABLED_FEATURES)
set(BOOLEAN_KEYWORDS_ON "")
foreach(keyword ${ENABLED_KEYWORDS})
  if("${${keyword}_VALUES}" MATCHES "ON;OFF")
    list(APPEND BOOLEAN_KEYWORDS_${${keyword}} ${keyword})
    list(REMOVE_ITEM ENABLED_KEYWORDS ${keyword})
  endif()
  list(APPEND definitions -D${keyword})
endforeach()

get_property(DISABLED_KEYWORDS GLOBAL PROPERTY DISABLED_FEATURES)
set(BOOLEAN_KEYWORDS_OFF "")
foreach(keyword ${DISABLED_KEYWORDS})
  if("${${keyword}_VALUES}" MATCHES "ON;OFF")
    list(APPEND BOOLEAN_KEYWORDS_${${keyword}} ${keyword})
    list(REMOVE_ITEM ENABLED_KEYWORDS ${keyword})
  endif()
endforeach()

# Adding -D[list of options ON]
add_definitions(${definitions})


#---------------------------------------------------------------------
# Source files handling

configure_file(${maqTherm_SOURCE_DIR}/config.h.in ${maqTherm_BINARY_DIR}/config.h  @ONLY)

# set up include-directories
include_directories(${maqTherm_BINARY_DIR})
include_directories("${maqTherm_SOURCE_DIR}/src")
#include_directories("${maqTherm_SOURCE_DIR}/src/Declarations")
#include_directories("${maqTherm_SOURCE_DIR}/src/Interactions/")
#include_directories("${maqTherm_SOURCE_DIR}/src/Models")


add_library(maqTherm_mockup_objs_cxx OBJECT
  ./src/Personnage.cpp
  ./src/Arme.cpp
  ./src/Duree.cpp
  )

add_executable(maqTherm.exe
  $<TARGET_OBJECTS:maqTherm_mockup_objs_cxx>
  ./src/main.cpp
  )


#---------------------------------------------------------------------
# External Libraries handling
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

find_package(Boost REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})

#link_directories(/nix/store/sxpf6jwyq33xc5as8c46191r56xsil3g-cute-2.0/lib/)
include_directories(/nix/store/idi2kfdmgilkmp8zid3ip82wbgpd3jdx-cute-2.0/include/)
