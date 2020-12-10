module day1.ex1;

import std.stdio : File, writeln;
import std.conv : to;
import std.algorithm : map;
import std.array : array;

void main() {
    auto file = File("puzzle");
    auto r = file.byLine.map!(to!size_t).array;

    foreach (i, size_t pivot; r[0 .. $ - 1])
    {
        foreach (size_t value; r[i + 1 .. $])
        {
            if (pivot + value == 2020) writeln(pivot*value);
        }
    }
}
