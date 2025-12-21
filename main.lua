
local font
local width, height
local titleText
local size = 1.0
local time = 0.0
local rotation = 0.0

local elements = {
    "GAME TITLE",
    "PLAY",
    "QUIT",
}
local textElements = {}


function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    font = love.graphics.newFont("assets/Lexend.ttf", 18)
    for _i=1,#elements do
        local newText = love.graphics.newText(font, elements[_i])
        table.insert(textElements, newText)
    end

end


function love.update(dt)
    time = time + dt

    size = (math.cos(time) + 8.0)/8.0
    rotation = (math.cos(time*2.0))/8.0
end


function love.draw()
    for _i,textElement in ipairs(textElements) do
        local x, y = width/2.0, height/#textElements * _i - (height/#textElements/2.0)
        
        love.graphics.draw(textElement, x, y, rotation, size, size, textElement:getWidth()/2.0, textElement:getHeight()/2.0)
    end

end
