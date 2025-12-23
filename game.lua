Game = Object:extend()


function Game:new()
    Object = require "classic"
end


function Game:draw()
    love.graphics.circle("fill", 32, 32, 32)
end

function Game:update()
    if love.keyboard.isDown("escape") then
        S:changeScene("menu")
    end
end

function Game:mousepressed()
end
function Game:mousereleased()
end