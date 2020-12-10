module ex1;

import std.algorithm : filter;
import std.stdio : File, writeln;
import std.range : takeOne, walkLength, popFront, dropOne;

void main()
{
    auto fileRange = File("puzzle").byLine();
    size_t mapLength = fileRange.front.length;
    size_t index;

    fileRange
        .dropOne()
        .filter!((line) => line[index = ((index + 3) % mapLength)] == '#')
        .walkLength()
        .writeln;
}
