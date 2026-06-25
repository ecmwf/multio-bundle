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

module_load gcc/12.2.0
module_load openmpi/4.1.6--gcc--12.2.0-cuda-12.2
module_load openblas/0.3.26--gcc--12.2.0

# Don't load these modules if env.sh is used as part of the IFS runtime environment - only the modules above are required
if [[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]]; then

  module_load fftw/3.3.10--gcc--12.2.0-spack0.22 
  module_load python/3.11.7
  module_load hdf5/1.14.3--gcc--12.2.0-spack0.22 
  module_load netcdf-fortran/4.6.1--gcc--12.2.0-spack0.22
  module_load ninja/1.11.1
  module_load cmake/3.27.9 

  module use /leonardo/pub/userexternal/lanton00/spack-0.22.2-06/modules

  module_load boost/1.85.0--gcc--12.2.0--yauqyqv
  module_load eigen/3.4.0--gcc--12.2.0--q3wzb2j
  module_load bison/3.7.4--gcc--12.2.0--vud347p

  # hack for aec 1.1.3
  export AEC_ROOT=/leonardo/pub/userexternal/lanton00/libaec/1.1.3
  # the module libaec loaded implicitly changes LD_LIBRARY_PATH
  export LD_LIBRARY_PATH=$AEC_ROOT/lib64:$LD_LIBRARY_PATH
fi

module list --all

$FC --version

# Record the RPATH in the executable
export LD_RUN_PATH=$LD_LIBRARY_PATH

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null
