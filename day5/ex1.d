module ex1;

import std;

void main()
{
    File("puzzle").byLine()
        .map!(str => str.map!((c) => ['F', 'L'].canFind(c) ? '0' : '1').to!string)
        .map!(str => tuple(str[0..7].to!int(2), str[7..$].to!int(2)))
        .map!(t => t[0] * 8 + t[1])
        .maxElement().writeln();
}
