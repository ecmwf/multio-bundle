# Source me to get the correct configure/build/run environment

# Store tracing and disable (module is *way* too verbose)
{ tracing_=${-//[^x]/}; set +x; } 2>/dev/null

module_load() {
  echo "+ module load $1"
  if [ "${2:-""}" == "ECBUNDLE_CONFIGURE_ONLY" ]; then
    if [ -n "${ECBUNDLE_CONFIGURE:-""}" ]; then
      module load $1
    else
      echo " WARNING: Module $1 not loaded (only during configuration)"
    fi
  else
    module load $1
  fi
}
module_unload() {
  echo "+ module unload $1"
  module unload $1
}

# Unload to be certain
module_purge() {
  echo "+ module purge"
  module --force purge

  # Reload the basic LUMI (system settings) module.
  module_load init-lumi
}

# Unload all modules to be certain
[[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]] && module_purge


# Load modules
module_load LUMI/23.03
module_load partition/G
module_load cpeCray/23.03
module_load cray-mpich/8.1.25
module_load libaec/1.0.6-cpeCray-23.03

if [[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]]; then
  module_load Eigen/3.4
  module_load Boost/1.81.0-cpeCray-23.03
  module_load ncurses/6.4-cpeCray-23.03
  module_load buildtools/23.03
  module_load cray-python/3.9.13.1 ECBUNDLE_CONFIGURE_ONLY
fi

module_load craype-network-ofi
module_load craype-accel-amd-gfx90a
module_load rocm/5.2.3
module_load cray-dsmml/0.2.2

### Handling of "magic" cray modules
# 1) Load the cray modules
module_load cray-libsci/23.02.1.1
module_load cray-fftw/3.3.10.3
module_load cray-hdf5/1.12.2.3
module_load cray-netcdf/4.9.0.3
# 2) Store variables to locate the packages
export CRAY_LIBSCI=${CRAY_LIBSCI_PREFIX_DIR}/lib/libsci_cray.so
_FFTW_ROOT=${FFTW_ROOT}
_HDF5_ROOT=${CRAY_HDF5_PREFIX}
_NETCDF_ROOT=${CRAY_NETCDF_PREFIX}
# 3) Unload the cray modules in reverse order, removing all the magic
module_unload cray-netcdf
module_unload cray-hdf5
module_unload cray-fftw
module_unload cray-libsci
# 4) Define variables that CMake introspects
export FFTW_ROOT=${_FFTW_ROOT}
export HDF5_ROOT=${_HDF5_ROOT}
export NETCDF_ROOT=${_NETCDF_ROOT}

# Export environment variable3s
export MPI_HOME=${MPICH_DIR}
export CMAKE_TOOLCHAIN_FILE=$PWD/toolchain.cmake
export CC=cc
export CXX=CC
export FC=ftn
export HIPCXX=$(hipconfig --hipclangpath)/clang++
export CRAY_ADD_RPATH=yes
export LIBSCI_ARCH_OVERRIDE=broadwell
  # This is required to work around SIGSEGV in ectrans' SGEMM calls, which
  # occur when "rome" or "milan" are used (backtrace points to openblas_sgemm__naples)

### Print some exported variables
echo "+ export FFTW_ROOT=${FFTW_ROOT}"
echo "+ export HDF5_ROOT=${HDF5_ROOT}"
echo "+ export NETCDF_ROOT=${NETCDF_ROOT}"
echo "+ export MPI_HOME=${MPI_HOME}"
echo "+ export CMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}"
echo "+ export CC=${CC}"
echo "+ export CXX=${CXX}"
echo "+ export FC=${FC}"
echo "+ export HIPCXX=${HIPCXX}"
echo "+ export CRAY_ADD_RPATH=${CRAY_ADD_RPATH}"
echo "+ export LIBSCI_ARCH_OVERRIDE=${LIBSCI_ARCH_OVERRIDE}"

module list 2>&1

set -x
ulimit -S -s unlimited

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null

