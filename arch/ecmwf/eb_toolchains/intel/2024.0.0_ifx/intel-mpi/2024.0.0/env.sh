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

module_purge
module_load prgenv/intel
module_unload intel
module_load intel-compilers/2024.0.0
module_load impi/2021.11.0-intel-compilers-2024.0.0
module_load intel-mkl/19.0.5


export CC=icx
export CXX=icpx
export F90=ifx
export FC=ifx
export F77=ifx
export OMPI_CC=icx
export OMPI_CXX=icpx
export OMPI_F90=ifx
export OMPI_FC=ifx
export I_MPI_CC=icx
export I_MPI_CXX=icpx
export I_MPI_F90=ifx
export I_MPI_FC=ifx

# Don't load these modules if env.sh is used as part of the IFS runtime environment - only the modules above are required
if [[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]]; then
  module_load CMake/3.27.6-GCCcore-13.2.0
  module_load python3/3.10.10-01
  module_load FFTW/3.3.10-iimpi-2024.0
  module_load netCDF-Fortran/4.5.2-iimpi-2024.0
  module_load HDF5/1.10.7-iimpi-2024.0
  module_load Eigen/3.4.0-GCCcore-13.2.0
  module_load ninja/1.10.0
  module_load fcm/2019.05.0
  module_load aec/1.0.6
fi

# Setting required for bit reproducibility with Intel MKL:
export MKL_CBWR=AUTO,STRICT

# Record the RPATH in the executable
export LD_RUN_PATH=$LD_LIBRARY_PATH

#export CMAKE_INTERPROCEDURAL_OPTIMIZATION

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null

