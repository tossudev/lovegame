Menu = Object:extend()


function Menu:new()
    require "button"
    require "camera"
    require "main"

    self.camera = Camera()
    self.buttons = {}

    self.width = love.graphics.getWidth()
    self.height = love.graphics.getHeight()
    self.backgroundImage = love.graphics.newImage(
        "assets/textures/background.png"
    )

    self:createButtons()
end


function Menu:update(dt)
    for _i,_button in ipairs(self.buttons) do
        _button:update(dt)
    end
end


function Menu:draw()
    self.camera:draw()
    love.graphics.draw(self.backgroundImage)

    for _i,_button in ipairs(self.buttons) do
        _button:draw()
    end
end


function Menu:mousepressed()
    for _i,_button in ipairs(self.buttons) do
        _button:mousepressed()
    end
end


function Menu:mousereleased()
    for _i,_button in ipairs(self.buttons) do
        _button:mousereleased()
    end
end


function Menu:createButtons()
    local buttonTexts = {
        {"LOVESKI", nil},
        {"Play", self.pressedPlay},
        {"Quit", self.pressedQuit},
    }

    for _i,buttonValues in ipairs(buttonTexts) do
        local animOffset = 0.2 * _i
        -- scuffed positioning fix immediate !!
        local newButton = Button(
            160,
            40 * _i,
            buttonValues,
            animOffset,
            self.camera
        )
        table.insert(self.buttons, newButton)
    end
end


function Menu:lerp(a,b,t) return (1-t)*a + t*b end


function Menu:pressedQuit()
    love.event.quit()
end


function Menu:pressedPlay()
    S:changeScene("game")
end