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
