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

# Central location for easybuild-based software installations.
module use /leonardo_work/DestE_IFS_25/models/ifs/software/easybuild_install/modules/all

# Load Intel MPI.
module_load intel/2023b

# Set path to the PMI library. Otherwise MPI doesn't work. In the centrally-installed
# Intel-MPI module, this variable is automatically set but not in the easybuild-built
# modules.
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so

# Don't load these modules if env.sh is used as part of the IFS runtime environment - only the modules above are required
if [[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]]; then

  # Use LLVM C and C++ compiler but still the "old" ifort compiler.
  # Main reson for this is that OpenMP isn't found when using the old C/C++
  # compilers (icc/icpc).
  export CC=icx
  export CXX=icpx
  export F90=ifort
  export FC=ifort
  export F77=ifort

  export I_MPI_CC=icx
  export I_MPI_CXX=icpx
  export I_MPI_F90=ifort
  export I_MPI_FC=ifort

  module_load CMake/3.27.6-GCCcore-13.2.0
  module_load Python/3.11.5-GCCcore-13.2.0
  module_load FFTW/3.3.10-intel-compilers-2023.2.1
  module_load HDF5/1.14.3-iimpi-2023b
  module_load netCDF-Fortran/4.6.1-iimpi-2023b
 
  module_load libaec/1.1.3-GCCcore-13.2.0
  module_load Eigen/3.4.0-GCCcore-13.2.0
  module_load Ninja/1.11.1-GCCcore-13.2.0
  module_load Boost/1.83.0-intel-compilers-2023.2.1
  module_load Bison/3.8.2-GCCcore-13.2.0
fi

module list --all

# Load additional toolchain file to set the correct compilation flags (Intel's
# LLVM-based compilers are not yet supported by ecBuild).
export CMAKE_TOOLCHAIN_FILE=$PWD/toolchain.cmake

# Setting required for bit reproducibility with Intel MKL:
export MKL_CBWR=AUTO,STRICT

# Record the RPATH in the executable
export LD_RUN_PATH=$LD_LIBRARY_PATH

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null
