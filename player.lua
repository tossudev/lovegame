Player = Object:extend()

local push = require "lib.push"
local size = 16
local tPlayer = love.graphics.newQuad(160, 80, size, size, Tileset)
local playerRotationDamp = 10.0
local health = 3


function Player:new(gameClass)
    require "lib/math"

    self.previousMouseX = 0.0
    self.previousMouseY = 0.0
    self.angleTarget = 0.0
    self.angle = 0.0
    self.trailLinesL = {}
    self.trailLinesR = {}
    self.trailHue = 0.0
    self.collider = {0, 0, size, size}
    self.mouseX = 0.0
    self.mouseY = 0.0
    self.health = health
    self.game = gameClass

    love.graphics.setLineWidth(4)
    love.graphics.setLineStyle("smooth")
end


function Player:update(dt)
	self.mouseX, self.mouseY = push.toGame(love.mouse.getX(), love.mouse.getY())
	if not mouseX or not mouseY then
		mouseX, mouseY = -1, -1
	end   
	
	self.collider[1] = self.mouseX - size/2
    self.collider[2] = self.mouseY - size/2

    self.trailHue = self.trailHue + dt
end


function Player:draw(speed)
    self:updateSprite()
    
    if #self.trailLinesL > 2 then
        for _i, trailPos in ipairs(self.trailLinesL) do
            if _i % 2 == 0 then
                self.trailLinesL[_i] = trailPos - speed
            end
        end
        for _i, trailPos in ipairs(self.trailLinesR) do
            if _i % 2 == 0 then
                self.trailLinesR[_i] = trailPos - speed
            end
        end
        self.trailLinesL[#self.trailLinesL - 1] = self.mouseX - 3
        self.trailLinesL[#self.trailLinesL] = self.mouseY
        
        self.trailLinesR[#self.trailLinesR - 1] = self.mouseX + 3
        self.trailLinesR[#self.trailLinesR] = self.mouseY
        
        if speed > 5 then
            love.graphics.setColor(HSV(self.trailHue, 0.5, 1.0))
        else
            love.graphics.setColor(love.math.colorFromBytes(183, 210, 235))
        end

        love.graphics.line(self.trailLinesL)
        love.graphics.line(self.trailLinesR)
    end
    
    
    if #self.trailLinesL > 360 then
        table.remove(self.trailLinesL, 1)
        table.remove(self.trailLinesL, 1)
        table.remove(self.trailLinesR, 1)
        table.remove(self.trailLinesR, 1)
    end
    
    table.insert(self.trailLinesL, self.mouseX - 3)
    table.insert(self.trailLinesL, self.mouseY)
    
    table.insert(self.trailLinesR, self.mouseX + 3)
    table.insert(self.trailLinesR, self.mouseY)
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(
        Tileset,
        tPlayer,
        self.mouseX,
        self.mouseY,
        -self.angle,
        1,
        1,
        size/2,
        size/2
    )
    
    self.previousMouseX, self.previousMouseY = self.mouseX, self.mouseY
end


function Player:updateSprite()
    if self.previousMouseX == nil then
        self.previousMouseX = 0.0
        self.previousMouseY = 0.0
        self.angleTarget = 0.0
        self.angle = 0.0
    end

    local relativeX = self.mouseX - self.previousMouseX
    
    if math.abs(relativeX) >= 0.5 then
        self.angleTarget = relativeX / playerRotationDamp
    else
        self.angleTarget = 0.0
    end

    self.angle = Lerp(self.angle, self.angleTarget, 0.5)
end


function Player:takeDamage()
    health = health - 1

    -- if health <= 0 then
    --     self.game.endGame()
    -- end
end
