module ex1;

import std.algorithm : each, equal, filter, splitter, map, sort;
import std.array : array, split;
import std.conv : to;
import std.range : empty, takeOne, front, walkLength;
import std.stdio : File, writeln;

enum Field { byr, iyr, eyr, hgt, hcl, ecl, pid, cid, }
struct Passport { string[] fields; }

auto isValidPassport(Passport passport, Field[] optional)
{
    import std.traits : EnumMembers;
    import std.algorithm : canFind;
    return [EnumMembers!Field].filter!(e => !optional.canFind(e))
            .map!(to!string).array.sort().equal(passport
                .fields.filter!(f => !optional.canFind(f.to!Field)).array.sort());
}

void main()
{
    auto fileRange = File("puzzle").byLine();
    Passport[] passports = [Passport()];

    foreach (line; fileRange)
    {
        if (!line.empty) {
            passports[$ - 1].fields ~= line.splitter(" ")
                .map!(arr => arr.splitter(":").front)
                .array.to!(string[]);
        }
        else passports ~= Passport();
    }

    passports.filter!(p => isValidPassport(p, [Field.cid])).walkLength().writeln;
}
