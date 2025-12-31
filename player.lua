Player = Object:extend()

local size = 16
local tPlayer = love.graphics.newQuad(160, 80, size, size, Tileset)
local playerRotationDamp = 30.0 -- mouse relative x pixels per frame / this value


function Player:new()
    require "lib/math"

    self.previousMousePosX = 0.0
    self.previousMousePosY = 0.0
    self.angleTarget = 0.0
    self.angle = 0.0
end


function Player:draw()
    self:updateSprite()
    love.graphics.draw(
        Tileset,
        tPlayer,
        love.mouse.getX()/PixelRatio,
        love.mouse.getY()/PixelRatio,
        -self.angle,
        1,
        1,
        size/2,
        size/2
    )

end


function Player:updateSprite()
    if self.previousMousePosX == nil then
        self.previousMousePosX = 0.0
        self.previousMousePosY = 0.0
        self.angleTarget = 0.0
        self.angle = 0.0
    end

    local mousePosX = love.mouse.getX()
    local relativeX = mousePosX-self.previousMousePosX
    
    if math.abs(relativeX) >= 0.5 then
        self.angleTarget = relativeX / playerRotationDamp
    else
        self.angleTarget = 0.0
    end


    self.previousMousePosX, self.previousMousePosY = mousePosX, mousePosY
    self.angle = Lerp(self.angle, self.angleTarget, 0.5)
end