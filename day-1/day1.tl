local params = {...}

-- Puzzle says delimiting lines are "blank" not "empty", so strip them
function isBlank(line: string): boolean
    return line == nil or #string.gsub(line, " ", "") == 0
end

-- Inserts the elf into the list so that the list is ordered in descending calories sum
function addElfInOrderToElfList(elfCaloriesList: {number}, caloriesCount: number)
    -- Remember - lua, and therefore teal, is 1-indexed
    local insertIndex = 1
    while (insertIndex <= #elfCaloriesList) do
        if elfCaloriesList[insertIndex] <= caloriesCount then
            break
        end
        insertIndex = insertIndex + 1
    end
    table.insert(elfCaloriesList, insertIndex, caloriesCount)
end

-- Generates the list of elves, ordered in descending calories sum
function findOrderedElfList(filename: string): {number}
    local infile = io.open(filename, "r")

    local currentLine: string = infile:read()
    local currentCaloriesSum: number = 0
    local sortedCaloriesList: {number} = { }

    while (currentLine) do
        local strippedLine = currentLine.gsub(currentLine, " ", "")
        if(isBlank(currentLine)) then
            addElfInOrderToElfList(sortedCaloriesList, currentCaloriesSum)
            currentCaloriesSum = 0
        else
            -- Assuming here that input is well-formatted, so that it can easily be parsed
            currentCaloriesSum = currentCaloriesSum + tonumber(strippedLine)
        end
        currentLine = infile:read()
    end
    -- Account for the end elf
    if(currentCaloriesSum > 0) then
        addElfInOrderToElfList(sortedCaloriesList, currentCaloriesSum)
    end
    infile:close()
    return sortedCaloriesList
end

-- Finds the stats of the elf with most calories
function solvePuzzlePartOne(filename: string): number
    return findOrderedElfList(filename)[1]
end

-- Finds the total calories carried by the top three elves
function solvePuzzlePartTwo(filename: string): number
    local sortedCaloriesList = findOrderedElfList(filename)
    local topThreeSum: number = 0
    for i=1,3 do
        local currentCaloriesSum = sortedCaloriesList[i]
        if (currentCaloriesSum ~= nil) then
            topThreeSum = topThreeSum + currentCaloriesSum
        end
    end
    return topThreeSum
end

function main()
    local filename = params[1] or "input.txt"

    -- Puzzle part one
    local largestCaloriesCount = solvePuzzlePartOne(filename)
    if(largestCaloriesCount == nil) then
        print("No elves found!")
    else
        print("The elf with the most calories has "..(largestCaloriesCount).." calories")
    end

    -- Puzzle part two
    print("The sum of calories carried by the top three elves is "..solvePuzzlePartTwo(filename))
end

main()