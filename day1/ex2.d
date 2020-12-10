module day1.ex2;

import std.stdio : File, writeln;
import std.conv : to;
import std.algorithm : map;
import std.array : array;
import std.format : format;

void main() {
    auto file = File("puzzle");
    auto r = file.byLine.map!(to!size_t).array;

    foreach (i, size_t pivot; r[0 .. $ - 2])
    {
        foreach (j, size_t midlevalue; r[i + 1 .. $ - 1])
        {
            foreach (size_t value; r[i + j + 1 .. $])
                if (pivot + midlevalue + value == 2020)
                    writeln(format!"%s"(pivot*midlevalue*value));
        }
    }
}
