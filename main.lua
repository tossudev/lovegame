local camera
local sceneManager


function love.load()
    Object = require "classic"
    require "scene_manager"
    sceneManager = SceneManager()
end


function love.update(dt)
    sceneManager:update(dt)
end


function love.draw()
    sceneManager:draw()
end


function love.mousepressed()
    sceneManager:mousepressed()
end


function love.mousereleased()
    sceneManager:mousereleased()
end