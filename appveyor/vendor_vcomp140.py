import os
import shutil
from glob import glob

VCOMP140_SRC_PATH = "C:\\Windows\System32\\vcomp140.dll"
TARGET_FOLDER_GLOB_PATTERN = "build/lib.*/sklearn/utils"


def main():
    # TODO: use threadpoolctl to locate vcomp140.dll instead?
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
    target_folder = target_folders[0]

    print("Copying %r to %r" % (VCOMP140_SRC_PATH, target_folder))
    shutil.copy2(VCOMP140_SRC_PATH, target_folder)


if __name__ == "__main__":
    main()
