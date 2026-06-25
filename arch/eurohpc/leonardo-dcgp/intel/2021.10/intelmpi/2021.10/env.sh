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
  module purge >/dev/null 2>&1 || true
}

# Unload all modules to be certain
[[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]] && module_purge

module load profile/candidate

module_load intel-oneapi-compilers-classic/2021.10.0
module_load intel-oneapi-mkl/2024.0.0--intel-oneapi-mpi--2021.12.1
module_load intel-oneapi-mpi/2021.12.1                                                 
module_load intel-oneapi-tbb/2021.12.0


# Don't load these modules if env.sh is used as part of the IFS runtime environment - only the modules above are required
if [[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]]; then

  module_load binutils/2.42  # ldd that can handle compress debug info?

  module_load python/3.11.7
  module_load hdf5/1.14.3--intel-oneapi-mpi--2021.12.1--oneapi--2024.1.0
  module_load netcdf-fortran/4.6.1--intel-oneapi-mpi--2021.12.1--oneapi--2024.1.0

  module use /leonardo/pub/userexternal/breuter0/spack-0.21.0-5.2/modules

  module_load eigen/3.4.0--intel--2021.10.0
  module_load ninja/1.11.1
  module_load boost/1.83.0--intel--2021.10.0
  module_load bison/3.8.2--intel--2021.10.0-4npegmr
  module_load cmake/3.27.7--intel--2021.10.0-wkzaqu4

  # hack for libaec with local install (grib needs a newer version than the one provided by the system)
  export AEC_ROOT=/leonardo/pub/userexternal/lanton00/libaec/1.1.3
  # the module libaec loaded implicitly changes LD_LIBRARY_PATH
  export LD_LIBRARY_PATH=$AEC_ROOT/lib64:$LD_LIBRARY_PATH

  # fftw location for cmake; no fftw module available for intel compiler but is required by ectrans
  export FFTW_ROOT=/leonardo/pub/userexternal/lanton00/fftw/3.3.10_ice_lake
fi

module list --all

export FC=ifort
export CC=icc
export CXX=icpc

$FC --version

# Setting required for bit reproducibility with Intel MKL:
export MKL_CBWR=AUTO,STRICT


# Record the RPATH in the executable
export LD_RUN_PATH=$LD_LIBRARY_PATH

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null
