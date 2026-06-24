multio-bundle
==========

Build-system based on ecbuild, which bundles all ECMWF-dependencies
inside one large project, saving the extra work to make sure all
dependencies are in place.

Basic instructions
------------------

    # Clone this bundle
    git clone -b <THIS_BRANCH> git@github.com:ecmwf/multio-bundle.git
    cd multio-bundle

    # Download and create bundle
    ./multio-bundle create

    # Configure and compile bundle
    ./multio-bundle build

Partial matches are accepted, e.g.

    ./multio-bundle bui
    ./multio-bundle cr

The `./multio-bundle create` step only updates the sources on the first execution when the repositories are cloned. This is an example of how to update existing sources and building with a typical set of specific options:

    # Download/update bundle sources
    ./multio-bundle create --update

    # Build with architecture file, ninja, clean build, install, and parallel jobs
    ./multio-bundle build --arch ./arch/ecmwf/hpc2020/ --ninja --clean --install --build-type RelWithDebInfo -j 32

Please do check the following commands for all available options

    ./multio-bundle create --help
    ./multio-bundle build  --help

## License

[Apache License 2.0](LICENSE) In applying this licence, ECMWF does not waive the privileges and immunities granted to it by virtue of its status as an intergovernmental organisation nor does it submit to any jurisdiction.
