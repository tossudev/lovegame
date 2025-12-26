Game = Object:extend()

local texSize = 16
local tileset = love.graphics.newImage("assets/textures/tileset.png")
local texPlayer = love.graphics.newQuad(160, 80, texSize, texSize, tileset)


function Game:new()
    self.previousMousePosX = 0.0
    self.previousMousePosY = 0.0
    self.angleTarget = 0.0
    self.angle = 0.0
end


function Game:draw()
    love.graphics.draw(
        tileset,
        texPlayer,
        love.mouse.getX()/PixelRatio - texSize/2,
        love.mouse.getY()/PixelRatio - texSize/2,
        self.angle
    )
end

function Game:update()
    if love.keyboard.isDown("escape") then
        S:changeScene("menu")
    end

    Game:updateSprite()
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

    local mousePosX, mousePosY = love.mouse.getX(), love.mouse.getY()

    local relativeX, relativeY = mousePosX-self.previousMousePosX, mousePosY-self.previousMousePosY
    self.angleTarget = math.atan2(relativeY, relativeX)

    self.previousMousePosX, self.previousMousePosY = mousePosX, mousePosY
    self.angle = Lerp(self.angle, self.angleTarget, 0.5)
    print(self.angle)
end


function Lerp(a,b,t) return (1-t)*a + t*b end