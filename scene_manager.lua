SceneManager = Object:extend()


function SceneManager:new()
    S = self
    Object = require "classic"
    require "camera"
    require "menu"
    require "game"

    self.camera = Camera()
    self:changeScene("menu")
end


function SceneManager:draw()
    self.currentScene:draw()
end



function SceneManager:update(dt)
    self.currentScene:update(dt)
end


function SceneManager:mousepressed()
    self.currentScene:mousepressed()
end


function SceneManager:mousereleased()
    self.currentScene:mousereleased()
end


function SceneManager:changeScene(newScene)
    if newScene == "game" then
        self.currentScene = Game()
    elseif newScene == "menu" then
        self.currentScene = Menu()
    end
end