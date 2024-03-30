projectile = {
    duration = 2,
    s_id=16,
}
projectile.__index=projectile

setmetatable(projectile, {__index=entity})

function projectile:draw()
    --entity.draw(self)
    rspr(self.s_id, self.x-4, self.y-4, atan2(self.vx, self.vy), self.w, self.h)
    --pd_rotate(self.x, self.y, atan2(self.vx, self.vy), 4, 4, self.w)
end

function projectile:update(time)
    if (self.duration < 0) then
        self.dead = true
    else
        self.duration -= time
    end
    entity.update(self, time)
end
