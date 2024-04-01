projectile = {
    duration = 2,
    s_id=17,
    particles={}
}
projectile.__index=projectile

setmetatable(projectile, {__index=entity})

function projectile:draw()
    rspr(self.s_id, self.x-4, self.y-4, atan2(self.vx, self.vy), self.w, self.h)
    for p in all(self.particles) do
        printh('drawing particle', 'log')
        p:draw()
    end
end

function projectile:update(time)
    entity.update(self, time)
    -- add particles after, so they draw where they spawn
    printh('adding particle', 'log')
    add(self.particles, entity:new({
        duration=1,
        x=self.x,
        y=self.y,
        draw=function(o)
            pset(o.x, o.y, 1)
        end,
    }))
end
