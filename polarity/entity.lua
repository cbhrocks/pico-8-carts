entity = {
    -- sprite id
    s_id=nil,
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
    vy = 0
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
end

function entity:move(new_x, new_y)
    self.x = new_x
    self.y = new_y
end

function entity:update(time)
    -- update velocity based on acceleration value
    self.vx = mid(-self.mv, self.vx + (self.dx * time), self.mv)
    self.vy = mid(-self.mv, self.vy + (self.dy * time), self.mv)

    self.x += self.vx
    self.y += self.vy
end