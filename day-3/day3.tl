local FILENAME = string.gsub(debug.getinfo(1).short_src, "day3.tl", "input.txt")
local EXAMPLE_FILENAME = string.gsub(debug.getinfo(1).short_src, "day3.tl", "example-input.txt")

local fileUtils = require("fileUtils")

function getPriority(character: string): integer
    local lowerCaseA = string.byte("a")
    local byteValue = string.byte(character)
    if(byteValue >= lowerCaseA) then
        return byteValue - lowerCaseA + 1
    else
        return byteValue - string.byte("A") + 27
    end
end

function getSumOfDuplicatePriorities(filename: string): integer
    local prioritySum: integer = 0
    fileUtils.doForFileLines(
        filename,
        function(currentLine: string)
            local firstCompartment = string.sub(currentLine, 1, #currentLine // 2)
            local secondCompartment = string.sub(currentLine, #currentLine // 2 + 1, -1)
            local _, _, duplicateChar = string.find(secondCompartment, "(["..firstCompartment.."])")
            prioritySum = prioritySum + getPriority(duplicateChar)
        end
    )
    return prioritySum
end

function getGroupBadge(firstBackpack: string, secondBackpack: string, thirdBackpack: string): string
    local sharedBetweenFirstTwo = ""
    for character in string.gmatch(secondBackpack, "["..firstBackpack.."]") do
        sharedBetweenFirstTwo = sharedBetweenFirstTwo .. character
    end
    local _, _, badge = string.find(thirdBackpack, "(["..sharedBetweenFirstTwo.."])")
    return badge
end

function getSumOfBadgePriorities(filename: string): integer
    local groupIndex: integer = 1
    local groupLines: {string} = {nil, nil, nil}
    local prioritySum: integer = 0
    fileUtils.doForFileLines(
        filename,
        function(currentLine: string)
            groupLines[groupIndex] = currentLine
            groupIndex = groupIndex + 1
            if(groupIndex == 4) then
                groupIndex = 1
                prioritySum = prioritySum + getPriority(getGroupBadge(table.unpack(groupLines)))
            end
        end
    )
    return prioritySum
end

function testPuzzlePartOne()
    local expected = 157
    local actual = getSumOfDuplicatePriorities(EXAMPLE_FILENAME)
    if(expected ~= actual) then error("Part one test failed. Expected: "..expected..", Actual: "..actual) end
end

function solvePuzzlePartOne()
    print("The sum of priorities of duplicate items is "..getSumOfDuplicatePriorities(FILENAME))
end

function testPuzzlePartTwo()
    local expected = 70
    local actual = getSumOfBadgePriorities(EXAMPLE_FILENAME)
    if(expected ~= actual) then error("Part two test failed. Expected: "..expected..", Actual: "..actual) end
end

function solvePuzzlePartTwo()
    print("The sum of priorities of group badges is "..getSumOfBadgePriorities(FILENAME))
end

function main()
    testPuzzlePartOne()
    solvePuzzlePartOne()
    testPuzzlePartTwo()
    solvePuzzlePartTwo()
end

main()