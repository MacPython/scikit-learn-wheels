import os
import os.path as op
import shutil
from glob import glob
import textwrap

VCOMP140_SRC_PATH = "C:\\Windows\System32\\vcomp140.dll"
TARGET_FOLDER_GLOB_PATTERN = "build/lib.*/sklearn"


def make_distributor_init(dirname):
    '''
    Create a _distributor_init.py file for OpenBlas
    '''
    with open(op.join(dirname, '_distributor_init.py'), 'wt') as f:
        f.write(textwrap.dedent("""
            '''
            Helper to preload windows dlls to prevent "dll not found" errors.
            Once a DLL is preloaded, its namespace is made available to any
            subsequent DLL. This file originated in the scikit-learn-wheels
            github repo, and is created as part of the scripts that build the
            wheel.
            '''
            import os
            import os.path as op
            from ctypes import WinDLL
            from glob import glob
            if os.name == 'nt':
                # convention for storing / loading the DLL from
                # sklearn/.libs/, if present
                DLL_filenames = []
                basedir = op.dirname(__file__)
                libs_dir = op.abspath(op.join(basedir, '.libs'))

                # Pre-load the DLL and warn if more than 1 is found.
                for filename in glob(op.join(libs_dir,'vcomp*dll')):
                    WinDLL(op.abspath(filename))
                    DLL_filenames.append(filename)
                if len(DLL_filenames) > 1:
                    import warnings
                    warnings.warn("loaded more than 1 DLL from .libs:\\n%s" %
                              "\\n".join(DLL_filenames),
                              stacklevel=1)
    """))


def main():
    # TODO: use threadpoolctl to dynamically locate the right vcomp dll
    # instead? This would require first in-place building scikit-learn
    # to make it "importable".
    if not os.path.exists(VCOMP140_SRC_PATH):
        raise ValueError("Could not find %r" % VCOMP140_SRC_PATH)

    if not os.path.isdir("build"):
        raise RuntimeError("Could not find ./build/ folder. "
                           "Run 'python setup.py build' first")
    target_folders = glob(TARGET_FOLDER_GLOB_PATTERN)
    if len(target_folders) == 0:
        raise RuntimeError("Could not find folder matching '%s'"
                           % TARGET_FOLDER_GLOB_PATTERN)
    if len(target_folders) > 1:
        raise RuntimeError("Found too many target folders: %r"
                           % target_folders)
    target_folder = op.join(target_folders[0], ".libs")

    # create the "sklearn/.libs" subfolder
    if not op.exists(target_folder):
        os.mkdir(target_folder)

    print("Copying %r to %r" % (VCOMP140_SRC_PATH, target_folder))
    shutil.copy2(VCOMP140_SRC_PATH, target_folder)

    # Generate the _distributor_init file in the source tree.
    print("Generating the sklearn/_distributor_init.py file")
    make_distributor_init("sklearn")


if __name__ == "__main__":
    main()
