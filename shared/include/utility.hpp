#pragma once
#include <string>

namespace aoc
{
    /**
     * @brief Reads the contents of a file into a string.
     * 
     * @param file - An input stream reading from the file.
     * @return std::string - A string representing the contents of the file.
     */
    std::string read_file(std::ifstream &file);

    /**
     * @brief Gets a valid file path to the given file name in the inputs/ directory.
     * 
     * @details This does not work generically; it uses __FILE__ to find the path, which means that the binary
     * will have a path hardcoded to the developer's file structure.  However, it's sufficient enough for AoC
     * and otherwise cross-platform.
     * 
     * @param input_file_name - The name of the input file to get the path for.
     * @return std::string - A string representing the file path.
     */
    std::string input_path(const std::string &input_file_name);
} // namespace aoc