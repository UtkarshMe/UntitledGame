local util = {}

function util.is_over(obj1, obj2)
    if  obj1.x > obj2.x and obj1.x < obj2.x + obj2.width
    and obj1.y > obj2.y and obj1.y < obj2.y + obj2.height then
        return true
    else
        return false
    end
end

return util
