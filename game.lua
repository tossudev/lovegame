Game = Object:extend()
Tileset = love.graphics.newImage("assets/textures/tileset.png")

-- textures
local tBackgroundTop = love.graphics.newImage("assets/textures/background.png")
local tBackgroundBottom = love.graphics.newImage("assets/textures/background.png")

local player
local speedScale = 0.5 -- speed multiplier per second
local baseSpeed = 64.0 -- pixels per second


function Game:new()
    require "player"
    player = Player()
    
    self.bgPos = 0.0
    self.speed = 1.0
end


function Game:update(dt)
    if love.keyboard.isDown("escape") then
        S:changeScene("menu")
    end

    if love.mouse.isDown(1) then
        self.speed = self.speed + (speedScale*dt)
    else
        self.speed = 1.0
    end

    player:update(dt)
end


function Game:draw()
    self.bgPos = self.bgPos - baseSpeed * (self.speed/60.0)
    local bgHeight = tBackgroundBottom:getHeight()

    if math.abs(self.bgPos) >= bgHeight then
        self.bgPos = 0.0
    end

    love.graphics.draw(
        tBackgroundTop,
        0, self.bgPos
    )
    love.graphics.draw(
        tBackgroundBottom,
        0, self.bgPos + bgHeight
    )

    player:draw(baseSpeed * (self.speed/60.0))
end


function Game:mousepressed()
end
function Game:mousereleased()
end