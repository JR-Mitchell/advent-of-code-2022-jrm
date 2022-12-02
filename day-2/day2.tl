local params = {...}

function partOneScoreCalculationMethod(theirPlayInt: integer, yourPlayInt: integer): integer
    local resultModulo: integer = (theirPlayInt - yourPlayInt) % 3
    local victoryScore: integer = (resultModulo - 1) * (9 * resultModulo - 6) // 2
    return yourPlayInt + victoryScore
end

function partTwoScoreCalculationMethod(theirPlayInt: integer, yourVictoryInt: integer): integer
    local victoryScore: integer = 3 * (yourVictoryInt - 1)
    local victoryIntMapped: integer = (yourVictoryInt - 2) * (3 * yourVictoryInt - 5) // 2
    local yourPlayInt: integer = (theirPlayInt - victoryIntMapped) % 3
    return yourPlayInt + victoryScore
end

function roundCharactersToInts(theirPlay: string, yourValue: string): integer, integer
    return string.byte(theirPlay) - string.byte("A") + 1, string.byte(yourValue) - string.byte("X") + 1
end

function calculateYourTotalScore(filename: string, calculateRoundScore: (function(integer, integer): integer)): integer
    local infile = io.open(filename, "r")
    local currentLine: string = infile:read()
    local yourScore: integer = 0
    while (currentLine) do
        local _, _, theirPlay, yourValue = string.find(currentLine, "([ABC]) ([XYZ])")
        local theirPlayInt, yourValueInt = roundCharactersToInts(theirPlay, yourValue)
        yourScore = yourScore + calculateRoundScore(theirPlayInt, yourValueInt)
        currentLine = infile:read()
    end
    infile:close()
    return yourScore
end

function solvePuzzlePartOne(filename: string)
    print("Your total score, following the strategy guide but using your incorrect assumption made before the elf returned, would be "..calculateYourTotalScore(filename, partOneScoreCalculationMethod))
end

function solvePuzzlePartTwo(filename: string)
    print("Your total score, following the strategy guide correctly, would be "..calculateYourTotalScore(filename, partTwoScoreCalculationMethod))
end

function main()
    local filename = params[1] or "input.txt"
    solvePuzzlePartOne(filename)
    solvePuzzlePartTwo(filename)
end

main()