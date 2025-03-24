set( CMAKE_POSITION_INDEPENDENT_CODE ON CACHE STRING "" )

####################################################################
# OpenMP
####################################################################

set( OpenMP_C_FLAGS           "-fopenmp" )
set( OpenMP_CXX_FLAGS         "-fopenmp" )
set( OpenMP_Fortran_FLAGS     "-fopenmp" )
set( OpenMP_C_LIB_NAMES       "craymp" )
set( OpenMP_CXX_LIB_NAMES     "craymp" )
set( OpenMP_Fortran_LIB_NAMES "craymp" )
set( OpenMP_craymp_LIBRARY    "craymp" )

####################################################################
# General Flags (add to default)
####################################################################

set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS}")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-implicit-function-declaration")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--no-relax -lhugetlbfs")
###################################################################
# Libraries
###################################################################

set( BLAS_LIBRARIES   "$ENV{CRAY_LIBSCI}" CACHE STRING "BLAS_LIBRARIES" FORCE )
set( LAPACK_LIBRARIES "$ENV{CRAY_LIBSCI}" CACHE STRING "LAPACK_LIBRARIES" FORCE )
