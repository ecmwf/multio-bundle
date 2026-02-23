# Source me to get the correct configure/build/run environment

# Store tracing and disable (module is *way* too verbose)
{ tracing_=${-//[^x]/}; set +x; } 2>/dev/null

module_load() {
  echo "+ module load $*"
  module load $*
}
module_unload() {
  echo "+ module unload $*"
  module unload $*
}
module_purge() {
  echo "+ module purge"
  module purge
}

module_purge
module_load oneapi/2023.2.0
module_load impi/2021.10.0
module_load fftw/3.3.10
module_load hdf5/1.14.1-2
module_load pnetcdf/1.12.3 netcdf/c-4.9.2_fortran-4.6.1_cxx4-4.3.1_hdf5-1.14.1-2_pnetcdf-1.12.3
module_load cmake/3.29.2
module_load aec/1.1.2
module_load python/3.12.1
module_load tbb/2021.10.0
module load ucx/1.16.0        


export FC=ifort
export CC=icc
export CXX=icpc

# MKL envs
export MKL_DYNAMIC=FALSE # Using capital letters
export MKL_VERBOSE=${MKL_VERBOSE:-0} # if eq to 1, then each MKL func call as we go along will be output to ifs.out (stdout)

# IMPI envs
export I_MPI_FABRICS=${I_MPI_FABRICS:-"shm:ofi"}
export I_MPI_OFI_PROVIDER=${I_MPI_OFI_PROVIDER:-mlx}
export FI_PROVIDER=${FI_PROVIDER:-"mlx"}
export I_MPI_PLATFORM=spr
export MPIFC=`which mpiifort`
export MPIF90=`which mpiifort`
export MPIF77=`which mpiifort`
export MPICC=`which mpiicc`
export MPICXX=`which mpiicpc`
# Record the RPATH in the executable
export LD_RUN_PATH=$LD_LIBRARY_PATH
export TBBMALLOC_DIR=/apps/GPP/ONEAPI/2023.2.0/tbb/2021.10.0/lib/intel64/gcc4.8
export TBB_DIR=$TBBMALLOC_DIR
export FESOM_PLATFORM_STRATEGY="mn5-gpp"
export MPICH_OFI_STARTUP_CONNECT=${MPICH_OFI_STARTUP_CONNECT:-"1"}
export MPICH_ABORT_ON_ERROR=${MPICH_ABORT_ON_ERROR:-"1"}

export OMP_WAIT_POLICY=ACTIVE

export MPI_HOME=$MPI_ROOT
# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null

