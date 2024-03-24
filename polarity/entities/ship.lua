ship = {
}
ship.__index = ship

setmetatable(ship, {__index=entity})

function ship:draw()
    circfill(self.x,self.y,2,7)
end

function ship:control(left,right,up,down)
    -- update change in velocity using max acceleration
    self.dx = 0
    self.dy = 0
    if (left) self.dx -= self.accel
    if (right) self.dx += self.accel
    if (up) self.dy -= self.accel
    if (down) self.dy += self.accel
end

--https://gamedevacademy.org/lua-inheritance-tutorial-complete-guide/