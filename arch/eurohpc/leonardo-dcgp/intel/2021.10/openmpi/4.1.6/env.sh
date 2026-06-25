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

echo "not updated yet, please use intel mpi" ; exit 1

# Unload all modules to be certain
[[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]] && module_purge

# Load system-provided modules first
module_load intel-oneapi-compilers/2023.2.1
module_load intel-oneapi-mkl/2023.2.0
module_load intel-oneapi-tbb/2021.10.0

# Don't load these modules if env.sh is used as part of the IFS runtime environment
if [[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]]; then
  module_load ninja/1.11.1
  module_load python/3.10.8--gcc--8.5.0
fi

# Now load manually Spack-installed dependencies:
# spack install openmpi @4.1.6 %intel@2021.10.0 fabrics=cma,knem,ucx ~pmi ~cuda # (xpmem fabric failed to build, pmi headers not found)
# spack install hdf5 @1.12.2 %intel@2021.10.0 ^openmpi@4.1.6                    # Older version because default HDF5 1.14.3 has a SIGFPE bug
# spack install netcdf-fortran @4.6.1 %intel@2021.10.0 ^openmpi@4.1.6 ^hdf5@1.12.2
# spack install fftw %intel@2021.10.0 ^openmpi@4.1.6
# spack install eigen @3.4.0 %intel@2021.10.0
# spack install libaec %intel@2021.10.0
# spack install boost +date_time+filesystem+system+program_options %intel@2021.10.0
# spack install bison @3.8.2 %intel@2021.10.0

module use /leonardo/pub/userexternal/breuter0/spack-0.21.0-5.2/modules
module_load openmpi/4.1.6--intel--2021.10.0

# Don't load these modules if env.sh is used as part of the IFS runtime environment - only the modules above are required
if [[ ${IFS_RUNTIME_ENV:-unset} == "unset" ]]; then
  module_load hdf5/1.12.2--openmpi--4.1.6--intel--2021.10.0
  module_load netcdf-fortran/4.6.1--openmpi--4.1.6--intel--2021.10.0
  export NETCDF_ROOT=$NETCDF_FORTRAN_HOME
  module_load fftw/3.3.10--openmpi--4.1.6--intel--2021.10.0
  module_load eigen/3.4.0--intel--2021.10.0
  module_load libaec/1.0.6--intel--2021.10.0-pjyh6ep
  module_load boost/1.83.0--intel--2021.10.0
  module_load bison/3.8.2--intel--2021.10.0-4npegmr
  module_load cmake/3.27.7--intel--2021.10.0-wkzaqu4

  # FCM:
  export PATH=/leonardo/pub/userexternal/lanton00/Tools/fcm-2021.05.0/bin/:$PATH
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
