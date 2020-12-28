local main_state = require("main_state")

local prop = require("prop")
local SkinObject = require("skin_object")

local util = require("result/util")
local mainpane = require("result/pane/mainpane")

local function append_all(t1, t2)
    for _, v in pairs(t2) do
        table.insert(t1, v)
    end
end

local function get_widgets()
    local all = {}
    append_all(all, mainpane.objects)

    -- returns the widget corresponding to the specified op
    local function find(op)
        if op == nil then return nil end
        for k, widget in pairs(all) do
            if widget.op == op then return widget end
        end
        return nil
    end

    local function check_op(op)
        if op == prop.prop.custom_off then return nil
        else return op end
    end

    local widgets = {
        find(check_op(skin_config.option["Widget 1"])),
        find(check_op(skin_config.option["Widget 2"])),
        find(check_op(skin_config.option["Widget 3"])),
        find(check_op(skin_config.option["Widget 4"])),
        find(check_op(skin_config.option["Widget 5"])),
    }

    return widgets
end

local function custom_pane(t)
    local frame_x, frame_w = 0, 512

    if t.flip then
        frame_x, frame_w = frame_w, -frame_w
    end

    local widgets = get_widgets()

    local widget_h = 0
    for _, widget in pairs(widgets) do
        widget_h = widget_h + widget.dim.h
    end

    local each_h = math.max(0, 904 - widget_h) / (math.max(1, #widgets - 1))

    local objs = {}

    local y = 928
    for _, widget in pairs(widgets) do
        table.insert(objs, SkinObject:new(widget.obj(t), 24, y - widget.dim.h))
        y = y - widget.dim.h - each_h
    end

    local obj = {
        { id = "bg_frame", dst = {{ x = frame_x, y =  0, w = frame_w, h = 952 }} },
        -- flashing animation
        { id = "bg_frame", loop = 1, dst = {
            { time =    0, x = frame_x, y = 0, w = frame_w, h = 952, a = 150 },
            { time = 2000, x = frame_x, y = 0, w = frame_w, h = 952, a =  64 },
        } },
    }

    append_all(obj, objs)

    return obj
end

return custom_pane
