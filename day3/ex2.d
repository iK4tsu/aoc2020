module ex2;

import std.algorithm : filter, map, reduce;
import std.array : array;
import std.stdio : File, writeln;
import std.range : takeOne, walkLength, popFront, enumerate, only, put, dropOne;

auto treesBy(size_t slope, size_t lineStep = 1)
{
    auto file = File("puzzle");
    auto range = file.byLine();
    size_t limit = range.front.length;
    size_t location;
    return range
            .dropOne()
            .enumerate(1)
            .filter!((tp) => tp.index%lineStep == 0)
            .map!((tp) => tp.value)
            .filter!((line) => line[location = ((location + slope) % limit)] == '#')
            .walkLength();
}

void main()
{
    auto arr = only(1, 3, 5, 7).map!treesBy.array;
    arr ~= treesBy(1, 2);
    arr.reduce!"a * b".writeln;
}
