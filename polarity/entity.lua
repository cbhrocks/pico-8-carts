

entity = {
    e_type = 'player',
    -- sprite id, width, height
    s_id=nil,
    w=1,
    h=1,
    -- position
    x=63,
    y=63,
    -- rate of acceleration
    accel = 5,
    -- max velocity
    mv = 20,
    -- acceleration (pixels per second)
    dx = 0,
    dy = 0,
    -- velocity
    vx = 0,
    vy = 0,
    -- gun id
    g = nil,
    dead = false,
    -- hit box height & width
    hh = 4,
    hw = 4,
    ht = 'box'
}
entity.__index=entity

function entity:new(o)
    return setmetatable(o or {}, self)
end

function entity:draw()
    if (self.s_id == nil) then
        circ(self.x,self.y,5,7)
    else
        spr(self.s_id, self.x-4,self.y-4,1,1)
    end
    local points = self:get_hit_points()
    line(points[1][1], points[1][2], points[2][1], points[2][2])
    line(points[2][1], points[2][2], points[3][1], points[3][2])
    line(points[3][1], points[3][2], points[4][1], points[4][2])
    line(points[4][1], points[4][2], points[1][1], points[1][2])
end

function entity:move(new_x, new_y)
    self.x = new_x
    self.y = new_y
end

function entity:update(time)
    if (self.g) then 
        self.g.x = self.x
        self.g.y = self.y
        self.g.vx = self.vx
        self.g.vy = self.vy
        self.g:update(time)
    end
    -- update velocity based on acceleration value
    self.vx = mid(-self.mv, self.vx + (self.dx * time), self.mv)
    self.vy = mid(-self.mv, self.vy + (self.dy * time), self.mv)

    self.x += self.vx
    self.y += self.vy
end

function entity:shoot(world, direction)
    self.g:shoot(world, direction)
end

function entity:get_hit_points()
    return {
        {self.x-self.hw, self.y-self.hh}, --top left
        {self.x-self.hw, self.y+self.hh}, --bottom left
        {self.x+self.hw, self.y+self.hh}, --bottom right
        {self.x+self.hw, self.y-self.hh}, --top right
    }
end
