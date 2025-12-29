local camera
local sceneManager

local gameWidth, gameHeight = 320, 180 --fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself
PixelRatio = windowWidth/gameWidth
PI = 3.14159


function love.load()
    Object = require "lib.classic"
    require "scene_manager"

    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    love.graphics.setLineStyle("rough")
    love.window.setMode(windowWidth, windowHeight)

    sceneManager = SceneManager()
end


function love.update(dt)
    sceneManager:update(dt)
end


function love.draw()
    love.graphics.scale(PixelRatio, PixelRatio)
    sceneManager:draw()
end


function love.mousepressed()
    sceneManager:mousepressed()
end


function love.mousereleased()
    sceneManager:mousereleased()
end