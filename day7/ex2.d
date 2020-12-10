module ex2;

import std;

void main()
{
    Tuple!(int, string)[][string] bags;
    auto recursive (string key) {
        if (key !in bags) return 0;

        int res;
        bags[key].each!(bag => res += bag[0] + bag[0] * recursive(bag[1]));
        return res;
    }

    File("puzzle").byLine()
        .map!(str => str.substitute(" bags contain ", "|", " bag, ", "|", " bags.", "", " bags, ", "|", " bag.", "").to!string.split('|'))
        .each!(arr => bags[arr[0]] = arr.dropOne.map!(str => str.findSplit(" ")).map!(arr => arr[0].isNumeric ? tuple(arr[0].to!int, arr[2]) : tuple(0, "")).array);

        recursive("shiny gold").writeln;
}
