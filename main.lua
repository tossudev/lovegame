local font
local width, height

local button
local buttons = {}
local camera


function love.load()
    Object = require "classic"
    require "button"
    require "camera"

    camera = Camera()

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    local buttonTexts = {
        {"making love", nil},
        {"Play", nil},
        {"Quit", pressedQuit},
    }

    for _i,buttonValues in ipairs(buttonTexts) do
        print(buttonValues[1])
        print(buttonValues[2])
        local animOffset = 0.2 * _i
        -- scuffed positioning fix immediate !!
        local newButton = Button(400, 150 * _i - 75, buttonValues, animOffset, camera)
        table.insert(buttons, newButton)
    end
end


function love.update(dt)
    for _i,_button in ipairs(buttons) do
        _button:update(dt)
    end
end


function love.draw()
    camera:draw()

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


function pressedQuit()
    love.event.quit()
end