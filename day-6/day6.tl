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

function indexOfFirstMatching(chars: {string}): integer
    for i=#chars,2,-1 do
        local thisChar = chars[i]
        for j=i-1,1,-1 do
            if(thisChar == chars[j]) then
                return j
            end
        end
    end
    return nil
end

function getFirstMarkerIndex(line: string, distinctCount: integer): integer
    local chars = getInitialChars(line, distinctCount)
    local currentIndex = distinctCount
    local matchIndex = indexOfFirstMatching(chars)
    while(matchIndex ~= nil) do
        for _=1,matchIndex do
            currentIndex = currentIndex + 1
            table.remove(chars, 1)
            table.insert(chars, getCharAt(line, currentIndex))
        end
        matchIndex = indexOfFirstMatching(chars)
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