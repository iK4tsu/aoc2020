module ex2;

import std;

void main()
{
    immutable tribonacci = (size_t n) =>
        recurrence!("a[n-1] + a[n-2] + a[n-3]")(0, 1, 1)
            .take(n+2)
            .tail(1)
            .front;

    File("puzzle")
        .byLine
        .map!(to!size_t)
        .chain([0])
        .array
        .sort
        .slide(2)
        .map!(fold!"b-a")
        .chain([3])
        .array
        .group
        .filter!"a[0] == 1"
        .map!"a[1]"
        .filter!"a != 1"
        .map!tribonacci
        .fold!((a, b) => a.to!BigInt*b)
        .writeln;
}
