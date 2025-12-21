
local font
local width, height
local titleText
local r = 0


function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    font = love.graphics.newFont("assets/Lexend.ttf", 18)
    titleText = love.graphics.newText(font, "Bideo gane")

end


function love.update()
    r = r + 0.01
end


function love.draw()
    local x, y = (width/2.0) - (titleText:getWidth()/2.0), (height/2.0) - (titleText:getHeight()/2.0)

    love.graphics.draw(titleText, x, y, r)

end

