####################################################################
# COMMON FLAGS
####################################################################

# NB: These are never used by ifs-source

set(ECBUILD_Fortran_FLAGS "-fpe0")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -convert big_endian")
set(ECBUILD_Fortran_FLAGS "${ECBUILD_Fortran_FLAGS} -assume noold_maxminloc")

set(ECBUILD_Fortran_FLAGS_BIT "-g -O2 -traceback")
set(ECBUILD_C_FLAGS_BIT "-g -O2")
set(ECBUILD_CXX_FLAGS_BIT "-g -O2")
