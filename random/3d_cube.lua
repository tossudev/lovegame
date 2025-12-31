local w = 640
local h = 480
local zOffset = 1.0
local rotationAngle = 0.0
local time = 0.0
PI = 3.141592

local points = {
    {-0.25, -0.25, -0.25},
    {0.25, -0.25, -0.25},
    {0.25, 0.25, -0.25},
    {-0.25, 0.25, -0.25},

    {-0.25, -0.25, 0.25},
    {0.25, -0.25, 0.25},
    {0.25, 0.25, 0.25},
    {-0.25, 0.25, 0.25}
}

local lines = {
    {1, 2},
    {2, 3},
    {3, 4},
    {4, 1},

    {5, 6},
    {6, 7},
    {7, 8},
    {8, 5},

    {1, 5},
    {2, 6},
    {3, 7},
    {4, 8},
}


function love.load()
    -- love.window.setMode(w, h)
end


function love.update(dt)
    time = time + dt
    rotationAngle = rotationAngle + dt
    -- zOffset = math.cos(time)
end


function love.draw()
    -- for _, point in ipairs(points) do
    --     local x, y = translatePos(project(translate_z(rotate_xz(point[1], point[2], point[3], rotationAngle))))
    --     love.graphics.circle("fill", x - 1, y - 1, 2)
    -- end

    for _, line in ipairs(lines) do
        local point1 = points[line[1]]
        local x1, y1 = translatePos(project(translate_z(rotate_xz(point1[1], point1[2], point1[3], rotationAngle))))
        
        local point2 = points[line[2]]
        local x2, y2 = translatePos(project(translate_z(rotate_xz(point2[1], point2[2], point2[3], rotationAngle))))

        love.graphics.line(x1, y1, x2, y2)
    end
end

-- -1..1 -> 0..2 -> 0..1 -> 0..w
function translatePos(x, y)
    x = (x+1.0)/2.0 * w
    y = (1.0 - (y+1.0)/2.0) * h
    return x, y
end

-- 2d vector rotation
-- x′=xcosθ−ysinθ and y′=xsinθ+ycosθ.

-- 3d vector rotation
--    |cos θ   −sin θ   0| |x|   |x cos θ − y sin θ|   |x'|
--    |sin θ    cos θ   0| |y| = |x sin θ + y cos θ| = |y'|
--    |  0       0      1| |z|   |        z        |   |z'|

--    |1     0           0| |x|   |        x        |   |x'|
--    |0   cos θ    −sin θ| |y| = |y cos θ − z sin θ| = |y'|
--    |0   sin θ     cos θ| |z|   |y sin θ + z cos θ|   |z'|

function rotate_xz(x, y, z, angle)
    local c = math.cos(angle)
    local s = math.sin(angle)

    -- y-axis
    local _x = x*c-z*s
    local _z = x*s+z*c

    -- z-axis
    local _x2 = _x*c-y*s
    local _y = _x*s+y*c

    -- x-axis
    local _y2 = _y*c-_z*s
    local _z2 = _y*s+_z*c

    -- return all rotations
    return _x2, _y2, _z2
end


function translate_z(x, y, z)
    return x, y, z + zOffset
end


function project(x, y, z)
    x = x/z
    y = y/z
    return x, y
end