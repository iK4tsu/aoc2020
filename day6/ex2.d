module ex2;

import std;

void main()
{
    File("puzzle").byLine()
        .map!(str => str.split(" ").to!(string[]))
        .array.splitter([])
        .map!(arr => tuple(arr.count, arr.join().join()))
        .map!(t => tuple(t[0], t[1].array.sort().group()))
        .map!(t => t[1].filter!(g => g[1] == t[0].to!size_t))
        .filter!(arr => !arr.empty)
        .map!(arr => arr.count)
        .sum.writeln;
}
