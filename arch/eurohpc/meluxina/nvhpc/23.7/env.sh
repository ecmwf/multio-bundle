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

module purge

module_load env/release/2023.1

module_load GCCcore/12.3.0
module_load NVHPC/23.7-CUDA-12.2.0
module_load CUDA/12.2.0
module_load OpenMPI/4.1.5-NVHPC-23.7-CUDA-12.2.0
module_load flex/2.6.4
module_load Bison/3.8.2
module_load Perl/5.36.1-GCCcore-12.3.0
module_load zlib/1.2.13-GCCcore-12.3.0
module_load CMake/3.26.3-GCCcore-12.3.0
module_load M4/1.4.19
module_load Boost/1.82.0-GCC-12.3.0
module_load Python/3.11.3-GCCcore-12.3.0
module_load PyYAML/6.0-GCCcore-12.3.0

export CC=nvc
export CXX=nvc++
export F77=nvfortran
export FC=nvfortran
export F90=nvfortran

#export FFTW_ROOT=/home/users/u100221/project/nvhpc-install
export HDF5_ROOT=/project/home/p200177/ifs_dependencies/gpu/nv/23.7-0/hdf5/install
export NETCDF_ROOT=/project/home/p200177/ifs_dependencies/gpu/nv/23.7-0/netcdf/install

export LIBAEC_DIR=/project/home/p200177/ifs_dependencies/cpu/gcc/12.3.0/libaec/install
# export LZ4_ROOT=/project/home/p200177/ifs_dependencies/cpu/gcc/12.3.0/lz4/install/usr/local

# Increase stack size to maximum
ulimit -S -s unlimited

set -x

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null
