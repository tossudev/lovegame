Game = Object:extend()

local texSize = 16
local tileset = love.graphics.newImage("assets/textures/tileset.png")

local playerRotationDamp = 30.0 -- mouse relative x pixels per frame / this value

-- textures
local tPlayer = love.graphics.newQuad(160, 80, texSize, texSize, tileset)
local tBackgroundTop = love.graphics.newImage("assets/textures/background.png")
local tBackgroundBottom = love.graphics.newImage("assets/textures/background.png")


function Game:new()
    self.previousMousePosX = 0.0
    self.previousMousePosY = 0.0
    self.angleTarget = 0.0
    self.angle = 0.0
    self.id = love.math.random()
    self.bgPos = 0.0
end


function Game:update()
    if love.keyboard.isDown("escape") then
        S:changeScene("menu")
    end
    
end


function Game:draw()
    self:updateSprite()
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

    love.graphics.draw(
        tileset,
        tPlayer,
        love.mouse.getX()/PixelRatio,
        love.mouse.getY()/PixelRatio,
        self.angle,
        1,
        1,
        texSize/2,
        texSize/2
    )
end


function Game:mousepressed()
end
function Game:mousereleased()
end


function Game:updateSprite()
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


function Lerp(a,b,t) return (1-t)*a + t*b end