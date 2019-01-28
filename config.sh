# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    pytest -l --pyargs sklearn
}

function enable_openmp {
    # Install OpenMP
    brew install libomp
    export CC="clang -Xpreprocessor -fopenmp"
    export CFLAGS="$CFLAGS -I/usr/local/opt/libomp/include"
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/libomp/lib -lomp"
    export DYLD_LIBRARY_PATH=/usr/local/opt/libomp/lib
}

function disable_system_openmp {
    brew uninstall libomp
}