function rotate_around(o, p, a)
    -- printh("origin"..o.x..", "..o.y.."", "log")
    -- printh("point"..p.x..", "..p.y.."", "log")
    local s = sin(-a)
    local c = cos(a)
    p.x = ((p.x - o.x) * c) - ((p.y - o.y) * s) + o.x
    p.y = ((p.x - o.x) * s) + ((p.y - o.y) * c) + o.y
    -- printh("final"..p.x..", "..p.y.."", "log")
end

function normalize(x, y)
    local d = sqrt(x^2 + y^2)
    return {x=x/d, y=y/d}
end
