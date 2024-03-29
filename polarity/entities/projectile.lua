projectile = {
    duration = 2,
    s_id=16,
    dead = false
}
projectile.__index=projectile

setmetatable(projectile, {__index=entity})

function projectile:update(time)
    if (self.duration < 0) then
        self.dead = true
    else
        self.duration -= time
    end
    entity.update(self, time)
end
