-- skin object table, used for defining collections of DST calls which can all
-- be offset by a certain amount
--
-- dst objects can be either:
-- * beatoraja dst tables
-- * functions of the form `func(skin, origin_x, origin_y)`
-- * other skin objects

local SkinObject = {
    origin_x = 0, origin_y = 0, dst = {},

    apply = function (self, skin)
        print("#self.dst = " .. #self.dst)
        for _,item in pairs(self.dst) do
            if type(item) == "table" then
                if item.is_skin_object then
                    -- item is a SkinObject
                    local old_x, old_y = item.origin_x, item.origin_y
                    item.origin_x = item.origin_x + self.origin_x
                    item.origin_y = item.origin_y + self.origin_y
                    item:apply(skin)
                    item.origin_x, item.origin_y = old_x, old_y
                else
                    -- item is a DST call
                    local t_item = {}

                    for key,val in pairs(item) do
                        if key ~= "dst" then
                            t_item[key] = val
                        end
                    end

                    t_item.dst = {}

                    for _,anim in pairs(item.dst) do
                        local t_anim = {}
                        for key,val in pairs(anim) do
                            t_anim[key] = val
                        end
                        t_anim.x = anim.x + self.origin_x
                        t_anim.y = anim.y + self.origin_y
                        table.insert(t_item.dst, t_anim)
                    end

                    table.insert(skin.destination, t_item)
                end
            elseif type(item) == "function" then
                    -- item is a function
                item(skin, self.origin_x, self.origin_y)
            end
        end
    end,
}

function SkinObject:new(dst, x, y)
    local obj = { origin_x = x, origin_y = y, dst = dst, is_skin_object = true }
    local meta = { __index = self }
    return setmetatable(obj, meta)
end

return SkinObject
