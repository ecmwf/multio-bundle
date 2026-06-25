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
module_load prgenv/nvidia
module_load nvidia/22.11
module_load intel-mkl/19.0.5
module_load python3/3.11.10-01

# Don't load these modules if env.sh is used as part of the IFS runtime environment - only the modules above are required
if [[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]]; then
  module_load fftw/3.3.9
  module_load netcdf4/4.7.4
  module_load hdf5/1.10.6
  module_load eigen/3.4.0
  module_load qhull/8.1-alpha1
  module_load cmake/3.20.2
  module_load ninja/1.10.0
  module_load fcm/2019.05.0
  module_load aec/1.0.4
fi

export FC=nvfortran
export CC=nvc
export CXX=nvc++

# use MPI provided by nvhpc installation
export MPI_HOME=/usr/local/apps/nvidia/22.11/Linux_x86_64/22.11/comm_libs/openmpi/openmpi-3.1.5/
export OPENMPI_VERSION=3.1.5

# Setting required for bit reproducibility with Intel MKL:
export MKL_CBWR=AUTO,STRICT

# Record the RPATH in the executable
export LD_RUN_PATH=$LD_LIBRARY_PATH

Eigen3_DIR=/perm/nawd/software/eigen-3.4.0/share/eigen3/cmake

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null

export ECBUILD_TOOLCHAIN="./toolchain.cmake"
