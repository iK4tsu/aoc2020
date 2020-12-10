module ex1;

import std;

void main()
{
    string[][string] bags;
    auto recursive (string key) {
        foreach (i, ref bag; bags[key])
        {
            if (bag.equal("no other")) return false;
            else if (bag.equal("shiny gold")) return true;
            else if (bag in bags && recursive(bag)) return true;
        }
        return false;
    }

    File("puzzle").byLine()
        .map!(str => str.substitute(" bags contain ", "|", " bag, ", "|", " bags.", "", " bags, ", "|", " bag.", "").to!string.split('|'))
        .each!(arr => bags[arr.front] = arr.dropOne.map!(str => str.findSplit(" ").array.back).array);

        bags.keys
            .filter!(key => !key.equal("shiny gold"))
            .filter!(key => recursive(key))
            .count.writeln;
}
