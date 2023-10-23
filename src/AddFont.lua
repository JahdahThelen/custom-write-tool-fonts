-- Write Tool - Add Font
-- Copyright (C) 2022 Captain Llamma

-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:

-- The above copyright notice and this permission notice shall be
-- included in all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
-- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
-- LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
-- OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
-- WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-----------------------------------------------------------------------------------------
-- SETTINGS --
-----------------------------------------------------------------------------------------

DIALOG_DEFAULTS = {
    supported_characters = [[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890`~!@#$%^&*()-_=+[]'\{}"|;:,.?/<>]],
    characters_with_spaces = [["]],
    font_name = [[New Font]],
    character_spacing = {
        min = 1,
        max = 8,
        value = 1
    },
    line_spacing = {
        min = 1,
        max = 16,
        value = 2
    },
    space_width = {
        min = 1,
        max = 16,
        value = 3
    }
}

FILE = nil -- File to write

CHARACTER_NAME = {
    ["a"] = "lowerA",
    ["b"] = "lowerB",
    ["c"] = "lowerC",
    ["d"] = "lowerD",
    ["e"] = "lowerE",
    ["f"] = "lowerF",
    ["g"] = "lowerG",
    ["h"] = "lowerH",
    ["i"] = "lowerI",
    ["j"] = "lowerJ",
    ["k"] = "lowerK",
    ["l"] = "lowerL",
    ["m"] = "lowerM",
    ["n"] = "lowerN",
    ["o"] = "lowerO",
    ["p"] = "lowerP",
    ["q"] = "lowerQ",
    ["r"] = "lowerR",
    ["s"] = "lowerS",
    ["t"] = "lowerT",
    ["u"] = "lowerU",
    ["v"] = "lowerV",
    ["w"] = "lowerW",
    ["x"] = "lowerX",
    ["y"] = "lowerY",
    ["z"] = "lowerZ",
    ["A"] = "upperA",
    ["B"] = "upperB",
    ["C"] = "upperC",
    ["D"] = "upperD",
    ["E"] = "upperE",
    ["F"] = "upperF",
    ["G"] = "upperG",
    ["H"] = "upperH",
    ["I"] = "upperI",
    ["J"] = "upperJ",
    ["K"] = "upperK",
    ["L"] = "upperL",
    ["M"] = "upperM",
    ["N"] = "upperN",
    ["O"] = "upperO",
    ["P"] = "upperP",
    ["Q"] = "upperQ",
    ["R"] = "upperR",
    ["S"] = "upperS",
    ["T"] = "upperT",
    ["U"] = "upperU",
    ["V"] = "upperV",
    ["W"] = "upperW",
    ["X"] = "upperX",
    ["Y"] = "upperY",
    ["Z"] = "upperZ",
    ["1"] = "number1",
    ["2"] = "number2",
    ["3"] = "number3",
    ["4"] = "number4",
    ["5"] = "number5",
    ["6"] = "number6",
    ["7"] = "number7",
    ["8"] = "number8",
    ["9"] = "number9",
    ["0"] = "number0",
    ["`"] = "specialAccentGrave",
    ["~"] = "specialTilde",
    ["!"] = "specialExclamationMark",
    ["@"] = "specialAtSign",
    ["#"] = "specialHashtag",
    ["$"] = "specialDollar",
    ["%"] = "specialPercent",
    ["^"] = "specialCircumflex",
    ["&"] = "specialAmpersand",
    ["*"] = "specialAsterisk",
    ["("] = "specialLeftParenthesis",
    [")"] = "specialRightParenthesis",
    ["-"] = "specialMinus",
    ["_"] = "specialUnderscore",
    ["="] = "specialEqualSign",
    ["+"] = "specialPlusSign",
    ["["] = "specialLeftSquareBracket",
    ["]"] = "specialRightSquareBracket",
    ["'"] = "specialApostrophe",
    ["\\"] = "specialBackslash",
    ["{"] = "specialLeftCurlyBracket",
    ["}"] = "specialRightCurlyBracket",
    ["\""] = "specialQuotationMark",
    ["|"] = "specialVerticalBar",
    [";"] = "specialSemicolon",
    [":"] = "specialColon",
    [","] = "specialComma",
    ["."] = "specialPoint",
    ["?"] = "specialQuestionMark",
    ["/"] = "specialSlash",
    ["<"] = "specialLessThanSign",
    [">"] = "specialGreaterThanSign"
}

CHARACTER_POINTS = {}
X = 0
COLOR = 0xFF302D2D

SPRITE = nil
LAYERS = {}
IMAGE = nil

ERROR = false

-----------------------------------------------------------------------------------------
-- FAULT MESSAGES --
-----------------------------------------------------------------------------------------

function doNotShowDialog()
    ERROR = true 
end

function crash()
    os.exit()
end

function showFault(text)
    app.alert{title="Add your own font", text=text, buttons={"Close"}}
end

function noActiveSprite()
    doNotShowDialog()
    showFault({"FAULT: A1", 
    "No active sprite is available.", 
    "", 
    "Please, open the sprite containing your font is in Aseprite before starting this script."})
end

function layerNotFound(layer_name)
    showFault({"FAULT: B1", 
    "Layer \"" .. layer_name .. "\" could not be found." , 
    "", 
    "Please, verify that the layer containing the font is available."})
end

function imageNotFound()
    showFault({"FAULT: B2", 
    "The image of the selected layer could not be found." , 
    "", 
    "Please, place the image containing the font in the first frame of the selected layer."})
end

function imageIsEmpty()
    showFault({"FAULT: B3", 
    "The image of the selected layer contains no pixels." , 
    "", 
    "Please, place the image containing the font in the first frame of the selected layer."})
end

function fontFileNotCreated(file_path)
    showFault({"FAULT: C1", 
    "The file to save the font could not be created.", 
    file_path , 
    "", 
    "Please, give the script the permission to create files."})
end

function pixelsNotFound(character)
    showFault({"FAULT: D1", 
    "No pixels could be found for the character: " .. character , 
    "", 
    "Please, verify that the different characters are seperated by at least 1 vertical line of pixels."})
end

function fontNameIsEmpty()
    showFault({"FAULT: E1", 
    "The name of the font is empty." , 
    "", 
    "Please, enter a name to identify the font."})
end

function charactersIsEmpty()
    showFault({"FAULT: E2", 
    "No characters have been entered." , 
    "", 
    "Please, enter which characters the font does support."})
end

function charactersNotSupported(chars)
    showFault({"FAULT: E3", 
    "The following entered characters are not supported by this tool: " .. table.concat(chars, ", "), 
    "", 
    "Unsupported characters won't be added to the font.", 
    "Supported characters are: ", 
    DIALOG_DEFAULTS.supported_characters})
end

-----------------------------------------------------------------------------------------
-- BEFORE DIALOG --
-----------------------------------------------------------------------------------------

SPRITE = app.activeSprite
if SPRITE == nil then noActiveSprite() 
else 
    for i = 1, #SPRITE.layers do
        table.insert(LAYERS, SPRITE.layers[i].name) -- fill dropdown with layer names
    end
end

-----------------------------------------------------------------------------------------
-- FUNCTIONS --
-----------------------------------------------------------------------------------------

function Main(data)
    if validate(data) == false then return end

    IMAGE = getImage(data.layer)
    if IMAGE == nil then return end

    FILE = createFile(data.font_name)
    if FILE == nil then return end

    FILE:write(copyRight(data.font_name))
    FILE:write(fontSettings(data.font_name, data.characters, getFontHeight(),
    data.character_spacing, data.line_spacing, data.space_width))
    FILE:write(charactersHeader())

    for i = 1, #data.characters do
        CHARACTER_POINTS = readSingleCharacter()
        local char = data.characters:sub(i,i)
        if(#CHARACTER_POINTS < 1) then pixelsNotFound(char) end
        if hasSpace(char, data.characters_with_spaces) then addAnotherChar() end
        FILE:write(character(char))
    end

    FILE:write(close())

    io.close(FILE)
end

function validate(data)
    local name = data.font_name
    if #name < 1 then fontNameIsEmpty() return false end

    local chars = data.characters
    if #chars < 1 then charactersIsEmpty() return false end
    local unsupported_chars = {}
    for char in string.gmatch(chars, ".") do
        if string.find(DIALOG_DEFAULTS.supported_characters, char, 1, true) == nil then
            table.insert(unsupported_chars, char)
        end
    end
    if #unsupported_chars > 1 then charactersNotSupported(unsupported_chars) end

    return true
end

function createFile(file_name)
    file_path = app.fs.joinPath(app.fs.userDocsPath, file_name .. ".lua")
    file = io.open(file_path, "w")

    if file == nil then fontFileNotCreated(file_path) return nil end

    return file
end

function copyRight(font_name)
    text =  
    [[
    -- ]] .. font_name .. [[ 

    -- Copyright (C) 2022 Write Tool for Aseprite
    
    -- Permission is hereby granted, free of charge, to any person obtaining
    -- a copy of this software and associated documentation files (the
    -- "Software"), to deal in the Software without restriction, including
    -- without limitation the rights to use, copy, modify, merge, publish,
    -- distribute, sublicense, and/or sell copies of the Software, and to
    -- permit persons to whom the Software is furnished to do so, subject to
    -- the following conditions:
    
    -- The above copyright notice and this permission notice shall be
    -- included in all copies or substantial portions of the Software.
    
    -- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    -- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    -- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    -- NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    -- LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    -- OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    -- WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    ]]

    return text
end

function fontSettings(
    font_name, supported_characters, font_height, 
    character_spacing, line_spacing, space_width)
    text =  
    [[
        
FONT = {

    ------------------------------------------------------------------------------------------
    -- FONT SETTINGS --
    ------------------------------------------------------------------------------------------
    
        name = ]] .. "[[" .. font_name .. "]]" .. [[,
        supportedCharacters = ]] .. "[[ " .. supported_characters .. "]]" .. [[, 
        height = ]] .. font_height .. [[,
        characterSpacing = ]] .. character_spacing .. [[,
        lineSpacing = ]] .. line_spacing .. [[,
        space = ]] .. space_width .. [[,
    
    ]]

    return text
end

function charactersHeader()
    text = [[

    ------------------------------------------------------------------------------------------
    -- CHARACTERS --
    ------------------------------------------------------------------------------------------

    ]]

    return text
end

function character(char)
    text = [[
]]
    if CHARACTER_NAME[char] ~= nil then 
    text = [[
]] .. CHARACTER_NAME[char] .. [[ = ]] .. writePoints(CHARACTER_POINTS) .. [[
              
        ]] 
    end 

    return text
end

function close()
    text = [[
          
}

table.insert(ALL_FONTS, FONT)
    ]]

    return text
end

function writePoints(points)

    if #points < 1 then return [["No positions found",]] end

    local startX = points[1].x
    local text = "{ "

    text = text .. "Point(" .. points[1].x - startX .. ", " .. points[1].y .. ")"

    for i = 2, #points do
        text = text .. ", Point(" .. points[i].x - startX .. ", " .. points[i].y .. ")"
    end
    text = text .. " },"

    return text

end

function getImage(layer_name)
    local layer = nil
    for i = 1,#SPRITE.layers do
        if SPRITE.layers[i].name == layer_name then
            layer = SPRITE.layers[i]
        end
    end
    if layer == nil then layerNotFound(layer_name) return nil end
    local image = layer.cels[1].image
    if image == nil then imageNotFound() return nil end
    if image:isEmpty() then imageIsEmpty() return nil end

    return image
end

function getFontHeight()
    return IMAGE.height - 1
end

function readSingleCharacter()
    local points = {}
    local enablePixelFound = false
    for x = X, IMAGE.width - 1 do
        local pixelFound = false

        for y = 0, IMAGE.height do

            if IMAGE:getPixel(x, y) == COLOR then 
                table.insert(points, Point(x, y))
                pixelFound = true
                enablePixelFound = true
            end

        end

        if pixelFound == false and enablePixelFound == true then
            X = x
            return points
        end
    end
    
    return points
end

function hasSpace(char, characters_with_spaces)
    if string.find(characters_with_spaces, char, 1, true) == nil then
        return false
    end
    return true
end

function addAnotherChar()
    local points = readSingleCharacter()
    for i = 1, #points do
        table.insert(CHARACTER_POINTS, points[i])
    end
end

------------------------------------------------------------------------------------------
-- DIALOG --
------------------------------------------------------------------------------------------

local dlg = Dialog { 
    title = "Add Font"
}
local bounds = dlg.bounds
dlg.bounds = Rectangle(100, 100, 570, 190)

dlg:entry { 
    id = "font_name", 
    text = DIALOG_DEFAULTS.font_name, 
    label = "Font name" 
}

dlg:combobox {
    id = "layer",
    label = "Layer",
    options = LAYERS
}

dlg:separator { text = "The characters must be placed in the same order as in the image." }
dlg:entry { 
    id = "characters", 
    text = DIALOG_DEFAULTS.supported_characters, 
    label = "Characters" 
}

dlg:entry { 
    id = "characters_with_spaces", 
    text = DIALOG_DEFAULTS.characters_with_spaces, 
    label = "Characters with spaces" 
}

dlg:slider { 
    id = "character_spacing", 
    label = "Character spacing", 
    min = DIALOG_DEFAULTS.character_spacing.min, 
    max = DIALOG_DEFAULTS.character_spacing.max, 
    value = DIALOG_DEFAULTS.character_spacing.value 
}

dlg:slider { 
    id = "line_spacing", 
    label = "Line spacing", 
    min = DIALOG_DEFAULTS.line_spacing.min, 
    max = DIALOG_DEFAULTS.line_spacing.max, 
    value = DIALOG_DEFAULTS.line_spacing.value 
}

dlg:slider { 
    id = "space_width", 
    label = "Space width", 
    min = DIALOG_DEFAULTS.space_width.min, 
    max = DIALOG_DEFAULTS.space_width.max, 
    value = DIALOG_DEFAULTS.space_width.value
}

dlg:button { id = "cancel", text = "Cancel",
    onclick = function()
        dlg:close()
    end
}

dlg:button { id = "add_font", text = "Add Font", 
    onclick = function()
        Main(dlg.data)
    end
}

if ERROR == false then dlg:show {wait = false} end
