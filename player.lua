Player = Object:extend()

local size = 16
local tPlayer = love.graphics.newQuad(160, 80, size, size, Tileset)
local playerRotationDamp = 30.0 -- mouse relative x pixels per frame / this value



function Player:new()
    require "lib/math"

    self.previousMouseX = 0.0
    self.previousMouseY = 0.0
    self.angleTarget = 0.0
    self.angle = 0.0
    self.trailLines = {}
end


function Player:draw(speed)
    local mouseX = love.mouse.getX()/PixelRatio
    local mouseY = love.mouse.getY()/PixelRatio

    self:updateSprite()
    
    if #self.trailLines > 2 then
        for _, trailPos in ipairs(self.trailLines) do
            trailPos = trailPos - speed
        end
        love.graphics.line(self.trailLines)
    end


    if #self.trailLines > 60 then
        table.remove(self.trailLines, 1)
        table.remove(self.trailLines, 1)
    end

    table.insert(self.trailLines, mouseX)
    table.insert(self.trailLines, mouseY)

    love.graphics.draw(
        Tileset,
        tPlayer,
        mouseX,
        mouseY,
        -self.angle,
        1,
        1,
        size/2,
        size/2
    )
    
    self.previousMouseX, self.previousMouseY = mouseX, mouseY
end


function Player:updateSprite()
    if self.previousMouseX == nil then
        self.previousMouseX = 0.0
        self.previousMouseY = 0.0
        self.angleTarget = 0.0
        self.angle = 0.0
    end

    local mouseX = love.mouse.getX()/PixelRatio
    local relativeX = mouseX - self.previousMouseX
    
    if math.abs(relativeX) >= 0.5 then
        self.angleTarget = relativeX / playerRotationDamp * PixelRatio
    else
        self.angleTarget = 0.0
    end

    self.angle = Lerp(self.angle, self.angleTarget, 0.5)
end