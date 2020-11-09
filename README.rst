.. image:: https://dev.azure.com/scikit-learn/scikit-learn/_apis/build/status/MacPython.scikit-learn-wheels?branchName=master
    :target: https://dev.azure.com/scikit-learn/scikit-learn/_build/latest?definitionId=2&branchName=master


##########################
Scikit-learn wheel builder
##########################


**DEPRECATION NOTICE:** the scikit-learn wheel-building infrastructure
has been `moved to the main repo 
<https://github.com/scikit-learn/scikit-learn/blob/master/.github/workflows/wheels.yml>`_.
It now uses the `cibuildwheel <https://github.com/joerick/cibuildwheel>`_
system instead of the `multibuild <https://github.com/matthew-brett/multibuild/>`_
system.

Repository to build scikit-learn wheels.

Edit `azure/windows.yml` and `azure/posix.yml` to change the `BUILD_COMMIT`
environment variable to set the name of the git tag to build, commit and push
(to master).

Azure Pipelines should automatically build and test that version on Windows,
Linux and OSX for various versions of Python (both 32 bit and 64 bit).

If the tests pass, the resulting wheels should show up on:

  - https://anaconda.org/scikit-learn-wheels-staging for release wheels staging;
  - https://anaconda.org/scipy-wheels-nightly for nightly builds.

The following tool can be useful to download all the wheels for a specific
release:

  https://github.com/ogrisel/wheelhouse-uploader

and then use `twine` to publish all the wheels along with the locally built
source tarball of the release all at once to PyPI.
