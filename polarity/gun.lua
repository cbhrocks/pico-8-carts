gun = {
    x = 0,
    y = 0,
    -- delay before shot is fired (charging up)
    delay = 0,
    -- how quickly can shoot again
    rate = 1,
    -- while shooting 
    shooting = false,
    remaining_delay = 0,
    sfx = 63
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
    -- needs to be implemented!
    return nil
end


guns = {
    plasma = gun:new({
        shoot=function(s, state, direction)
            if (s.remaining_delay <= 0) then
                add(state.projectiles, entity:new({
                    x=s.x,
                    y=s.y,
                    vx=state.player.vx + cos(direction) * 2,
                    vy=state.player.vy + sin(direction) * 2,
                    duration = 2,
                    s_id = 17,
                    draw = function(o)
                        for p in all(o.particles) do
                            p:draw()
                        end
                        if not o.dead then
                            rspr(o.s_id, o.x-4, o.y-4, atan2(o.vx, o.vy), o.w, o.h)
                        end
                    end,
                    update = function(o, time)
                        entity.update(o, time)
                        -- add particles after, so they draw where they spawn
                        if (not o.dead) do
                            add(o.particles, entity:new({
                                duration=rnd(.075)+.075,
                                x=o.x,
                                y=o.y,
                                draw=function(o)
                                    pset(o.x, o.y, 1)
                                end
                            }))
                        end
                    end,
                    onhit = function(s, o)
                        s.dead = true
                        o.dead = true
                    end
                }))
                s.remaining_delay = s.rate + s.delay
                sfx(s.sfx, -1, 0, 2)
            end
            s.shooting = true
        end
    }),
    laser = gun:new({
        range=50,
        shoot=function(s, state, direction)
            if (s.remaining_delay <= 0) then
                add(state.projectiles, entity:new({
                    x=s.x,
                    y=s.y,
                    vx=cos(direction) * s.range,
                    vy=sin(direction) * s.range,
                    duration = .3,
                    draw = function(o)
                        line(o.x, o.y, o.x + o.vx, o.y + o.vy, 11)
                    end,
                    update = function(o, time)
                        if o.duration ~= nil then
                            if (o.duration < 0) then
                                o.dead = true
                            else
                                o.duration -= time
                            end
                        end
                    end,
                    hb = {
                        t='line'
                    },
                    get_hit_box=function(o)
                        return {{o.x, o.y}, {o.x+o.vx, o.y+o.vy}}
                    end,
                    onhit=function(s, o)
                        o.dead = true
                    end
                }))
                s.remaining_delay = s.rate + s.delay
                sfx(s.sfx, -1, 2, 2)
            end
            s.shooting = true
        end
    })
}