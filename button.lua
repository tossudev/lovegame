local rigidness = 0.1
local damping = 0.2
local velocity = 0.0
local spring_destination = 1.0

local size = 1.0
local spring_size = 1.0
local time = 0.0
local rotation = 0.0
local x = 256.0
local y = 256.0
local w = 128.0
local h = 128.0
local text


Button = Object:extend()


function Button.load()
    Object = require "classic"
end


function Button:new(_x, _y)
    x, y = _x, _y
    
    local font = love.graphics.newFont("assets/Lexend.ttf", 64)
    -- for _i=1,#buttonTexts do
    local newText = love.graphics.newText(font, "whateva")
    text = newText

end


function Button.update(dt)
    time = time + dt

    -- size = (math.cos(time) + 20.0)/20.0
    rotation = (math.cos(time*2.0))/12.0

    if isMouseOnButton() then
        spring_destination = 1.5
    else
        spring_destination = 1.0
    end

    spring()
end


function Button.draw()
    love.graphics.draw(
        text,
        x,
        y,
        0.0,
        size,
        size,
        w/2.0,
        h/2.0
    )
end


function love.mousepressed()
    if isMouseOnButton() then
        spring_destination = 0.5
    end
end


function love.mousereleased()
    if isMouseOnButton() then
        print("Pressed Play!")
    end
end


function spring()
    local distance_to_dest = size - spring_destination
    local loss = damping * velocity

    -- hooke's law
    local force = -rigidness * distance_to_dest - loss

    velocity = velocity + force
    size = size + velocity

end


function isMouseOnButton()
    local offset_x = x - (w/2.0)
    local offset_y = y - (h/2.0)

    return love.mouse.getX() >= offset_x
    and love.mouse.getX() < offset_x + w
    and love.mouse.getY() >= offset_y
    and love.mouse.getY() < offset_y + h
end