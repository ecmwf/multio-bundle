# multio-bundle
Bundle to build [multio](https://github.com/ecmwf/multio)

## Usage

Below is a tested usage of this bundle

```shell
module load intel/2021.4.0 hpcx-openmpi/2.9.0 python3/3.10.10-01 fftw/3.3.9 aec/1.0.6 openblas/0.3.13 tflite/2.13.0

export CMAKE_PREFIX_PATH=$openblas_DIR:$CMAKE_PREFIX_PATH

./bundle create
./bundle build
build/install.sh --fast
```
