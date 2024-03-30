gun = {
    x = 0,
    y = 0,
    vx = 0,
    vy = 0,
    -- delay before shot is fired (charging up)
    delay = 0,
    -- how quickly can shoot again
    rate = 1,
    -- while shooting 
    shooting = false,
    remaining_delay = 0,
    p_props = {}
}

gun.__index=gun

function gun:new(o)
    return setmetatable(o or {}, self)
end

function gun:update(time)
    if (self.remaining_delay > self.delay) then
        self.remaining_delay -= time
    elseif (self.shooting) then
        self.shooting = false
        self.remaining_delay -= time
    else
        self.remaining_delay = self.delay
    end
end

function gun:shoot(o, direction)
    if (self.remaining_delay <= 0) then
        --shoot
        add(o.projectiles, projectile:new({
            unpack(self.p_props), 
            x=self.x, 
            y=self.y,
            w=1,
            h=1,
            vx=self.vx + cos(direction),
            vy=self.vy + sin(direction)
        }))
        self.remaining_delay = self.rate + self.delay
    end
    self.shooting = true
end