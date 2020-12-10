module ex1;

import std;

void main()
{
    File("puzzle")
        .byLine
        .map!(to!size_t)
        .chain([0])
        .array
        .sort
        .slide(2)
        .map!(fold!"b-a")
        .chain([3])
        .filter!"a != 2"
        .array
        .sort
        .group
        .map!"a[1]"
        .fold!"a*b"
        .writeln;
}
