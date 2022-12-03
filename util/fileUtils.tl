-- Methods
local function doForFileLines(filename: string, operation: function(string))
    local infile = io.open(filename, "r")
    local currentLine: string = infile:read()
    while (currentLine) do
        operation(currentLine)
        currentLine = infile:read()
    end
    infile:close()
end

-- Export
return {
    doForFileLines = doForFileLines
}