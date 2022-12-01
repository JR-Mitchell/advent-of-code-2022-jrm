local params = {...}

local record ElfStats
    elfIndex: integer
    caloriesSum: number
end

-- Puzzle says delimiting lines are "blank" not "empty", so strip them
function isBlank(line: string): boolean
    return line == nil or #string.gsub(line, " ", "") == 0
end

function solvePuzzlePartOne(filename: string): ElfStats
    local infile = io.open(filename, "r")

    local currentLine: string = infile:read()
    local currentElf: ElfStats = {
        elfIndex = 1,
        caloriesSum = 0
    }
    local largestCountElf: ElfStats = {
        elfIndex = 1,
        caloriesSum = 0
    }

    while (currentLine) do
        local strippedLine = currentLine.gsub(currentLine, " ", "")
        if(isBlank(currentLine)) then
            if(currentElf.caloriesSum > largestCountElf.caloriesSum) then
                largestCountElf = currentElf
            end
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
    infile:close()
    return largestCountElf
end

function main()
    -- Puzzle part one
    local filename = params[1] or "input.txt"
    local largestCountElf = solvePuzzlePartOne(filename)
    print("The "..largestCountElf.elfIndex.."th elf has the most calories")
    print("This elf has "..(largestCountElf.caloriesSum).." calories")
end

main()