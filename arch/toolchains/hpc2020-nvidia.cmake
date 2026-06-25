####################################################################
# OpenMP FLAGS
####################################################################

# NB: these are never used by ifs-source

set( OpenMP_C_FLAGS             "-mp -mp=bind,allcores,numa" )
set( OpenMP_CXX_FLAGS           "-mp -mp=bind,allcores,numa" )
set( OpenMP_Fortran_FLAGS       "-mp -mp=bind,allcores,numa" )

####################################################################
# OpenAcc FLAGS
####################################################################

set( OpenACC_Fortran_FLAGS "-acc=gpu -gpu=lineinfo,fastmath,rdc" )

####################################################################
# COMMON FLAGS
####################################################################

set(ECBUILD_Fortran_FLAGS "-fpic")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -Mframe")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -Mbyteswapio")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -Mrecursive")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -Kieee")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -Mdaz")

set( ECBUILD_Fortran_FLAGS_BIT "-O2 -gopt -Mstack_arrays" )
set( ECBUILD_Fortran_FLAGS_DEBUG "-O0 -g -C -Mchkstk -Mcoff -Mdwarf1 -Mdwarf2 -Mdwarf3 -Melf -traceback" )
set( ECBUILD_C_FLAGS_BIT "-O2 -gopt -traceback" )
set( ECBUILD_CXX_FLAGS_BIT "-O2 -gopt" )

# If a Python interpreter is already visible on PATH when the toolchain file is
# loaded, set hints to use that version.

string(REPLACE ":" ";" _python_search_path "$ENV{PATH}")

find_program(_python3_executable
  NAMES python3 python
  PATHS ${_python_search_path}
  NO_DEFAULT_PATH)

if(_python3_executable)
  get_filename_component(_python_bindir "${_python3_executable}" DIRECTORY)
  get_filename_component(_python_prefix "${_python_bindir}" DIRECTORY)

  set(Python3_EXECUTABLE "${_python3_executable}" CACHE FILEPATH "" FORCE)
  set(Python_EXECUTABLE  "${_python3_executable}" CACHE FILEPATH "" FORCE)
  set(PYTHON_EXECUTABLE  "${_python3_executable}" CACHE FILEPATH "" FORCE)

  set(Python3_ROOT_DIR "${_python_prefix}" CACHE PATH "" FORCE)
  set(Python_ROOT_DIR  "${_python_prefix}" CACHE PATH "" FORCE)
  set(PythonInterp_ROOT_DIR "${_python_prefix}" CACHE PATH "" FORCE)
endif()

set(Python3_FIND_STRATEGY LOCATION CACHE STRING "" FORCE)
set(Python_FIND_STRATEGY  LOCATION CACHE STRING "" FORCE)
