local FILENAME = string.gsub(debug.getinfo(1).short_src, "day4.tl", "input.txt")
local EXAMPLE_FILENAME = string.gsub(debug.getinfo(1).short_src, "day4.tl", "example-input.txt")
local BONUS_EXAMPLE_FILENAME = string.gsub(debug.getinfo(1).short_src, "day4.tl", "example-input-2.txt")

local fileUtils = require("fileUtils")

function doesFirstContainSecond(firstMin: string, firstMax: string, secondMin: string, secondMax: string): boolean
    return tonumber(firstMin) <= tonumber(secondMin) and tonumber(firstMax) >= tonumber(secondMax)
end

function getFullyOverlappingAssignmentCounts(filename: string): integer
    local overlappingCount: integer = 0
    fileUtils.doForFileLines(
        filename,
        function(currentLine: string)
            local _, _, firstMin, firstMax, secondMin, secondMax = string.find(currentLine, "(%d+)%-(%d+),(%d+)%-(%d+)")
            if(doesFirstContainSecond(firstMin, firstMax, secondMin, secondMax) or doesFirstContainSecond(secondMin, secondMax, firstMin, firstMax)) then
                overlappingCount = overlappingCount + 1
            end
        end
    )
    return overlappingCount
end

function testPuzzlePartOne()
    local expected = 2
    local actual = getFullyOverlappingAssignmentCounts(EXAMPLE_FILENAME)
    if(expected ~= actual) then error("Part one test failed. Expected: "..expected..", Actual: "..actual) end
end

function bonusTestPuzzlePartOne()
    local expected = 3
    local actual = getFullyOverlappingAssignmentCounts(BONUS_EXAMPLE_FILENAME)
    if(expected ~= actual) then error("Part one bonus test failed. Expected: "..expected..", Actual: "..actual) end
end

function solvePuzzlePartOne()
    print("The number of fully overlapping assignments is "..getFullyOverlappingAssignmentCounts(FILENAME))
end

function testPuzzlePartTwo()
    error("Not yet implemented!")
end

function bonusTestPuzzlePartTwo()
    error("Not yet implemented!")
end

function solvePuzzlePartTwo()
    error("Not yet implemented!")
end

function main()
    testPuzzlePartOne()
    bonusTestPuzzlePartOne()
    solvePuzzlePartOne()
    testPuzzlePartTwo()
    bonusTestPuzzlePartTwo()
    solvePuzzlePartTwo()
end

main()