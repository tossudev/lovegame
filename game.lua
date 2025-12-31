Game = Object:extend()
Tileset = love.graphics.newImage("assets/textures/tileset.png")

-- textures
local tBackgroundTop = love.graphics.newImage("assets/textures/background.png")
local tBackgroundBottom = love.graphics.newImage("assets/textures/background.png")

local player


function Game:new()
    require "player"
    player = Player()

    self.id = love.math.random()
    self.bgPos = 0.0
end


function Game:update()
    if love.keyboard.isDown("escape") then
        S:changeScene("menu")
    end
end


function Game:draw()
    self.bgPos = self.bgPos - 1.0
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

    player:draw()
end


function Game:mousepressed()
end
function Game:mousereleased()
end