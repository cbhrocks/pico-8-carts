meteor = {
    -- how far its rotated
    orientation = 0
}
meteor.__index = meteor

setmetatable(meteor, {__index=entity})

function meteor:draw()
    circfill(self.x,self.y,2,8)
end

function meteor:update(time)
    -- update velocity based on acceleration value
    
    entity.update(self, time)
end

function meteor:rotate(time, speed)

end

--https://gamedevacademy.org/lua-inheritance-tutorial-complete-guide/