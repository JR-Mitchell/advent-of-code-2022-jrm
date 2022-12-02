local params = {...}

function calculateRoundScore(theirPlay: string, yourPlay: string): integer
    local yourPlayInt: integer = string.byte(yourPlay) - string.byte("X") + 1
    local theirPlayInt: integer = string.byte(theirPlay) - string.byte("A") + 1
    local resultModulo: integer = (theirPlayInt - yourPlayInt) % 3
    local victoryScore: integer = (resultModulo - 1) * (9 * resultModulo - 6) // 2
    return yourPlayInt + victoryScore
end

function calculateYourTotalScore(filename: string): integer
    local infile = io.open(filename, "r")
    local currentLine: string = infile:read()
    local yourScore: integer = 0
    while (currentLine) do
        local _, _, theirPlay, yourPlay = string.find(currentLine, "([ABC]) ([XYZ])")
        yourScore = yourScore + calculateRoundScore(theirPlay, yourPlay)
        currentLine = infile:read()
    end
    infile:close()
    return yourScore
end

function solvePuzzlePartOne(filename: string)
    print("Your total score, following the strategy guide, would be "..calculateYourTotalScore(filename))
end

function main()
    local filename = params[1] or "input.txt"
    solvePuzzlePartOne(filename)
end

main()