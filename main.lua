
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

-- spring test
local rigidness = 0.1
local damping = 0.2
local velocity = 0.0
local spring_destination = 1.0


function love.load()
    print("Test")
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    font = love.graphics.newFont("assets/Lexend.ttf", 64)
    for _i=1,#buttonTexts do
        local newText = love.graphics.newText(font, buttonTexts[_i])
        createButton(newText)
    end
end


function love.update(dt)
    time = time + dt

    size = (math.cos(time) + 20.0)/20.0
    rotation = (math.cos(time*2.0))/12.0
end


function love.mousepressed()
    if isMouseOnButton(buttons[2]) then
        buttons[2].size = 0.5
    end
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

        if isMouseOnButton(button) then
            print(button)
            button.size = 1.5
        else
            spring(button)
        end

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

function spring(button)
    local distance_to_dest = button.size - spring_destination
    local loss = damping * velocity

    -- hooke's law
    local force = -rigidness * distance_to_dest - loss

    velocity = velocity + force
    button.size = button.size + velocity

end