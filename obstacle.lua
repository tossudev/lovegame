Obstacle = Object:extend()

local size = 16
local deathZone = -64 -- y pos where obstacle is freed


function Obstacle:new(gameClass)
    require "main"
    
    self.texture = love.graphics.newQuad(144, 96, size, size, Tileset)
    self.x = love.math.random(0, GameWidth)
    self.y = GameHeight
    self.collider = {0, 0, size, size}
    self.game = gameClass
end


function Obstacle:update(speed)
    if self.y < deathZone then
        table.remove(self.game.obstacles, 1)
    end

    self.y = self.y - speed
    self.collider[1] = self.x - size/2
    self.collider[2] = self.y - size/2
end


function Obstacle:draw()
    love.graphics.draw(
        Tileset,
        self.texture,
        self.x,
        self.y,
        0.0,
        1,
        1,
        size/2,
        size/2
    )
end