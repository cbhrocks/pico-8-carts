ship = {
    s_id=0,
}
ship.__index = ship

setmetatable(ship, {__index=entity})

function ship:draw()
    if (self.dx < 0) then
        line(self.x, self.y, self.x+4, self.y, 8)
        line(self.x, self.y-1, self.x+4, self.y-1, 8)
    end
    if (self.dx > 0) then
        line(self.x, self.y, self.x-5, self.y, 8)
        line(self.x, self.y-1, self.x-5, self.y-1, 8)
    end
    if (self.dy < 0) then
        line(self.x, self.y, self.x, self.y+4, 8)
        line(self.x-1, self.y, self.x-1, self.y+4, 8)
    end
    if (self.dy > 0) then
        line(self.x, self.y, self.x, self.y-5, 8)
        line(self.x-1, self.y, self.x-1, self.y-5, 8)
    end
    entity.draw(self)
end

function ship:control(left,right,up,down)
    -- update change in velocity using max acceleration
    self.dx = 0
    self.dy = 0
    if (left) then
        self.dx -= self.accel
        line(self.x, self.y, self.x+10, self.y, 8)
    end
    if (right) self.dx += self.accel
    if (up) self.dy -= self.accel
    if (down) self.dy += self.accel
end

--https://gamedevacademy.org/lua-inheritance-tutorial-complete-guide/