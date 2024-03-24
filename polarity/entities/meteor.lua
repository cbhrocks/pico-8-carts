meteor = {
    -- how far its rotated
    orientation = 0
}
meteor.__index = meteor

setmetatable(meteor, {__index=entity})

function meteor:draw()
    circfill(self.x,self.y,2,7)
end

function meteor:place(new_x, new_y)
    self.x = new_x
    self.y = new_y
    self.rotation = rnd(2) - 1
end

function meteor:update(time)
    -- update velocity based on acceleration value
    
    entity.update(self)
    self.
end

--https://gamedevacademy.org/lua-inheritance-tutorial-complete-guide/