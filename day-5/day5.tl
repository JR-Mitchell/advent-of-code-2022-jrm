local FILENAME = string.gsub(debug.getinfo(1).short_src, "day5.tl", "input.txt")
local EXAMPLE_FILENAME = string.gsub(debug.getinfo(1).short_src, "day5.tl", "example-input.txt")

local fileUtils = require("fileUtils")

local STACK_ROW_PATTERN = " ?[ %[ ]([ A-Z ])[ %] ] ?"
local STACK_INDEX_PATTERN = " %d "
local MOVE_PATTERN = "move (%d+) from (%d) to (%d)"

function tointeger(input: string): integer
    return tonumber(input) as integer
end

function processStackRow(stacks: {{string}}, row: string)
    local rowCount: integer = 0
    for char in string.gmatch(row, STACK_ROW_PATTERN) do
        rowCount = rowCount + 1
        if(char ~= " ") then
            table.insert(stacks[rowCount], 1, char)
        end
    end
end

function executeMove(stacks: {{string}}, toMove: integer, fromIndex: integer, toIndex: integer)
    local fromColumn = stacks[fromIndex]
    local toColumn = stacks[toIndex]
    for _=1,toMove do
        table.insert(toColumn, table.remove(fromColumn))
    end
end

function executeMoveCommand(stacks: {{string}}, command: string)
    local _, _, toMoveStr, fromStr, toStr = string.find(command, MOVE_PATTERN)
    executeMove(stacks, tointeger(toMoveStr), tointeger(fromStr), tointeger(toStr))
end

function getFinalStacks(filename: string): {{string}}
    local stacks: {{string}} = {
        {}, {}, {},
        {}, {}, {},
        {}, {}, {}
    }
    local counter: integer = 0
    fileUtils.doForFileLines(
        filename,
        function(currentLine: string)
            if(counter == 2) then
                -- Movement command
                executeMoveCommand(stacks, currentLine)
            elseif(counter == 1) then
                -- Blank line after stack indices
                counter = 2    
            elseif(string.find(currentLine, STACK_INDEX_PATTERN)) then
                -- Stack indices
                counter = 1
            else
                -- A stack row
                processStackRow(stacks, currentLine)
            end
        end
    )
    return stacks
end

function getTopStackString(filename: string): string
    local finalStacks = getFinalStacks(filename)
    local outputString = ""
    for _, stack in ipairs(finalStacks) do
        local char = table.remove(stack)
        if(char ~= nil) then
            outputString = outputString .. char
        end
    end
    return outputString
end

function testPuzzlePartOne()
    local expected = "CMZ"
    local actual = getTopStackString(EXAMPLE_FILENAME)
    if(expected ~= actual) then error("Part one test failed. Expected: "..expected..", Actual: "..actual) end
end

function solvePuzzlePartOne()
    print("The top stack crates are:\n"..getTopStackString(FILENAME))
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