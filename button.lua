Button = Object:extend()

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


function Button.load()
    Object = require "classic"
end


function Button:new(_x, _y, _text)
    self.x, self.y = _x, _y
    self.size = 1.0
    self.w = 256.0
    self.h = 128.0

    local font = love.graphics.newFont("assets/Lexend.ttf", 64)
    local newText = love.graphics.newText(font, _text)
    self.text = newText
end


function Button:update(dt)
    self.time = time + dt

    -- size = (math.cos(time) + 20.0)/20.0
    rotation = (math.cos(time*2.0))/12.0

    if Button:isMouseOnButton() then
        spring_destination = 1.5
    else
        spring_destination = 1.0
    end

    Button:spring()
end


function Button:draw()
    love.graphics.draw(
        self.text,
        self.x,
        self.y,
        0.0,
        self.size,
        self.size,
        self.w/2.0,
        self.h/2.0
    )
end


function love.mousepressed()
    if Button:isMouseOnButton() then
        spring_destination = 0.5
    end
end


function love.mousereleased()
    if Button:isMouseOnButton() then
        print("Pressed Play!")
    end
end


function Button:spring()
    local distance_to_dest = size - spring_destination
    local loss = damping * velocity

    -- hooke's law
    local force = -rigidness * distance_to_dest - loss

    velocity = velocity + force
    self.size = size + velocity
end


function Button:isMouseOnButton()
    local offset_x = x - (w/2.0)
    local offset_y = y - (h/2.0)

    return love.mouse.getX() >= offset_x
    and love.mouse.getX() < offset_x + w
    and love.mouse.getY() >= offset_y
    and love.mouse.getY() < offset_y + h
end