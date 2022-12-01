local params = {...}

local record ElfStats
    elfIndex: integer
    caloriesSum: number
end

-- Puzzle says delimiting lines are "blank" not "empty", so strip them
function isBlank(line: string): boolean
    return line == nil or #string.gsub(line, " ", "") == 0
end

-- Inserts the elf into the list so that the list is ordered in descending calories sum
function addElfInOrderToElfList(elfList: {ElfStats}, elf: ElfStats)
    -- Remember - lua, and therefore teal, is 1-indexed
    local insertIndex = 1
    while (insertIndex <= #elfList) do
        if elfList[insertIndex].caloriesSum <= elf.caloriesSum then
            break
        end
        insertIndex = insertIndex + 1
    end
    table.insert(elfList, insertIndex, elf)
end

-- Generates the list of elves, ordered in descending calories sum
function findOrderedElfList(filename: string): {ElfStats}
    local infile = io.open(filename, "r")

    local currentLine: string = infile:read()
    local currentElf: ElfStats = {
        elfIndex = 1,
        caloriesSum = 0
    }
    local elfList: {ElfStats} = { }

    while (currentLine) do
        local strippedLine = currentLine.gsub(currentLine, " ", "")
        if(isBlank(currentLine)) then
            addElfInOrderToElfList(elfList, currentElf)
            currentElf = {
                elfIndex = currentElf.elfIndex + 1,
                caloriesSum = 0
            }
        else
            -- Assuming here that input is well-formatted, so that it can easily be parsed
            currentElf.caloriesSum = currentElf.caloriesSum + tonumber(strippedLine)
        end
        currentLine = infile:read()
    end
    -- Account for the end elf
    if(currentElf.caloriesSum > 0) then
        addElfInOrderToElfList(elfList, currentElf)
    end
    infile:close()
    return elfList
end

-- Finds the stats of the elf with most calories
function solvePuzzlePartOne(filename: string): ElfStats
    return findOrderedElfList(filename)[1]
end

-- Finds the total calories carried by the top three elves
function solvePuzzlePartTwo(filename: string): number
    local elfList = findOrderedElfList(filename)
    local topThreeSum: number = 0
    for i=1,3 do
        local currentElf = elfList[i]
        if (currentElf ~= nil) then
            topThreeSum = topThreeSum + currentElf.caloriesSum
        end
    end
    return topThreeSum
end

function main()
    local filename = params[1] or "input.txt"

    -- Puzzle part one
    local largestCountElf = solvePuzzlePartOne(filename)
    if(largestCountElf == nil) then
        print("No elves found!")
    else
        print("The "..largestCountElf.elfIndex.."th elf has the most calories")
        print("This elf has "..(largestCountElf.caloriesSum).." calories")
    end

    -- Puzzle part two
    print("The sum of calories carried by the top three elves is "..solvePuzzlePartTwo(filename))
end

main()