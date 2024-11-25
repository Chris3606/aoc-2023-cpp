#include "solution.hpp"
#include <iostream>

namespace aoc
{
    TInput parse_input([[maybe_unused]] std::istream &input)
    {
        TInput result;
        std::string line;
        while (std::getline(input, line))
            result.push_back(line);

        return result;
    }

    std::string part1([[maybe_unused]] const TInput &input)
    {
        return "Not yet solved.";
    }

    std::string part2([[maybe_unused]] const TInput &input)
    {
        return "Not yet solved.";
    }
} // namespace aoc