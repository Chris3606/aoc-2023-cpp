"""Helper to generate a new day template."""

import fnmatch
import os
import shutil
import sys

def findReplace(directory: str, find: str, replace: str, filePattern: str) -> None:
    for path, _, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filePattern):
            filepath = os.path.join(path, filename)
            with open(filepath) as f:
                s = f.read()
            s = s.replace(find, replace)
            with open(filepath, "w") as f:
                f.write(s)


def main() -> None:
    """Create a new day based on template."""
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} DAY_NUMBER")
        exit(-1)

    script_dir = os.path.dirname(os.path.realpath(__file__))

    day = f"day{sys.argv[1]:>02}"
    day_path = os.path.join(script_dir, day)
    if os.path.exists(day_path):
        print(f"Path for day already exists at: {day_path}.  Remove old path and try again.")
        exit(-2)
    
    # Copy new day
    shutil.copytree(os.path.join(script_dir, "day00"), day_path)

    # Change day references
    findReplace(day_path, "day00", day, "*")

    # Add CMake subdirectory command to ensure new day is compiled
    subdir_command = f"add_subdirectory({day})"
    with open(os.path.join(script_dir, "CMakeLists.txt"), "r", encoding="utf-8") as cmake:
        contains_subdir = subdir_command in cmake.read()
    
    if not contains_subdir:
        with open(os.path.join(script_dir, "CMakeLists.txt"), "a", encoding="utf-8") as cmake:
            cmake.write("\n" + subdir_command)

if __name__ == "__main__":
    main()
