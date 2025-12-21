
local font
local width, height
local titleText
local size = 1.0
local time = 0.0
local rotation = 0.0

local buttonTexts = {
    "GAME TITLE",
    "PLAY",
    "QUIT",
}
local buttons = {}


function love.load()
    print("Test")
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    font = love.graphics.newFont("assets/Lexend.ttf", 18)
    for _i=1,#buttonTexts do
        local newText = love.graphics.newText(font, buttonTexts[_i])
        createButton(newText)
    end
end


function love.update(dt)
    time = time + dt

    size = (math.cos(time) + 8.0)/8.0
    rotation = (math.cos(time*2.0))/8.0
end


function love.mousereleased()
    if isMouseOnButton(buttons[2]) then
        print("Pressed Play!")
    end
end


function love.draw()
    for _i,button in ipairs(buttons) do
        local x, y = width/2.0, height/#buttons * _i - (height/#buttons/2.0)
        
        button.x = x
        button.y = y

        button.w = button.text:getWidth()
        button.h = button.text:getHeight()
        
        local size_mod = 1.0

        if isMouseOnButton(button) then
            size_mod = 2.0
        end
        
        button.size = lerp(button.size, size * size_mod, 0.5)

        love.graphics.draw(
            button.text,
            button.x,
            button.y,
            rotation,
            button.size,
            button.size,
            button.w/2.0,
            button.h/2.0
        )
    end
end


function createButton(text)
    local button = {}
    button.text = text
    button.x = 0
    button.y = 0
    button.w = 512
    button.h = 32
    button.size = 1.0

    table.insert(buttons, button)
end


function isMouseOnButton(button)
    local offset_x = button.x - (button.w/2.0)
    local offset_y = button.y - (button.h/2.0)

    return love.mouse.getX() >= offset_x
    and love.mouse.getX() < offset_x + button.w
    and love.mouse.getY() >= offset_y
    and love.mouse.getY() < offset_y + button.h
end

function lerp(a,b,t) return (1-t)*a + t*b end