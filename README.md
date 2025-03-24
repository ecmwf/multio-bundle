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

Please do check the following commands for all available options

    ./multio-bundle create --help
    ./multio-bundle build  --help
