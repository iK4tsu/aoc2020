module ex2;

import std;

void main()
{
    auto seats = File("puzzle").byLine()
        .map!(str => str.map!((c) => ['F', 'L'].canFind(c) ? '0' : '1').to!string)
        .map!(str => tuple(str[0..7].to!int(2), str[7..$].to!int(2)))
        .filter!(t => ![0, 127].canFind(t[0]))
        .map!(t => t[0] * 8 + t[1])
        .array().sort();

    seats.enumerate(seats.front)
        .until!((t) => t.index != t.value)(No.openRight)
        .array.back.index.writeln;
}
