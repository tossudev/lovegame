Button = Object:extend()

Font = love.graphics.newFont("assets/DigitalDiscoOutline.ttf", 16)

local rigidness = 0.1
local damping = 0.2


function Button:new(_x, _y, _buttonValues, _animOffset, _camera)
    self.x, self.y = _x, _y
    self.size = 1.0
    self.velocity = 0.0
    self.rotation = 0.0
    self.time = 0.0
    self.animOffset = _animOffset
    self.shaking = false
    self.shakeFrames = 0
    self.camera = _camera
    self.callFunction = _buttonValues[2]

    local newText = love.graphics.newText(Font, {{0, 0, 0}, _buttonValues[1]})
    self.text = newText

    self.w = self.text:getWidth()
    self.h = self.text:getHeight()
end


function Button:update(dt)
    self.time = self.time + dt

    self.rotation = (math.cos((self.time+self.animOffset)*2.0))/12.0

    if self:isMouseOnButton() then
        self.spring_destination = 1.5
    else
        self.spring_destination = (math.cos(self.time + self.animOffset) + 8.0)/8.0
    end

    self:spring()
end


function Button:draw()
    love.graphics.draw(
        self.text,
        self.x,
        self.y,
        self.rotation,
        self.size,
        self.size,
        self.w/2.0,
        self.h/2.0
    )

    -- draw bounding box for debugging
    -- love.graphics.rectangle(
    --     "line",
    --     self.x - self.w/2.0,
    --     self.y - self.h/2.0,
    --     self.w,
    --     self.h
    -- )
end


function Button:mousepressed()
    if self:isMouseOnButton() then
        self.spring_destination = 0.5
    end
end


function Button:mousereleased()
    if self:isMouseOnButton() then
        self.camera:shake()
        -- print("Pressed Button!")

        -- idk this seems a little scuffed but it works
        if self.callFunction ~= nil then
            self.callFunction()
        end
    end
end


function Button:spring()
    local distance_to_dest = self.size - self.spring_destination
    local loss = damping * self.velocity

    -- hooke's law
    local force = -rigidness * distance_to_dest - loss

    self.velocity = self.velocity + force
    self.size = self.size + self.velocity
end


function Button:isMouseOnButton()
    -- returns scaled pixels
    local mousePosX, mousePosY = love.mouse.getX(), love.mouse.getY()

    local offset_x = (self.x - (self.w/2.0))*PixelRatio
    local offset_y = (self.y - (self.h/2.0))*PixelRatio

    return mousePosX >= offset_x
    and mousePosX < offset_x + self.w*PixelRatio
    and mousePosY >= offset_y
    and mousePosY < offset_y + self.h*PixelRatio
end