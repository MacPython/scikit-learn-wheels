.. image:: https://travis-ci.org/MacPython/scikit-learn-wheels.svg?branch=master
    :target: https://travis-ci.org/MacPython/scikit-learn-wheels
.. image:: https://ci.appveyor.com/api/projects/status/0vgnsltgf2ghhbr2/branch/master?svg=true
    :target: https://ci.appveyor.com/project/sklearn-wheels/scikit-learn-wheels

##########################
Scikit-learn wheel builder
##########################

Repository to build scikit-learn wheels.

The usual behavior of the repo is to build the wheel corresponding to the most
recent git tag (see `git-closest-tag
<https://github.com/MacPython/terryfy/blob/master/git-closest-tag>`_.

To build a particular commit instead:

* comment out the line ``global: LATEST_TAG=1`` in the ``.travis.yml`` file.

* Update scikit-learn submodule with version you want to build:

    * git submodule init
    * git submodule update
    * (cd scikit-learn && git pull && git checkout DESIRED_TAG)
    * git add scikit-learn

* Check minimum numpy versions to build against in ``.travis.yml`` file.  You
  need to build against the earliest numpy that scikit-learn is compatible with;
  see `forward, backward numpy compatibility
  <http://stackoverflow.com/questions/17709641/valueerror-numpy-dtype-has-the-wrong-size-try-recompiling/18369312#18369312>`_

The wheels get uploaded to a `rackspace container
<http://a365fff413fe338398b6-1c8a9b3114517dc5fe17b7c3f8c63a43.r19.cf2.rackcdn.com>`_
to which we (the MacPython organization) have the API key.  The API key is
encrypted to this specific repo in the ``.travis.yml`` file, so the upload
won't work for you from another account.  Either contact us via the github
issues for this repo to get set up, or use another upload service such as
github - see for example Jonathan Helmus' `sckit-image wheels builder
<https://github.com/jjhelmus/scikit-image-ci-wheel-builder>`_
