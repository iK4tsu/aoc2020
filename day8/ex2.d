module ex2;

import std;

void main()
{
    size_t curIndex, accumulator, nextswap;
    auto range  = "puzzle"
        .slurp!(string, "instruction", int, "value")("%s %s")
        .map!(t => t ~ tuple!("visited")(false));

    auto instructions = range.array;

    scope(exit) accumulator.writeln;

    auto loop = (Tuple!(string, "instruction", int, "value", bool, "visited")[] range) {
        while (!range[curIndex].visited)
        {
            range[curIndex].visited = true;
            accumulator += range[curIndex].instruction.equal("acc")
                ? range[curIndex].value : 0;
            curIndex += range[curIndex].instruction.equal("jmp")
                ? range[curIndex].value : 1;
            if (curIndex >= range.length) break;
        }
        return curIndex >= range.length;
    };

    while (!loop(instructions))
    {
        curIndex = accumulator = 0;
        instructions = range.array;
        nextswap += instructions[nextswap .. $].countUntil!(t => ["jmp", "nop"].canFind(t.instruction));
        instructions[nextswap].instruction = instructions[nextswap].instruction.equal("jmp")
            ? "nop" : "jmp";
        nextswap++;
    }
}
