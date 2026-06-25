# Copied from ecbuild. We set these manually here, as ecbuild (3.12.0) doesn't
# have compiler flags for IntelLLVM.

set( CMAKE_C_FLAGS_RELEASE        "-O3 -DNDEBUG")
set( CMAKE_C_FLAGS_BIT            "-O2 -DNDEBUG")
set( CMAKE_C_FLAGS_DEBUG          "-O0 -g -traceback")
set( CMAKE_C_FLAGS_PRODUCTION     "-O3 -g")
set( CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g -DNDEBUG")

set( CMAKE_CXX_FLAGS_RELEASE        "-O3 -DNDEBUG")
set( CMAKE_CXX_FLAGS_BIT            "-O2 -DNDEBUG")
set( CMAKE_CXX_FLAGS_DEBUG          "-O0 -g -traceback")
set( CMAKE_CXX_FLAGS_PRODUCTION     "-O3 -g")
set( CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g -DNDEBUG")

