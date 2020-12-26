-- skin object table, used for defining collections of DST calls which can all
-- be offset by a certain amount
--
-- dst objects where can either be either:
-- * beatoraja dst tables
-- * functions of the form `func(skin, origin_x, origin_y)`

local skin_object = {
    origin_x = 0, origin_y = 0, dst = {},

    apply = function (self, skin)
        print("#self.dst = " .. #self.dst)
        for _,item in pairs(self.dst) do
            if type(item) == "table" then
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
            elseif type(item) == "function" then
                item(skin, self.origin_x, self.origin_y)
            end
        end
    end,
}

function skin_object.new(dst, x, y)
    return {
        origin_x = x, origin_y = y, dst = dst,
        apply = skin_object.apply
    }
end

return skin_object
