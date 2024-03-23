ship = {
    speed = 5,
}
ship.__index = ship

setmetatable(ship, {__index=entity})

function ship:draw()
    circfill(63,63,2,7)
end

--https://gamedevacademy.org/lua-inheritance-tutorial-complete-guide/