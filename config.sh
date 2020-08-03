# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    python -m pip upgrade pip
}

# XXX: test-data.xml is hard-coded because the JUNITXML env variable
# is not forwarded to the docker container environment.
function run_tests {
    # Runs tests on installed distribution from an empty directory
    python --version
    pytest -l --junitxml=test-data.xml --pyargs sklearn
}
