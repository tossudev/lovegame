
local time = 0.0

local tex = love.graphics.newImage("image.png")
local shader


function love.load()
	shader = love.graphics.newShader("3d_shader.glsl")
end


function love.update(dt)
	time = time + dt
	shader:send("time", time)
	--shader:send("iResolutionX", love.graphics.getWidth())
	--shader:send("iResolutionY", love.graphics.getHeight())
end


function love.draw()
	love.graphics.setShader(shader)
	love.graphics.draw(tex)
	love.graphics.setShader()
end
