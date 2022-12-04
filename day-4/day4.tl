local FILENAME = string.gsub(debug.getinfo(1).short_src, "day4.tl", "input.txt")
local EXAMPLE_FILENAME = string.gsub(debug.getinfo(1).short_src, "day4.tl", "example-input.txt")
local BONUS_EXAMPLE_FILENAME = string.gsub(debug.getinfo(1).short_src, "day4.tl", "example-input-2.txt")

local fileUtils = require("fileUtils")

function doesFirstContainSecond(firstMin: number, firstMax: number, secondMin: number, secondMax: number): boolean
    return firstMin <= secondMin and firstMax >= secondMax
end

function doesOneContainOther(firstMin: number, firstMax: number, secondMin: number, secondMax: number): boolean
    return doesFirstContainSecond(firstMin, firstMax, secondMin, secondMax) or doesFirstContainSecond(secondMin, secondMax, firstMin, firstMax)
end

function doRangesOverlap(firstMin: number, firstMax: number, secondMin: number, secondMax: number): boolean
    return firstMin <= secondMax and secondMin <= firstMax
end

-- Predicate is a method for determining whether to count an assignment
-- It takes the minimum of the first assignment, the maximum of the first assignment, the minimum of the second assignment and the maximum of the second assignment as params
function getAssignmentCounts(filename: string, predicate: (function(number, number, number, number): boolean)): integer
    local overlappingCount: integer = 0
    fileUtils.doForFileLines(
        filename,
        function(currentLine: string)
            local _, _, firstMinStr, firstMaxStr, secondMinStr, secondMaxStr = string.find(currentLine, "(%d+)%-(%d+),(%d+)%-(%d+)")
            local firstMin, firstMax, secondMin, secondMax = tonumber(firstMinStr), tonumber(firstMaxStr), tonumber(secondMinStr), tonumber(secondMaxStr)
            if(predicate(firstMin, firstMax, secondMin, secondMax)) then
                overlappingCount = overlappingCount + 1
            end
        end
    )
    return overlappingCount
end

function getFullyOverlappingAssignmentCounts(filename: string): integer
    return getAssignmentCounts(filename, doesOneContainOther)
end

function getOverlappingAssignmentCounts(filename: string): integer
    return getAssignmentCounts(filename, doRangesOverlap)
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
    local expected = 4
    local actual = getOverlappingAssignmentCounts(EXAMPLE_FILENAME)
    if(expected ~= actual) then error("Part two test failed. Expected: "..expected..", Actual: "..actual) end
end

function bonusTestPuzzlePartTwo()
    local expected = 4
    local actual = getOverlappingAssignmentCounts(BONUS_EXAMPLE_FILENAME)
    if(expected ~= actual) then error("Part two bonus test failed. Expected: "..expected..", Actual: "..actual) end
end

function solvePuzzlePartTwo()
    print("The number of overlapping assignments is "..getOverlappingAssignmentCounts(FILENAME))
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