#pragma once
#include <string>
#include <vector>

namespace aoc
{
    using TInput = std::vector<int>;

    TInput parse_input(std::istream &input);

    std::string part1(const TInput &input);
    std::string part2(const TInput &input);
} // namespace aoc