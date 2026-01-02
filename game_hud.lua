HUD = Object:extend()


function HUD:new()
    self.tScore = love.graphics.newText(Font, {{0, 0, 0}})
end

function HUD:draw(score)
    self.tScore:set({{0, 0, 0}, score})
    love.graphics.draw(self.tScore, GameWidth / 2 - self.tScore:getWidth() / 2, 0)
end