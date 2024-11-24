#include "solution.hpp"
#include "utility.hpp"
#include <filesystem>
#include <iostream>
namespace fs = std::filesystem;

int main([[maybe_unused]] int argc, [[maybe_unused]] const char *argv[])
{
    try
    {
        auto input = aoc::parse_input(aoc::input_path("day00_sample.txt"));

        auto p1_solution = aoc::part1(input);
        std::cout << "Part 1: " << p1_solution << std::endl;

        auto p2_solution = aoc::part2(input);
        std::cout << "Part 2: " << p2_solution << std::endl;
    }
    catch (std::exception &exc)
    {
        std::cerr << "Unhandled exception: " << exc.what() << std::endl;
        return -1;
    }


    return 0;
}