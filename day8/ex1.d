module ex1;

import std;

void main()
{
    size_t curIndex, accumulator;
    auto instructions = "puzzle"
        .slurp!(string, "instruction", int, "value")("%s %s")
        .map!(t => t ~ tuple!("visited")(false))
        .array;

    scope(exit) accumulator.writeln;
    while (!instructions[curIndex].visited)
    {
        instructions[curIndex].visited = true;
        accumulator += instructions[curIndex].instruction.equal("acc")
            ? instructions[curIndex].value : 0;
        curIndex += instructions[curIndex].instruction.equal("jmp")
            ? instructions[curIndex].value : 1;
    }
}
