# Source me to get the correct configure/build/run environment on a local
# macOS workstation using Homebrew's Open MPI / PRRTE stack.
#
# Usage:
#   source arch/local/macos/default/env.sh
#
# Rationale for the HWLOC_* exports below:
#
#   Homebrew's prrte 4.1.0 (used by open-mpi 5.0.9's mpiexec) has a
#   NULL-pointer bug in construct_range() when hwloc reports zero L3
#   caches -- which is the accurate topology for Apple Silicon (M-series)
#   Macs, since the P/E clusters share unified L2 caches and have no L3.
#
#   Reproducer:  mpiexec -n 2 /bin/echo hello
#                -> SIGSEGV in libprrte.3.dylib`construct_range
#                   from prte_hwloc_base_get_topo_signature
#
#   The workaround makes hwloc present a synthetic topology that
#   includes an L3 level, side-stepping the NULL path in PRRTE. Values
#   are chosen so the exposed core count matches this machine, which
#   keeps MPI slot-allocation heuristics accurate.
#
#   This can be removed once Homebrew ships a fixed prrte (>= 4.1.1 or
#   any release that resolves upstream PRRTE issue on missing L3 caches).

# Store tracing and disable
{ tracing_=${-//[^x]/}; set +x; } 2>/dev/null

# Number of physical cores on this machine, used to size the synthetic
# hwloc topology. Falls back to a sensible default if sysctl is missing.
_ncores="$( (sysctl -n hw.physicalcpu 2>/dev/null) || echo 10 )"

export HWLOC_THISSYSTEM=0
export HWLOC_SYNTHETIC="pack:1 l3cache:1 numa:1 l2cache:1 l1dcache:1 core:${_ncores} pu:1"

unset _ncores

# Restore tracing to stored setting
if [[ -n "$tracing_" ]]; then set -x; else set +x; fi
