#include "day.hpp"
#include <exception>
#include <filesystem>
#include <sstream>
namespace fs = std::filesystem;

namespace aoc
{
    std::string _get_input_path(const std::string &input_file_name)
    {
        // File path to the source directory
        fs::path dir(__FILE__);

        // Relative path from utility source directory to file in inputs/ folder
        return (dir / fs::path("..") / fs::path("..") / fs::path("inputs") /
                fs::path(input_file_name))
            .string();
    }

    DayBase::DayBase(int day) : m_day(day)
    {
    }

    void DayBase::solve(bool sample)
    {
        // Get file name for day based on inputted day and whether to use sample.
        std::stringstream ss;
        ss << std::setw(2) << std::setfill('0') << m_day;

        auto day_file_name =
            "day" + ss.str() + (sample ? "_sample" : "") + ".txt";

        // Go from file name to path based on where the "inputs/" folder is
        auto input_path = _get_input_path(day_file_name);

        // Open file
        std::ifstream input_file(input_path);
        if (!input_file.is_open())
            throw std::runtime_error(
                "Failed to open input file: " + input_path + ".");

        // Solve
        parse_and_process(input_file);
        input_file.close();
    }
} // namespace aoc