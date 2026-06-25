set( CMAKE_POSITION_INDEPENDENT_CODE ON CACHE STRING "" )

####################################################################
# HIP
####################################################################

set(CMAKE_HIP_ARCHITECTURES gfx90a)

####################################################################
# OpenMP
####################################################################

set( OpenMP_C_FLAGS           "-fopenmp" )
set( OpenMP_CXX_FLAGS         "-fopenmp" )
set( OpenMP_Fortran_FLAGS     "-fopenmp" )
set( OpenMP_C_LIB_NAMES       "crayacc_amdgpu;craymp" )
set( OpenMP_CXX_LIB_NAMES     "crayacc_amdgpu;craymp" )
set( OpenMP_Fortran_LIB_NAMES "crayacc_amdgpu;craymp" )
set( OpenMP_craymp_LIBRARY    "craymp" )
set( OpenMP_crayacc_amdgpu_LIBRARY "crayacc_amdgpu" )


####################################################################
# OpenACC
####################################################################

set( OpenACC_C_FLAGS       "-hacc" )
set( OpenACC_CXX_FLAGS     "-hacc" )
set( OpenACC_Fortran_FLAGS "-hacc -hacc_model=auto_async_kernel:no_fast_addr:deep_copy" )

####################################################################
# General Flags (add to default)
####################################################################

set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -M2260")

###################################################################
# Libraries
###################################################################

set( BLAS_LIBRARIES   "$ENV{CRAY_LIBSCI}" CACHE STRING "BLAS_LIBRARIES" FORCE )
set( LAPACK_LIBRARIES "$ENV{CRAY_LIBSCI}" CACHE STRING "LAPACK_LIBRARIES" FORCE )
