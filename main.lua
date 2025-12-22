local font
local width, height

local buttonTexts = {
    "GAME TITLE",
    "PLAY",
    "QUIT",
}
local button


function love.load()
    Object = require "classic"
    require "button"

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    font = love.graphics.newFont("assets/Lexend.ttf", 64)
    -- for _i=1,#buttonTexts do
    -- local newText = love.graphics.newText(font, buttonTexts[_i])
    button = Button(400, 300)
    -- end
end


function love.update(dt)
    -- for _i,button in ipairs(buttons) do
    button.update(dt)
    -- end
end


function love.draw()
    -- for _i,button in ipairs(buttons) do
    local x, y = width/2.0, height/2.0
    
    -- button.w = button.text:getWidth()
    -- button.h = button.text:getHeight()

    button:draw()
    -- end
end

function lerp(a,b,t) return (1-t)*a + t*b end
