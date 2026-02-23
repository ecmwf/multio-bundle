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
module_load intel/2023.2.0
module_load openmpi/4.1.5
module_load hdf5/1.14.1-2-openmpi
module_load pnetcdf/1.12.3-openmpi netcdf/c-4.9.2_fortran-4.6.1_cxx4-4.3.1_hdf5-1.14.1-2_pnetcdf-1.12.3-openmpi
module_load cmake/3.29.2
module_load aec/1.1.2
module_load mkl/2024.1
module_load python/3.10.15
module_load ucx/1.17.0        # Avoid runtime memory errors
module_load fftw/3.3.10-openmpi

export FC=`which mpifort`
export CC=`which mpicc`
export CXX=`which mpicxx`

export FFTW_HOME=/gpfs/apps/MN5/GPP/FFTW/3.3.10/INTEL/IMPI
export FFTW_ROOT=/gpfs/apps/MN5/GPP/FFTW/3.3.10/INTEL/IMPI
export FFTW_DIR=/gpfs/apps/MN5/GPP/FFTW/3.3.10/INTEL/IMPI
export fftw_DIR=/gpfs/apps/MN5/GPP/FFTW/3.3.10/INTEL/IMPI


# MKL envs
export MKL_DYNAMIC=FALSE # Using capital letters
export MKL_VERBOSE=${MKL_VERBOSE:-0} # if eq to 1, then each MKL func call as we go along will be output to ifs.out (stdout)

export MPIFC=`which mpifort`
export MPIF90=`which mpifort`
export MPIF77=`which mpifort`
export MPICC=`which mpicc`
export MPICXX=`which mpicxx`
# Record the RPATH in the executable
export LD_RUN_PATH=$LD_LIBRARY_PATH

export MPI_HOME=/gpfs/apps/MN5/GPP/OPENMPI/4.1.5/INTEL
export OMPI_HOME=/gpfs/apps/MN5/GPP/OPENMPI/4.1.5/INTEL
export MPI_ROOT=/gpfs/apps/MN5/GPP/OPENMPI/4.1.5/INTEL
export TBBMALLOC_DIR=/apps/GPP/ONEAPI/2023.2.0/tbb/2021.10.0/lib/intel64/gcc4.8
export TBBROOT=/apps/GPP/ONEAPI/2023.2.0/tbb/2021.10.0/
export OMP_WAIT_POLICY=ACTIVE

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null

