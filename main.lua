local camera
local sceneManager

GameWidth, GameHeight = 320, 180 --fixed game resolution
local windowWidth, windowHeight = 1280, 720
local push = require "lib.push"

PI = 3.14159
Font = nil
FontLexend = love.graphics.newFont("assets/Lexend.ttf", 16)

local debugText = "Powerski made with Löve2D\nAssets by kenney\nMusic by korewakosu"
local footer = love.graphics.newText(
	FontLexend, {{0, 0, 0}, debugText}	
)


function love.load()
    Object = require "lib.classic"
    require "scene_manager"
	require "audio"

    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")
	love.window.setTitle("LOVESKI")

	love.window.setMode(1280, 720, {resizable=true, vsync=true})

	push.setupScreen(
		GameWidth,
		GameHeight,
		{upscale="normal"}
	)
	
	Font = love.graphics.newFont("assets/DigitalDiscoOutline.ttf", 16)
    
	sceneManager = SceneManager()
	Audio()
end


function love.update(dt)
    sceneManager:update(dt)
end


function love.draw()
	push.start()
    sceneManager:draw()
	push.finish()

	local text = string.format("%s\n\nFPS: %s", debugText, tostring(love.timer.getFPS()))
	footer:setf({{0, 0, 0}, text}, 9999, "left")

	love.graphics.draw(footer)
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


