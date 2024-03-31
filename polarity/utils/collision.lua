-- https://stackoverflow.com/questions/10962379/how-to-check-intersection-between-2-rotated-rectangles
function colliding(a, b)
    if a.ht == 'box' and b.ht == 'box' then
        for i, polygon in pairs({a, b}) do
            local points = polygon:get_hit_points()
            for i1=1, #points do -- for each point thats connected
                local i2 = i1 + 1
                if (i1 == #points) i2 = 1
                local p1 = points[i1]
                local p2 = points[i2]
                local normal = {p2[2] - p1[2], p1[1] - p2[1]}

                local mina,maxa
                for i,p in pairs(a:get_hit_points()) do
                    local projected = normal[1] * p[1] + normal[2] * p[2]
                    if (mina == nil or projected < mina) then
                        mina = projected
                    end
                    if (maxa == nil or projected > maxa) then
                        maxa = projected
                    end
                end

                local minb,maxb
                for i,p in pairs(b:get_hit_points()) do
                    local projected = normal[1] * p[1] + normal[2] * p[2]
                    if (minb == nil or projected < minb) then
                        minb = projected
                    end
                    if (maxb == nil or projected > maxb) then
                        maxb = projected
                    end
                end

                if (maxa < minb or maxb < mina) then
                    return false
                end
            end
        end
    end
    return true
end
