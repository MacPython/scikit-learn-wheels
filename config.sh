# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    :
}

# XXX: test-data.xml is hard-coded because the JUNITXML env variable
# is not forwarded to the docker container environment.
function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    pytest -l --junitxml=test-data.xml --pyargs sklearn
}


function install_wheel {
    # Install test dependencies and built wheel
    #
    # Pass any input flags to pip install steps
    #
    # Depends on:
    #     WHEEL_SDIR  (optional, default "wheelhouse")
    #     TEST_DEPENDS  (optional, default "")
    #     MANYLINUX_URL (optional, default "") (via pip_opts function)
    #
    # XXX:
    # Override install_wheel from common_utils.sh to force upgrade pip
    # prior to installing test dependencies in the docker environment.
    python -m pip install --upgrade pip
    local wheelhouse=$(abspath ${WHEEL_SDIR:-wheelhouse})
    if [ -n "$TEST_DEPENDS" ]; then
        while read TEST_DEPENDENCY; do
            pip install $(pip_opts) $@ $TEST_DEPENDENCY
        done <<< "$TEST_DEPENDS"
    fi
    # Install compatible wheel
    pip install $(pip_opts) $@ \
        $(python $MULTIBUILD_DIR/supported_wheels.py $wheelhouse/*.whl)
}
