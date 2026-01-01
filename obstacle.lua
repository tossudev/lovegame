Obstacle = Object:extend()

local size = 16


function Obstacle:new()
    require "main"
    
    self.texture = love.graphics.newQuad(144, 96, size, size, Tileset)
    self.x = love.math.random(0, GameWidth)
    self.y = GameHeight
    self.collider = {0, 0, size, size}
end


function Obstacle:update(speed)
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