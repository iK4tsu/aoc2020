module ex1;

import std;

void main()
{
    File("puzzle").byLine()
        .map!(str => str.split(" ").to!(string[]))
        .array.splitter([])
        .map!(arr => arr.join().join())
        .map!(arr => arr.array.sort.uniq.count)
        .sum.writeln;
}
