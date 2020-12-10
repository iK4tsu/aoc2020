module ex1;

import std;

void main()
{
    auto range = File("puzzle").byLineCopy().map!(to!size_t).array;

    immutable value = (size_t preamble) {
        immutable isSumOfLast = (typeof(range.front)[] range, size_t value) {
            return range
                .cartesianProduct(range)
                .filter!(t => t[1] != t[0])
                .map!(reduce!"a+b")
                .canFind(value);
        };

        return range
            .drop(preamble)
            .enumerate(0)
            .filter!(t => !isSumOfLast(range[t.index .. t.index + preamble], t.value))
            .map!(t => t.value).front;
    }(25);

    auto getContinuousRange = (typeof(range.front)[] range, size_t value) {
        typeof(range.front)[] res; size_t sum;
        return range.each!((x) {
            sum += x; res ~= x;
            return sum == value ? No.each : Yes.each;
        }) == No.each ? res : [];
    };

    range
        .enumerate(0)
        .filter!(t => !getContinuousRange(range[t.index .. $], value).empty)
        .map!(t => getContinuousRange(range[t.index .. $], value))
        .map!(arr => [arr.minElement, arr.maxElement])
        .front.sum.writeln;
}
