module ex1;

import std.stdio : File, writeln;
import std.algorithm;
import std.format : format, formattedRead;
import std.range : walkLength;

void main()
{
    File("puzzle");
        .byLine
        .filter!((line) {
            int low, high;
            char letter;
            string password;
            line.formattedRead!"%s-%s %s: %s"(low, high, letter, password);

            auto result = password.count(letter);

            return low <= result && result <= high;
    }).walkLength().writeln;
}
