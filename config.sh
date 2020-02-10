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
    export CPPFLAGS="$CPPFLAGS -Xpreprocessor -fopenmp"
    export CFLAGS="$CFLAGS -I/usr/local/opt/libomp/include"
    export CXXFLAGS="$CXXFLAGS -I/usr/local/opt/libomp/include"
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/libomp/lib -lomp"
    export DYLD_LIBRARY_PATH=/usr/local/opt/libomp/lib
}

function disable_system_openmp {
    brew uninstall libomp
}

function setup_test_venv {
    # Create a new empty venv dedicated to testing for non-Linux platforms. On
    # Linux the tests are run in a Docker container.
    if [ $(uname) != "Linux" ]; then
        source deactivate
        virtualenv --python=python test_venv
        source test_venv/bin/activate
        python --version # just to check
        pip install --upgrade pip wheel
        pip install $TEST_DEPENDS
    fi
}

function teardown_test_venv {
    if [ $(uname) != "Linux" ]; then
        source deactivate
        source venv/bin/activate
    fi
}
