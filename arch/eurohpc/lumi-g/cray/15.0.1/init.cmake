set( ENABLE_GPU_STATIC ON CACHE BOOL "We need to compile ectrans with static libraries for GPU" )
# this works around undefined references to :
# /opt/cray/pe/cce/15.0.1/binutils/x86_64/x86_64-pc-linux-gnu/bin/ld: ../lib/libtrans_gpu_sp.so: undefined reference to `.omp_offloading.img_size.cray_amdgcn-amd-amdhsa'
# /opt/cray/pe/cce/15.0.1/binutils/x86_64/x86_64-pc-linux-gnu/bin/ld: ../lib/libtrans_gpu_sp.so: undefined reference to `.omp_offloading.img_start.cray_amdgcn-amd-amdhsa'
# /opt/cray/pe/cce/15.0.1/binutils/x86_64/x86_64-pc-linux-gnu/bin/ld: ../lib/libtrans_gpu_sp.so: undefined reference to `.omp_offloading.img_cache.cray_amdgcn-amd-amdhsa'

