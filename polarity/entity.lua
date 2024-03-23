entity = {
    x=63,
    y=63
}
entity.__index=entity

function entity:new(o)
    return setmetatable(o or {}, self)
end

function entity:draw()
    circ(self.x,self.y,5,7)
end

function entity:move(new_x, new_y)
    self.x = new_x
    self.y = new_y
end