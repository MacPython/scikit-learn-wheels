
 function setup_compiler {
    # Install OpenMP support on macOS
    if [ $(uname) == "Darwin" ]; then
        brew install libomp
        export CPPFLAGS="$CPPFLAGS -Xpreprocessor -fopenmp"
        export CFLAGS="$CFLAGS -I/usr/local/opt/libomp/include"
        export CXXFLAGS="$CXXFLAGS -I/usr/local/opt/libomp/include"
        export LDFLAGS="$LDFLAGS -L/usr/local/opt/libomp/lib -lomp"
        export DYLD_LIBRARY_PATH=/usr/local/opt/libomp/lib
    fi
}

function teardown_compiler {
    if [ $(uname) == "Darwin" ]; then
        brew uninstall libomp
    fi
}

function setup_test_venv {
    # Create a new empty venv dedicated to testing for non-Linux platforms. On
    # Linux the tests are run in a Docker container.
    if [ $(uname) != "Linux" ]; then
        deactivate || echo ""
        python -m venv test_venv
        if [ $(uname) == "Darwin" ]; then
            source test_venv/bin/activate
        else
            source test_venv/Scripts/activate
        fi
        pip install --upgrade pip wheel
        pip install $TEST_DEPENDS
    fi
}

function teardown_test_venv {
    if [ $(uname) != "Linux" ]; then
        deactivate || echo ""
        source venv/bin/activate
    fi
}
