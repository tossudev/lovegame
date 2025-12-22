local font
local width, height

local buttonTexts = {
    "GAME TITLE",
    "PLAY",
    "QUIT",
}
local button
local buttons = {}


function love.load()
    Object = require "classic"
    require "button"

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    local newButton = Button(400, 300, "text test")
    local newButton2 = Button(400, 400, "text test2")
    table.insert(buttons, newButton)
    table.insert(buttons, newButton2)
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

function lerp(a,b,t) return (1-t)*a + t*b end
