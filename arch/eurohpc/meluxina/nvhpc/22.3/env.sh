# (C) Copyright 1988- ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation
# nor does it submit to any jurisdiction.

# Source me to get the correct configure/build/run environment

# Store tracing and disable (module is *way* too verbose)
{ tracing_=${-//[^x]/}; set +x; } 2>/dev/null

module_load() {
  echo "+ module load $1"
  module load $1
}
module_unload() {
  echo "+ module unload $1"
  module unload $1
}

# Unload all modules to be certain
module_unload ParaStationMPI
module_unload NVHPC
module_unload gompi
module_unload HDF5
module_unload CMake

# Load modules
module use /apps/USE/easybuild/staging/2022.1/modules/all

module_load NVHPC/22.3

module_load ParaStationMPI/5.4.11-1-GCC-10.3.0-CUDA-11.3.1
# module_load gompi/2021a
# module_load HPCX/2.9.0
# module_load OpenMPI/4.1.1-GCC-10.3.0
module_load flex/2.6.4
module_load Bison/3.8.2
module_load Perl/5.34.0-GCCcore-11.2.0
module_load zlib/1.2.11
module_load CMake/3.21.1
module_load Boost/1.78.0-GCC-11.2.0
module_load Python/3.9.6-GCCcore-11.2.0

# module_load netCDF-Fortran/4.5.3-gompi-2021a
# module_load HDF5/1.12.1-gompi-2021a
# module_load HDF5/1.10.7-gompi-2021a

export CC=nvc
export CXX=nvc++
export F77=nvfortran
export FC=nvfortran
export F90=nvfortran

# export HDF5_ROOT=/home/users/u100221/hdf5-nvhpc

export FFTW_ROOT=/home/users/u100221/project/nvhpc-install
export HDF5_ROOT=/home/users/u100221/project/nvhpc-install
export NETCDF_ROOT=/home/users/u100221/project/nvhpc-install

# Increase stack size to maximum
ulimit -S -s unlimited

set -x

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null

export ECBUILD_TOOLCHAIN="./toolchain.cmake"
