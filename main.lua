local camera
local sceneManager
local push = require "lib.push"

local gameWidth, gameHeight = 320, 180 --fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()
windowWidth, windowHeight = windowWidth*.7, windowHeight*.7 --make the window a bit smaller than the screen itself

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, pixelperfect = true})


function love.load()
    Object = require "lib.classic"
    require "scene_manager"
    sceneManager = SceneManager()
end


function love.update(dt)
    sceneManager:update(dt)
end


function love.draw()
    push:start()
    sceneManager:draw()
    push:finish()
end


function love.mousepressed()
    sceneManager:mousepressed()
end


function love.mousereleased()
    sceneManager:mousereleased()
end