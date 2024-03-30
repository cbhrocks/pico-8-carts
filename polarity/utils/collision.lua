
function colliding(a, b)
    if a.ht == 'box' and b.ht == 'box' then
        for i, polygon in {a, b} do
            local points = polygon:get_hit_pionts()
            for i1=0, #points do -- for each point thats connected
                local i2 = i1 + 1 % 4
                local p1,p2 = points[i1],points[i2]
                local normal = {p2[1] - p1[1], p1[0] - p2[0]}

                local mina,maxa
                for i,p in a.get_hit_pionts() do
                    local projected = normal[0] * p[0] + normal[1] * normal[1]
                    if (mina == nil || projected < mina) then
                        mina = projected
                    end
                    if (maxa == nil || projected > maxa) then
                        maxa = projected
                    end
                end

                local minb,maxb
                for i,p in b.get_hit_pionts() do
                    local projected = normal[0] * p[0] + normal[1] * normal[1]
                    if (minb == nil || projected < minb) then
                        minb = projected
                    end
                    if (maxb == nil || projected > maxb) then
                        maxb = projected
                    end
                end

                if (maxa < minb || maxb < mina) then
                    return false
                end
            end
        end
    end
    return true
end