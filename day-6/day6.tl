local FILENAME = string.gsub(debug.getinfo(1).short_src, "day6.tl", "input.txt")
local EXAMPLE_FILENAME = string.gsub(debug.getinfo(1).short_src, "day6.tl", "example-input.txt")

local fileUtils = require("fileUtils")

function getCharAt(line: string, index: integer): string
    return string.sub(line, index, index)
end

function areAnyTwoTheSame(chars: {string}): boolean
    return chars[1] == chars[2] or chars[1] == chars[3] or chars[1] == chars[4]
        or chars[2] == chars[3] or chars[2] == chars[4]
        or chars[3] == chars[4]
end

function getFirstMarkerIndex(line: string): integer
    local chars = {getCharAt(line, 1), getCharAt(line, 2), getCharAt(line, 3), getCharAt(line, 4)}
    local currentIndex = 4
    while(areAnyTwoTheSame(chars)) do
        currentIndex = currentIndex + 1
        table.remove(chars, 1)
        table.insert(chars, getCharAt(line, currentIndex))
    end
    return currentIndex
end

function testPuzzlePartOne()
    local expectedArray = {7, 5, 6, 10, 11}
    fileUtils.doForFileLines(
        EXAMPLE_FILENAME,
        function(currentLine: string)
            local expected = table.remove(expectedArray, 1)
            local actual = getFirstMarkerIndex(currentLine)
            if(expected ~= actual) then error("Part one test failed. Expected: "..expected..", Actual: "..actual) end
        end
    )
end

function solvePuzzlePartOne()
    fileUtils.doForFileLines(
        FILENAME,
        function(currentLine: string)
            print("The first marker appears after character "..getFirstMarkerIndex(currentLine))
        end
    )
end

function testPuzzlePartTwo()
    error("Not yet implemented!")
end

function solvePuzzlePartTwo()
    error("Not yet implemented!")
end

function main()
    testPuzzlePartOne()
    solvePuzzlePartOne()
    testPuzzlePartTwo()
    solvePuzzlePartTwo()
end

main()