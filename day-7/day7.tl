local FILENAME = string.gsub(debug.getinfo(1).short_src, "day7.tl", "input.txt")
local EXAMPLE_FILENAME = string.gsub(debug.getinfo(1).short_src, "day7.tl", "example-input.txt")

local fileUtils = require("fileUtils")

local CD_PATTERN <const> = "$ cd ([a-zA-Z.]+)"
local DIR_PATTERN <const> = "dir ([a-zA-Z]+)"
local FILE_PATTERN <const> = "(%d+) ([a-zA-Z.]+)"

local PART_ONE_DIR_SIZE <const> = 100000

local record File
    size: integer
    name: string
end

local record Directory
    name: string
    childFiles: {File}
    childDirs: {string: Directory}
    parentDir: Directory
    size: integer
end

function debugPrint(directory: Directory, prefix: string)
    print(prefix.."- dir: "..directory.name)
    for _, file in ipairs(directory.childFiles) do
        print(prefix.."   - file: "..file.name..","..file.size)
    end
    for _, dir in pairs(directory.childDirs) do
        debugPrint(dir, prefix.."   ")
    end
end

function getSizeOf(directory: Directory): integer
    if(directory.size ~= nil) then
        return directory.size
    end
    local size: integer = 0
    for _, file in ipairs(directory.childFiles) do
        size = size + file.size
    end
    for _, dir in pairs(directory.childDirs) do
        size = size + getSizeOf(dir)
    end
    directory.size = size
    return size
end

function commandCd(currentLine: string, cwd: Directory, newDirCallback: function(Directory)): boolean
    local _, _, cdLoc = string.find(currentLine, CD_PATTERN)
    if(cdLoc == nil) then return false end
    local newCwd: Directory
    if(cdLoc == "..") then
        newCwd = cwd.parentDir
    else
        newCwd = cwd.childDirs[cdLoc]
    end
    if(newCwd == nil) then return true end
    newDirCallback(newCwd)
    return true
end

function commandDir(currentLine: string, dirsList: {Directory}, cwd: Directory): boolean
    local _, _, dirName = string.find(currentLine, DIR_PATTERN)
    if(dirName == nil) then return false end
    if(cwd.childDirs[dirName] ~= nil) then return true end
    local newDir: Directory = {
        name = dirName,
        childFiles = {},
        childDirs = {},
        parentDir = cwd
    }
    table.insert(dirsList, newDir)
    cwd.childDirs[dirName] = newDir
    return true
end
   
function commandFile(currentLine: string, cwd: Directory): boolean
    local _, _, sizeStr, fileName = string.find(currentLine, FILE_PATTERN)
    if(sizeStr == nil or fileName == nil) then return false end
    local newFile: File = {
        size = tonumber(sizeStr) as integer,
        name = fileName
    }
    table.insert(cwd.childFiles, newFile)
    return true
end

function parseDirStructure(filename: string): {Directory}
    local root: Directory = {
        name = "/",
        childFiles = {},
        childDirs = {}
    }
    local cwd: Directory = root
    local dirsList: {Directory} = {root}
    local replaceMethod = function(newCwd: Directory)
        cwd = newCwd
    end
    fileUtils.doForFileLines(
        filename,
        function(currentLine: string)
            local _ = commandCd(currentLine, cwd, replaceMethod)
                or commandDir(currentLine, dirsList, cwd)
                or commandFile(currentLine, cwd)
        end
    )
    return dirsList
end

function sumSizeOfDirsWithSizeBelow(dirsList: {Directory}, maxSize: integer): integer
    local sum: integer = 0
    for _, dir in ipairs(dirsList) do
        local size = getSizeOf(dir)
        if(size <= maxSize) then
            sum = sum + size
        end
    end
    return sum
end

function sumSizePartOne(filename: string): integer
    local dirsList = parseDirStructure(filename)
    local root = dirsList[1]
    debugPrint(root, "")
    return sumSizeOfDirsWithSizeBelow(dirsList, PART_ONE_DIR_SIZE)
end

function testPuzzlePartOne()
    local expected = 95437
    local actual = sumSizePartOne(EXAMPLE_FILENAME)
    if(expected ~= actual) then error("Part one test failed. Expected: "..expected..", Actual: "..actual) end
end

function solvePuzzlePartOne()
    print("The sum of the total sizes of directories with total size smaller than "..PART_ONE_DIR_SIZE.." is "..sumSizePartOne(FILENAME))
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