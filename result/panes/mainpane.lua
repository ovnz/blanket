local main_state = require("main_state")

local prop = require("prop")
local SkinObject = require("skin_object")

local util = require("result/util")
local widgets = require("result/widgets")

local function main_pane(t)
    local frame_x, frame_w = 0, 512

    if t.flip then
        frame_x, frame_w = frame_w, -frame_w
    end

    return {
        { id = "bg_frame", dst = {{ x = frame_x, y =  0, w = frame_w, h = 952 }} },
        -- flashing animation
        { id = "bg_frame", loop = 1, dst = {
            { time =    0, x = frame_x, y = 0, w = frame_w, h = 952, a = 150 },
            { time = 2000, x = frame_x, y = 0, w = frame_w, h = 952, a =  64 },
        } },

        SkinObject:new(widgets.gauge_graph.f(t),     24, 672),
        SkinObject:new(widgets.score_info.f(t),      24, 405),
        SkinObject:new(widgets.misscount_combo.f(t), 24, 319),
        SkinObject:new(widgets.judge_detail.f(t),    24, 110),
        SkinObject:new(widgets.fs_combo_break.f(t),  24,  24),
    }
end

return main_pane
