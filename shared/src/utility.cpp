#include "utility.hpp"
#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>
namespace fs = std::filesystem;

namespace aoc
{
    std::string read_file(const std::string &file_path)
    {
        std::cout << "Path: " << file_path << std::endl;
        std::ifstream t(file_path);
        if (!t.is_open())
            throw std::exception("Failed to open file!");

        std::stringstream buffer;
        buffer << t.rdbuf();

        return buffer.str();
    }

    std::string input_path(const std::string &input_file_name)
    {
        // File path to the source directory
        fs::path dir(__FILE__);

        // Relative path from utility source directory to file in inputs/ folder
        return (dir / fs::path("..") / fs::path("..") / fs::path("inputs") /
                fs::path(input_file_name))
            .string();
    }
} // namespace aoc