# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    if [ -n "$IS_OSX" ]; then
        # Compile our own numpy from source (using Accelerate)
        pip install numpy==$NP_BUILD_DEP --no-use-wheel
    fi
}

function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    nosetests --exe -v sklearn
}
