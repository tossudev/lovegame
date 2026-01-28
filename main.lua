local camera
local sceneManager

GameWidth, GameHeight = 320, 180 --fixed game resolution
local windowWidth, windowHeight = 1280, 720
local push = require "lib.push"

PI = 3.14159


function love.load()
    Object = require "lib.classic"
    require "scene_manager"

    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")
	love.window.setTitle("LOVESKI")

	love.window.setMode(1280, 720, {resizable=true})

	push.setupScreen(
		GameWidth,
		GameHeight,
		{upscale="normal"}
	)
    
	sceneManager = SceneManager()
end


function love.update(dt)
    sceneManager:update(dt)
end


function love.draw()
	push.start()
    sceneManager:draw()
	push.finish()
end


function love.mousepressed()
    sceneManager:mousepressed()
end


function love.mousereleased()
    sceneManager:mousereleased()
end


function love.resize(w, h)
	return push.resize(w, h)
end


