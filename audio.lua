Audio = Object:extend()

local song = love.audio.newSource("assets/sound/song.ogg", "stream")

local sSwerve = love.audio.newSource("assets/sound/swerve.wav", "static")
local sClickStart = love.audio.newSource("assets/sound/click_start.wav", "static")
local sClickEnd = love.audio.newSource("assets/sound/click_end.wav", "static")
local sDamage = love.audio.newSource("assets/sound/damage.wav", "static")


function Audio:new()
	love.audio.setVolume(0.5)
	love.audio.play(song)
end


function Audio:playSound(name)
	if name == "swerve" then
		love.audio.play(sSwerve)
	elseif name == "click_start" then
		love.audio.play(sClickStart)
	elseif name == "click_end" then
		love.audio.play(sClickEnd)
	elseif name == "damage" then
		love.audio.play(sDamage)
	end
end

