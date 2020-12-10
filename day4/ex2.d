module ex2;

import std.algorithm : each, equal, filter, splitter, map, sort, clamp;
import std.array : array, split;
import std.conv : to;
import std.range : back, empty, takeOne, front, walkLength;
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

auto isValidYear(string value, int min, int max)
{
    import std.string : isNumeric;
    return value.length == 4 && value.isNumeric && clamp(value.to!int, min, max) == value.to!int;
}

auto isValidByr(string value)
{
    return isValidYear(value, 1920, 2002);
}

auto isValidIyr(string value)
{
    return isValidYear(value, 2010, 2020);
}

auto isValidEyr(string value)
{
    return isValidYear(value, 2020, 2030);
}

auto isValidHgt(string value)
{
    if (value.length < 2) return false;
    else
    {
        import std.algorithm : equal;
        import std.string : isNumeric;
        string[] vsplit = [value[0 .. $ - 2], value[$ - 2 .. $]];

        return vsplit[0].isNumeric && (
                (vsplit[1].equal("cm") && clamp(vsplit[0].to!int, 150, 193) == vsplit[0].to!int)
            || (vsplit[1].equal("in") && clamp(vsplit[0].to!int, 59, 76) == vsplit[0].to!int)
        );
    }
}

auto isValidHcl(string value)
{
    import std.ascii : isDigit, toLower;
    import std.typecons : Yes, No;
    if (value.length > 7 || value[0] != '#') return false;
    else
    {
        return value[1 .. $].each!((c) {
            if (c.isDigit || (c.toLower() >= 'a' && c.toLower() <= 'f'))
                return Yes.each;
            else
                return No.each;
        }) == Yes.each;
    }
}

auto isValidEcl(string value)
{
    import std.algorithm : canFind;
    return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].canFind(value);
}

auto isValidPid(string value)
{
    import std.string : isNumeric;
    return value.isNumeric && value.length == 9;
}

auto isValidField(Field field, string value)
{
    final switch (field)
    {
        case Field.byr: return isValidByr(value);
        case Field.cid: return true;
        case Field.ecl: return isValidEcl(value);
        case Field.eyr: return isValidEyr(value);
        case Field.hcl: return isValidHcl(value);
        case Field.hgt: return isValidHgt(value);
        case Field.iyr: return isValidIyr(value);
        case Field.pid: return isValidPid(value);
    }
}

void main()
{
    auto fileRange = File("puzzle").byLine();
    Passport[] passports = [Passport()];

    foreach (line; fileRange)
    {
        if (!line.empty) {
            passports[$ - 1].fields ~= line
                .splitter(" ")
                .filter!((arr) => isValidField(arr.splitter(":").front.to!Field, arr.split(":").back))
                .map!(arr => arr.splitter(":").front)
                .array.to!(string[]);
        }
        else passports ~= Passport();
    }

    passports.filter!(p => isValidPassport(p, [Field.cid])).walkLength().writeln;
}
