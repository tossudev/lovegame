Camera = Object:extend()

local shakeAmount = 3 -- pixels
local defaultShakeTime = 6 -- frames


function Camera:new()
    self.shaking = false
    self.shakeFrames = 0
end


function Camera:shake()
    self.shaking = true
    self.shakeFrames = defaultShakeTime
end


function Camera:draw()
    if self.shaking then
        self.shakeFrames = self.shakeFrames - 1

        if self.shakeFrames <= 0 then
            self.shaking = false
            love.graphics.translate(0, 0)
            return
        end

        love.graphics.translate(
            love.math.random(-shakeAmount, shakeAmount),
            love.math.random(-shakeAmount, shakeAmount)
        )
    end
end