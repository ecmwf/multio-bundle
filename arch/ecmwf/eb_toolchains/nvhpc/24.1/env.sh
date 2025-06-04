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

# Unload all modules to be certain
[[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]] && module_purge

# Load modules
module use /perm/rdci/easybuild/installed_apps/modules/all

module_load NVHPC/24.1-CUDA-12.3.0
module_load ecbuild/3.7.0

export FC=nvfortran
export CC=nvc
export CXX=nvc++
#export BLAS_LIBRARIES=libopenblas.so
#export LAPACK_LIBRARIES=liblapack.so

# Don't load these modules if env.sh is used as part of the IFS runtime environment - only the modules above are required
if [[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]]; then
  module_load python3/3.10.10-01
  module_load FFTW/3.3.10-NVHPC-24.1-CUDA-12.3.0
  module_load netCDF-Fortran/4.5.2-NVHPC-24.1-CUDA-12.3.0
  module load netCDF/4.7.4-NVHPC-24.1-CUDA-12.3.0
  module_load netCDF-C++4/4.3.1-NVHPC-24.1-CUDA-12.3.0
  module_load HDF5/1.10.7-NVHPC-24.1-CUDA-12.3.0
  module_load Eigen/3.4.0-GCCcore-12.3.0
  module_load cmake/3.28.3
  module_load FCM/2019.09.0
  module_load aec
  module_load LAPACK/3.10.1-GCC-12.3.0
  module_load OpenBLAS/0.3.24-GCC-12.3.0
fi

# Setting required for bit reproducibility with Intel MKL:
export MKL_CBWR=AUTO,STRICT

# Record the RPATH in the executable
export LD_RUN_PATH=$LD_LIBRARY_PATH

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null


