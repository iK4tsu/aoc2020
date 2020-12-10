module ex2;

import std.stdio : File, writeln;
import std.algorithm;
import std.format : format, formattedRead;
import std.range : walkLength, chain;

void main()
{
    File("input-puzzle");
        .byLine
        .filter!((line) {
            int idx1, idx2;
            char letter;
            string password;
            line.formattedRead!"%s-%s %s: %s"(idx1, idx2, letter, password);

            return [password[idx1-1], password[idx2-1]].count(letter) == 1;
    }).walkLength().writeln;
}
