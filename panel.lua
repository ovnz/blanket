local source_inserted = false

-- returns a dst table to use for initialising SkinObjects
-- `t` can/should contain:
--  * w, h: size of the panel
--  * rounded: array of 4 booleans specifying which corners should be rounded
--    clockwise from the top-left corner
--  * titlebar: boolean specifying whether this panel should have a title bar
--  * dark_mode: boolean specifying whether this should use dark mode
local function panel(t)
    local obj = {
        -- insert source and images
        function(skin)
            if source_inserted == true then return nil end
            source_inserted = true
            table.insert(skin.source, { id = "panel", path = "panel.png" })
            local images = {
                { id = "panel-corner-rounded",     src = "panel", x =  0,  y = 0, w = 24, h = 24 },
                { id = "panel-corner-rounded-bar", src = "panel", x =  25, y = 0, w = 24, h = 24 },
                { id = "panel-corner-square",      src = "panel", x =  50, y = 0, w = 24, h = 24 },
                { id = "panel-corner-square-bar",  src = "panel", x =  75, y = 0, w = 24, h = 24 },
                { id = "panel-top-bar",            src = "panel", x = 100, y = 0, w = 24, h = 24 },
                { id = "panel-body",               src = "panel", x =  50, y = 0, w = 24, h = 24 },
            }
            for _,v in pairs(images) do table.insert(skin.image, v) end
        end
    }

    local dst = {}
    local id

    t.w, t.h = t.w or 64, t.h or 64

    -- bottom left
    if t.rounded[4] then id = "panel-corner-rounded" else id = "panel-corner-square" end
    table.insert(dst, { id = id, dst = {{ x =   0, y = 24, w =  24, h = -24 }} })

    -- bottom right
    if t.rounded[3] then id = "panel-corner-rounded" else id = "panel-corner-square" end
    table.insert(dst, { id = id, dst = {{ x = t.w, y = 24, w = -24, h = -24 }} })

    -- top right
    if t.rounded[2] then id = "panel-corner-rounded" else id = "panel-corner-square" end
    if t.titlebar then id = id .. "-bar" end
    table.insert(dst, { id = id, dst = {{ x = t.w, y = t.h - 24, w = -24, h = 24 }} })

    -- top left
    if t.rounded[1] then id = "panel-corner-rounded" else id = "panel-corner-square" end
    if t.titlebar then id = id .. "-bar" end
    table.insert(dst, { id = id, dst = {{ x =   0, y = t.h - 24, w =  24, h = 24 }} })

    -- top
    if t.titlebar then id = "panel-top-bar" else id = "panel-body" end
    table.insert(dst, { id = id, dst = {{ x = 24, y = t.h - 24, w = t.w - 48, h = 24 }} })

    id = "panel-body"

    -- left
    table.insert(dst, { id = id, dst = {{ x =   0, y = 24, w =       24, h = t.h - 48 }} })

    -- right
    table.insert(dst, { id = id, dst = {{ x = t.w, y = 24, w =      -24, h = t.h - 48 }} })

    -- bottom
    table.insert(dst, { id = id, dst = {{ x =  24, y =  0, w = t.w - 48, h =       24 }} })

    -- body
    table.insert(dst, { id = id, dst = {{ x =  24, y = 24, w = t.w - 48, h = t.h - 48 }} })

    for _,v in pairs(dst) do
        for _,anim in pairs(v.dst) do
            if not t.dark_mode then
                anim.r, anim.g, anim.b = 0, 0, 0
            end
            anim.a = 32
        end
        table.insert(obj, v)
    end

    return obj
end

return panel
