local FILENAME = string.gsub(debug.getinfo(1).short_src, "day6.tl", "input.txt")
local EXAMPLE_FILENAME = string.gsub(debug.getinfo(1).short_src, "day6.tl", "example-input.txt")

local fileUtils = require("fileUtils")

local PACKET_MARKER_LENGTH = 4
local MESSAGE_MARKER_LENGTH = 14

function getCharAt(line: string, index: integer): string
    return string.sub(line, index, index)
end

function getInitialChars(line: string, count: integer): {string}
    local chars: {string} = {}
    for i=1,count do
        table.insert(chars, getCharAt(line, i))
    end
    return chars
end

function areAnyTwoTheSamePacket(chars: {string}): boolean
    return chars[1] == chars[2] or chars[1] == chars[3] or chars[1] == chars[4]
        or chars[2] == chars[3] or chars[2] == chars[4]
        or chars[3] == chars[4]
end

function areAnyTwoTheSameMessage(chars: {string}): boolean
    -- Brain needs coffee
    return chars[1] == chars[2] or chars[1] == chars[3] or chars[1] == chars[4] or chars[1] == chars[5] or chars[1] == chars[6] or chars[1] == chars[7] or chars[1] == chars[8] or chars[1] == chars[9] or chars[1] == chars[10] or chars[1] == chars[11] or chars[1] == chars[12] or chars[1] == chars[13] or chars[1] == chars[14]
        or chars[2] == chars[3] or chars[2] == chars[4] or chars[2] == chars[5] or chars[2] == chars[6] or chars[2] == chars[7] or chars[2] == chars[8] or chars[2] == chars[9] or chars[2] == chars[10] or chars[2] == chars[11] or chars[2] == chars[12] or chars[2] == chars[13] or chars[2] == chars[14]
        or chars[3] == chars[4] or chars[3] == chars[5] or chars[3] == chars[6] or chars[3] == chars[7] or chars[3] == chars[8] or chars[3] == chars[9] or chars[3] == chars[10] or chars[3] == chars[11] or chars[3] == chars[12] or chars[3] == chars[13] or chars[3] == chars[14]
        or chars[4] == chars[5] or chars[4] == chars[6] or chars[4] == chars[7] or chars[4] == chars[8] or chars[4] == chars[9] or chars[4] == chars[10] or chars[4] == chars[11] or chars[4] == chars[12] or chars[4] == chars[13] or chars[4] == chars[14]
        or chars[5] == chars[6] or chars[5] == chars[7] or chars[5] == chars[8] or chars[5] == chars[9] or chars[5] == chars[10] or chars[5] == chars[11] or chars[5] == chars[12] or chars[5] == chars[13] or chars[5] == chars[14]
        or chars[6] == chars[7] or chars[6] == chars[8] or chars[6] == chars[9] or chars[6] == chars[10] or chars[6] == chars[11] or chars[6] == chars[12] or chars[6] == chars[13] or chars[6] == chars[14]
        or chars[7] == chars[8] or chars[7] == chars[9] or chars[7] == chars[10] or chars[7] == chars[11] or chars[7] == chars[12] or chars[7] == chars[13] or chars[7] == chars[14]
        or chars[8] == chars[9] or chars[8] == chars[10] or chars[8] == chars[11] or chars[8] == chars[12] or chars[8] == chars[13] or chars[8] == chars[14]
        or chars[9] == chars[10] or chars[9] == chars[11] or chars[9] == chars[12] or chars[9] == chars[13] or chars[9] == chars[14]
        or chars[10] == chars[11] or chars[10] == chars[12] or chars[10] == chars[13] or chars[10] == chars[14]
        or chars[11] == chars[12] or chars[11] == chars[13] or chars[11] == chars[14]
        or chars[12] == chars[13] or chars[12] == chars[14]
        or chars[13] == chars[14]
end

function areAnyTwoTheSame(chars: {string}): boolean
    if(#chars == MESSAGE_MARKER_LENGTH) then
        return areAnyTwoTheSameMessage(chars)
    elseif(#chars == PACKET_MARKER_LENGTH) then
        return areAnyTwoTheSamePacket(chars)
    else
        error("Not yet implemented for a list of length "..#chars)
    end
end

function getFirstMarkerIndex(line: string, distinctCount: integer): integer
    local chars = getInitialChars(line, distinctCount)
    local currentIndex = distinctCount
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
            local actual = getFirstMarkerIndex(currentLine, PACKET_MARKER_LENGTH)
            if(expected ~= actual) then error("Part one test failed. Expected: "..expected..", Actual: "..actual) end
        end
    )
end

function solvePuzzlePartOne()
    fileUtils.doForFileLines(
        FILENAME,
        function(currentLine: string)
            print("The first start-of-packet marker appears after character "..getFirstMarkerIndex(currentLine, PACKET_MARKER_LENGTH))
        end
    )
end

function testPuzzlePartTwo()
    local expectedArray = {19, 23, 23, 29, 26}
    fileUtils.doForFileLines(
        EXAMPLE_FILENAME,
        function(currentLine: string)
            local expected = table.remove(expectedArray, 1)
            local actual = getFirstMarkerIndex(currentLine, MESSAGE_MARKER_LENGTH)
            if(expected ~= actual) then error("Part two test failed. Expected: "..expected..", Actual: "..actual) end
        end
    )
end

function solvePuzzlePartTwo()
    fileUtils.doForFileLines(
        FILENAME,
        function(currentLine: string)
            print("The first start-of-message marker appears after character "..getFirstMarkerIndex(currentLine, MESSAGE_MARKER_LENGTH))
        end
    )
end

function main()
    testPuzzlePartOne()
    solvePuzzlePartOne()
    testPuzzlePartTwo()
    solvePuzzlePartTwo()
end

main()