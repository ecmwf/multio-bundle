####################################################################
# COMMON FLAGS
####################################################################

# NB: These are never used by ifs-source

set(ECBUILD_Fortran_FLAGS "-fconvert=big-endian")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -ffree-line-length-none")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -fbacktrace")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -ffpe-trap=invalid,overflow,zero")

set(ECBUILD_Fortran_FLAGS_BIT "-g -O2")
set(ECBUILD_C_FLAGS_BIT "-g -O2")
set(ECBUILD_CXX_FLAGS_BIT "-g -O2")

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
