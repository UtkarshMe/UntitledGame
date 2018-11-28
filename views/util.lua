local util = {}

function util.is_over(obj1, obj2, offset)
    offset = offset or { x = 0, y = 0 }
    if  obj1.x > obj2.x + offset.x
            and obj1.x < obj2.x + obj2.width + offset.x
            and obj1.y > obj2.y + offset.y
            and obj1.y < obj2.y + obj2.height + offset.y then
        return true
    else
        return false
    end
end

return util
