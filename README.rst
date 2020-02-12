TODO: add Azure Pipelines badge here

##########################
Scikit-learn wheel builder
##########################

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
