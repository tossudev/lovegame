local font
local width, height

local buttonTexts = {
    "Awesome game",
    "Play",
    "Settings",
    "Quit",
}
local button
local buttons = {}


function love.load()
    Object = require "classic"
    require "button"

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    for _i,buttonText in ipairs(buttonTexts) do
        local animOffset = 0.2 * _i
        -- scuffed positioning fix immediate !!
        local newButton = Button(400, 150 * _i - 75, buttonText, animOffset)
        table.insert(buttons, newButton)
    end
end


function love.update(dt)
    for _i,_button in ipairs(buttons) do
        _button:update(dt)
    end
end


function love.draw()
    for _i,_button in ipairs(buttons) do
        local x, y = width/2.0, height/2.0
    
    -- button.w = button.text:getWidth()
    -- button.h = button.text:getHeight()

        _button:draw()
    end
end


function love.mousepressed()
    for _i,_button in ipairs(buttons) do
        _button:mousepressed()
    end
end


function love.mousereleased()
    for _i,_button in ipairs(buttons) do
        _button:mousereleased()
    end
end


function lerp(a,b,t) return (1-t)*a + t*b end
