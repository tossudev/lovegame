Game = Object:extend()
Tileset = love.graphics.newImage("assets/textures/tileset.png")

-- textures
local tBackgroundTop = love.graphics.newImage("assets/textures/background.png")
local tBackgroundBottom = love.graphics.newImage("assets/textures/background.png")

local player
local speedScale = 0.5 -- speed multiplier per second
local baseSpeed = 64.0 -- pixels per second
local obstacleSpawnInterval = 0.5

local chancePickup = 2
local chanceObstacle = 100

local obstacles = {}


function Game:new()
    require "player"
    require "obstacle"
    player = Player()
    
    self.bgPos = 0.0
    self.speed = 1.0
    self.spawnCooldown = obstacleSpawnInterval
end


function Game:update(dt)
    if self:checkCollision() then
        S:changeScene("menu")
    end


    self.spawnCooldown = self.spawnCooldown - dt

    if self.spawnCooldown <= 0.0 then
        self.spawnCooldown = obstacleSpawnInterval
        self:spawnObstacle()
    end

    if love.mouse.isDown(1) then
        self.speed = self.speed + (speedScale*dt)
    else
        self.speed = 1.0
    end

    for _, obstacle in ipairs(obstacles) do
        obstacle:update(baseSpeed * (self.speed/60.0))
    end

    if love.keyboard.isDown("escape") then
        S:changeScene("menu")
    end


    player:update(dt)
end


function Game:draw()
    self.bgPos = self.bgPos - baseSpeed * (self.speed/60.0)
    local bgHeight = tBackgroundBottom:getHeight()

    if math.abs(self.bgPos) >= bgHeight then
        self.bgPos = 0.0
    end

    love.graphics.draw(
        tBackgroundTop,
        0, self.bgPos
    )
    love.graphics.draw(
        tBackgroundBottom,
        0, self.bgPos + bgHeight
    )

    for _, obstacle in ipairs(obstacles) do
        obstacle:draw()
    end

    player:draw(baseSpeed * (self.speed/60.0))
end


function Game:mousepressed()
end
function Game:mousereleased()
end


function Game:spawnObstacle()
    local obstacle = Obstacle()
    table.insert(obstacles, obstacle)
end


function Game:checkCollision()
    if #obstacles < 1 then
        return
    end

    local playerCollider = player.collider

    for _, obstacle in ipairs(obstacles) do
        local obstacleCollider = obstacle.collider
        
        local a_left = playerCollider[1]
        local a_top = playerCollider[2]
        local a_right = playerCollider[1] + playerCollider[3]
        local a_bottom = playerCollider[2] + playerCollider[4]

        local b_left = obstacleCollider[1]
        local b_top = obstacleCollider[2]
        local b_right = obstacleCollider[1] + obstacleCollider[3]
        local b_bottom = obstacleCollider[2] + obstacleCollider[4]

        if a_right > b_left
            and a_left < b_right
            and a_bottom > b_top
            and a_top < b_bottom then
            return true
        end
    end

    return false
end