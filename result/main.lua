-- main result pane is mostly finished now

-- information that belongs to other panes:
-- * ir info
-- * detailed song info (genre etc)
-- * more graphs

-- issues:
-- * update indicator property for max combo might not be working properly

local main_state = require("main_state")

local prop = require("prop")
local SkinObject = require("skin_object")

local util = require("result/util")

local widget_property = {
    { name = "OFF", op = prop:add_op("custom_off") },
    { name = "GAUGE GRAPH",             op = prop:add_op("custom_gauge_graph")   },
    { name = "SCORE INFO",              op = prop:add_op("custom_score_info")    },
    { name = "MISSCOUNT / COMBO",       op = prop:add_op("custom_missct_combo") },
    { name = "JUDGE DETAIL",            op = prop:add_op("custom_judge_detail")  },
    { name = "FAST/SLOW / COMBO BREAK", op = prop:add_op("custom_fs_cb")         },
}

-- this should be called after prop:add_op has been called for widget ops
local panes = require("result/panes")

local property = {
    { name = "Left Pane", def = "RESULT", item = {
        { name = "OFF",    op = prop:add_op("left_pane_off")  },
        { name = "RESULT", op = prop:add_op("left_pane_main") },
        { name = "CUSTOM", op = prop:add_op("left_pane_custom") },
    }},
    { name = "Right Pane", def = "OFF", item = {
        { name = "OFF",    op = prop:add_op("right_pane_off")  },
        { name = "RESULT", op = prop:add_op("right_pane_main") },
        { name = "CUSTOM", op = prop:add_op("right_pane_custom") },
    }},
    { name = "Use Stagefile as Background Image", def = "OFF", item = {
        { name = "ON",  op = prop:add_op("stagefile_on")  },
        { name = "OFF", op = prop:add_op("stagefile_off") },
    }},
    { name = "Add Outline Around Title", def = "OFF", item = {
        { name = "OFF",  op = prop:add_op("outline_off")  },
        { name = "weight 1",  op = prop:add_op("outline_1")  },
        { name = "weight 2",  op = prop:add_op("outline_2")  },
        { name = "weight 3",  op = prop:add_op("outline_3")  },
        { name = "weight 4",  op = prop:add_op("outline_4")  },
    }},
    { name = "-------- CUSTOM PANE --------", item = {{ name = "---" }} },
    { name = "Layout Style", item = {
        { name = "Normal", op = prop:add_op("custom_layout_normal") },
        { name = "Spread", op = prop:add_op("custom_layout_spread") },
    }},
    { name = "Widget 1", item = widget_property },
    { name = "Widget 2", item = widget_property },
    { name = "Widget 3", item = widget_property },
    { name = "Widget 4", item = widget_property },
    { name = "Widget 5", item = widget_property },
    { name = "-----------------------------", item = {{ name = "---" }} },
}

local filepath = {
    { name = "GRADE",   path = "customise/grade/*.png" },
    { name = "CLEAR AAA background image", path = "customise/background/aaa/*.png" },
    { name = "CLEAR AA background image",  path = "customise/background/aa/*.png" },
    { name = "CLEAR A background image",   path = "customise/background/a/*.png" },
    { name = "CLEAR background image",     path = "customise/background/clear/*.png" },
    { name = "FAILED background image",    path = "customise/background/failed/*.png" },
}

local header = {
    type = 7,
    name = "Blanket",
    w = 1920,
    h = 1080,
    scene = 3600000,
    input = 250,
    fadeout = 500,
    property = property,
    filepath = filepath,
}

local function main()
    local skin = {}

    for k, v in pairs(header) do
        skin[k] = v
    end

    skin.source = {
        { id = "parts",     path = "result/parts.png" },
        { id = "vignette",  path = "result/vignette.png" },
        { id = "grade",     path = "customise/grade/*.png" },
        { id = "bg_aaa",    path = "customise/background/aaa/*.png" },
        { id = "bg_aa",     path = "customise/background/aa/*.png" },
        { id = "bg_a",      path = "customise/background/a/*.png" },
        { id = "bg_clear",  path = "customise/background/clear/*.png" },
        { id = "bg_failed", path = "customise/background/failed/*.png" },
    }

    skin.font = {
        { id = "title",  path = "fonts/rounded-mgenplus-1p-regular.ttf" },
        { id = "artist", path = "fonts/mplus-2c-black.ttf" },
        { id = "lvl",    path = "fonts/MPLUSRounded1c-Medium.ttf" },
    }

    local title_size  = 38
    local artist_size = 24

    skin.text = {
        { id = "title",  font = "title",  size = title_size,  outlineColor = "000000ff",
          outlineWidth = 2, align = 1, ref = prop.text.fulltitle,  overflow = 1, },
        { id = "artist", font = "artist", size = artist_size, outlineColor = "000000ff",
          outlineWidth = 2, align = 1, ref = prop.text.fullartist, overflow = 1, },
        -- { id = "lvl",    font = "lvl", size = artist_size, outlineColor = "000000ff",
        --   align = 1,     ref = prop.text.fullartist, overflow = 1, },
    }

    skin.image = {
        { id = "vignette", src = "vignette", x = 0, y = 0, w = header.w, h = header.h },

        { id = "trans", src = "parts", x = 0 , y = 0 , w = 1, h = 1 },

        { id = "bg_aaa",    src = "bg_aaa",     x = 0, y = 0, w = -1, h = -1 },
        { id = "bg_aa",     src = "bg_aa",      x = 0, y = 0, w = -1, h = -1 },
        { id = "bg_a",      src = "bg_a",       x = 0, y = 0, w = -1, h = -1 },
        { id = "bg_clear",  src = "bg_clear",   x = 0, y = 0, w = -1, h = -1 },
        { id = "bg_failed", src = "bg_failed",  x = 0, y = 0, w = -1, h = -1 },

        { id = "grade_aaa", src = "grade",  x = 0, y =   4, w = 448, h = 132 },
        { id = "grade_aa",  src = "grade",  x = 0, y = 140, w = 448, h = 132 },
        { id = "grade_a",   src = "grade",  x = 0, y = 276, w = 448, h = 132 },
        { id = "grade_b",   src = "grade",  x = 0, y = 412, w = 448, h = 132 },
        { id = "grade_c",   src = "grade",  x = 0, y = 548, w = 448, h = 132 },
        { id = "grade_d",   src = "grade",  x = 0, y = 684, w = 448, h = 132 },
        { id = "grade_e",   src = "grade",  x = 0, y = 820, w = 448, h = 132 },
        { id = "grade_f",   src = "grade",  x = 0, y = 956, w = 448, h = 132 },
        { id = "s_grade_aaa", src = "grade",  x = 449, y =   4, w = 152, h = 28 },
        { id = "s_grade_aa",  src = "grade",  x = 449, y =  33, w = 152, h = 28 },
        { id = "s_grade_a",   src = "grade",  x = 449, y =  62, w = 152, h = 28 },
        { id = "s_grade_b",   src = "grade",  x = 449, y =  91, w = 152, h = 28 },
        { id = "s_grade_c",   src = "grade",  x = 449, y = 120, w = 152, h = 28 },
        { id = "s_grade_d",   src = "grade",  x = 449, y = 149, w = 152, h = 28 },
        { id = "s_grade_e",   src = "grade",  x = 449, y = 178, w = 152, h = 28 },
        { id = "s_grade_f",   src = "grade",  x = 449, y = 207, w = 152, h = 28 },

        { id = "t_grade_max", src = "parts", x = 1047, y = 205, w = 36, h = 12 },
        { id = "t_grade_aaa", src = "parts", x = 1047, y = 218, w = 36, h = 12 },
        { id = "t_grade_aa",  src = "parts", x = 1047, y = 218, w = 24, h = 12 },
        { id = "t_grade_a",   src = "parts", x = 1047, y = 218, w = 12, h = 12 },
        { id = "t_grade_b",   src = "parts", x = 1083, y = 218, w = 12, h = 12 },
        { id = "t_grade_c",   src = "parts", x = 1095, y = 218, w = 12, h = 12 },
        { id = "t_grade_d",   src = "parts", x = 1107, y = 218, w = 12, h = 12 },
        { id = "t_grade_e",   src = "parts", x = 1119, y = 218, w = 12, h = 12 },
        { id = "t_grade_f",   src = "parts", x = 1131, y = 218, w = 12, h = 12 },

        { id = "bg_frame",      src = "parts", x =   0, y =   0, w = 512, h = 952 },
        { id = "bg_graph",      src = "parts", x = 514, y = 360, w = 463, h = 256 },
        { id = "bg_update1",    src = "parts", x = 514, y =   0, w = 463, h =  47 },
        { id = "bg_update2",    src = "parts", x = 514, y =  49, w = 463, h =  47 },
        { id = "bg_miss_combo", src = "parts", x = 514, y = 618, w = 463, h =  65 },
        { id = "bg_judge",      src = "parts", x = 514, y =  98, w = 463, h = 194 },
        { id = "bg_fs",         src = "parts", x = 514, y = 294, w = 463, h =  64 },
        { id = "bg_lvl_2p",     src = "parts", x = 514, y = 685, w = 446, h =  40 },
        { id = "bg_lvl_1p",     src = "parts", x = 514, y = 727, w = 446, h =  40 },

        { id = "txt_best",    src = "parts", x =  981, y =   2, w = 127, h = 22 },
        { id = "txt_konkai",  src = "parts", x =  981, y =  27, w = 127, h = 22 },

        { id = "txt_clearty", src = "parts", x =  981, y =  55, w = 128, h = 15 },
        { id = "txt_grade",   src = "parts", x =  981, y =  72, w = 128, h = 15 },
        { id = "txt_score",   src = "parts", x =  981, y =  89, w = 128, h = 15 },
        { id = "txt_target",  src = "parts", x =  981, y = 123, w = 128, h = 15 },

        { id = "txt_missct",   src = "parts", x =  980, y = 105, w = 121, h =  9 },
        { id = "txt_maxcombo", src = "parts", x =  980, y = 114, w = 115, h =  9 },
        { id = "txt_judge",    src = "parts", x =  980, y = 140, w = 141, h = 11 },
        { id = "txt_cb",       src = "parts", x =  979, y = 153, w = 120, h =  8 },
        { id = "txt_fast",     src = "parts", x = 1048, y = 163, w =  71, h = 17 },
        { id = "txt_slow",     src = "parts", x = 1048, y = 182, w =  71, h = 17 },

        { id = "txt_pgreat", src = "parts",  x = 980, y = 163, w = 62, h = 14 },
        { id = "txt_great",  src = "parts",  x = 980, y = 179, w = 62, h = 14 },
        { id = "txt_good",   src = "parts",  x = 980, y = 195, w = 62, h = 14 },
        { id = "txt_bad",    src = "parts",  x = 980, y = 211, w = 62, h = 14 },
        { id = "txt_poor",   src = "parts",  x = 980, y = 227, w = 62, h = 14 },
        { id = "txt_judge_bg", src = "parts", x = 1010, y = 587, w = 86, h = 32 },

        { id = "konkai_clear", src = "parts", x = 986, y = 248, w = 152, h = 264,
            divy = 11, len = 11, ref = prop.num.clear },
        { id = "best_clear",   src = "parts", x = 986, y = 248, w = 152, h = 264,
            divy = 11, len = 11, ref = prop.num.target_clear },

        { id = "fast_graph", src = "parts", x = 980, y = 519, w = 104, h = 12 },
        { id = "slow_graph", src = "parts", x = 980, y = 532, w = 104, h = 12 },

        { id = "judge_graph", src = "parts", x = 1396, y = 1, w = 150, h = 8 },
        { id = "judge_graph_border", src = "parts", x = 1394, y = 24, w = 154, h = 154 },

        { id = "update_indicator",   src = "parts", x =  979, y = 546, w = 28, h = 30 },
        { id = "noupdate_indicator", src = "parts", x = 1009, y = 546, w = 28, h = 30 },

        { id = "dot",       src = "parts", x = 1272, y = 142, w =  3, h =  4 },
        { id = "percent",   src = "parts", x = 1270, y = 147, w = 12, h = 12 },
        { id = "slash",     src = "parts", x = 1286, y = 136, w = 14, h = 25 },
    }

    skin.value = {
        { id = "konkai_rate", src = "parts", digit = 2, ref = prop.num.score_rate,
          x = 1126, y = 185, w = 132, h = 12, divx = 11, zeropadding = 2 },
        { id = "konkai_rate_dec", src = "parts", digit = 2, ref = prop.num.score_rate_afterdot,
          x = 1126, y = 185, w = 132, h = 12, divx = 11, zeropadding = 2 },
        { id = "best_rate", src = "parts", digit = 2, ref = prop.num.best_rate,
          x = 1126, y = 185, w = 132, h = 12, divx = 11, zeropadding = 2 },
        { id = "best_rate_dec", src = "parts", digit = 2, ref = prop.num.best_rate_afterdot,
          x = 1126, y = 185, w = 132, h = 12, divx = 11, zeropadding = 2 },

        { id = "konkai_score",  src = "parts", digit = 4, ref = prop.num.score,
          x = 1122, y = 3,  w = 264, h = 27,   divx = 11, zeropadding = 1 },
        { id = "best_score",    src = "parts", digit = 4, ref = prop.num.highscore,
          x = 1122, y = 59, w = 242, h = 24,   divx = 11, zeropadding = 1 },
        { id = "target_score",  src = "parts", digit = 4, ref = prop.num.target_score,
          x = 1122, y = 31, w = 264, h = 27,   divx = 11, zeropadding = 1 },
        { id = "cb_count",      src = "parts", digit = 4, ref = prop.num.combobreak,
          x = 1122, y =102, w = 264, h = 27,   divx = 11, align = 2 },

        { id = "combo",         src = "parts", digit = 4, ref = prop.num.maxcombo,
          x = 1122, y = 102, w = 264, h = 27,   divx = 11 },
        { id = "maxcombo",      src = "parts", digit = 4, ref = prop.num.totalnotes,
          x = 1122, y =  84, w = 165, h = 17,   divx = 11 },
        { id = "missct",        src = "parts", digit = 4, ref = prop.num.misscount,
          x = 1122, y = 102, w = 264, h = 27,   divx = 11, zeropadding = 1 },

        { id = "best_diff",     src = "parts", digit = 5, ref = prop.num.diff_highscore,
          x = 1126, y = 135, w = 144, h = 24,   divx = 12, divy = 2, zeropadding = 4 },
        { id = "target_diff",   src = "parts", digit = 5, ref = prop.num.diff_targetscore,
          x = 1126, y = 135, w = 144, h = 24,   divx = 12, divy = 2, zeropadding = 4 },
        { id = "missct_diff",   src = "parts", digit = 5, ref = prop.num.diff_misscount,
          x = 1126, y = 160, w = 144, h = 24,   divx = 12, divy = 2, zeropadding = 4 },
        { id = "combo_diff",    src = "parts", digit = 5, ref = prop.num.diff_maxcombo,
          x = 1126, y = 135, w = 144, h = 24,   divx = 12, divy = 2, zeropadding = 4 },

        { id = "fs_fast",       src = "parts", digit = 3, ref = prop.num.totalearly,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "fs_slow",       src = "parts", digit = 3, ref = prop.num.totallate,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },

        { id = "judge_pgreat",  src = "parts", digit = 4, ref = prop.num.perfect,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "judge_great",   src = "parts", digit = 4, ref = prop.num.great,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "judge_good",    src = "parts", digit = 4, ref = prop.num.good,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "judge_bad",     src = "parts", digit = 4, ref = prop.num.bad,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "judge_poor",    src = "parts", digit = 4, ref = prop.num.poor,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
    }

    skin.gaugegraph = {{
        id = "gaugegraph",
        assistClearBGColor          = "000000",
        assistAndEasyFailBGColor    = "000000",
        grooveFailBGColor           = "000000",
        grooveClearAndHardBGColor   = "000000",
        exHardBGColor               = "000000",
        hazardBGColor               = "000000",
        assistClearLineColor        = "ff00ff",
        assistAndEasyFailLineColor  = "00ffff",
        grooveFailLineColor         = "00ff00",
        grooveClearAndHardLineColor = "ff0000",
        exHardLineColor             = "ffff00",
        hazardLineColor             = "cccccc",
        borderlineColor             = "ff0000",
        borderColor                 = "000000",
    }}

    skin.destination = {
        -- clear bg
        { id = "bg_clear", op = { prop.op.result_clear }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},
        -- stagefile
        { id = prop.image.stagefile, op = { prop.prop.stagefile_on, prop.op.result_clear }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},
        -- custom backgrounds
        { id = "bg_aaa", op = { prop.prop.stagefile_off, prop.op.result_aaa_1p, prop.op.result_clear }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},
        { id = "bg_aa",  op = { prop.prop.stagefile_off, prop.op.result_aa_1p,  prop.op.result_clear }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},
        { id = "bg_a",   op = { prop.prop.stagefile_off, prop.op.result_a_1p,   prop.op.result_clear }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},
        -- failed bg
        { id = "bg_failed", op = { prop.op.result_fail }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},

        { id = "vignette",   dst = {{ x = 0, y = 0, w = header.w, h = header.h }} },
    }

    local text_x, title_y, artist_y = 960, 80, 52

    if skin_config.option["Add Outline Around Title"] ~= prop.prop.outline_off then
        local outline_weight = 1
        if skin_config.option["Add Outline Around Title"] == prop.prop.outline_2 then
            outline_weight = 2
        elseif skin_config.option["Add Outline Around Title"] == prop.prop.outline_3 then
            outline_weight = 3
        elseif skin_config.option["Add Outline Around Title"] == prop.prop.outline_4 then
            outline_weight = 4
        end
        for angle=0,360,12 do
            local dx = math.cos(math.rad(angle)) * outline_weight
            local dy = math.sin(math.rad(angle)) * outline_weight
            table.insert(skin.destination,
                { id = "title",  dst = {{ x = text_x + dx, y = title_y + dy, w = 880, h = title_size, r = 0, g = 0, b = 0 }} })
            table.insert(skin.destination,
                { id = "artist", dst = {{ x = text_x + dx, y = artist_y + dy, w = 880, h = artist_size, r = 0, g = 0, b = 0 }} })
        end
    end

    table.insert(skin.destination,
        { id = "title",  dst = {{ x = text_x, y = title_y, w = 880, h = title_size }} })
    table.insert(skin.destination,
        { id = "artist", dst = {{ x = text_x, y = artist_y, w = 880, h = artist_size }} })

    local t = { flip = true }

    if skin_config.option["Left Pane"] == prop.prop.left_pane_main then
        local pane = SkinObject:new(panes.main_pane(t), 0, 64)
        pane:apply(skin)
    elseif skin_config.option["Left Pane"] == prop.prop.left_pane_custom then
        local pane = SkinObject:new(panes.custom(t), 0, 64)
        pane:apply(skin)
    end

    t.flip = false

    if skin_config.option["Right Pane"] == prop.prop.right_pane_main then
        local pane = SkinObject:new(panes.main_pane(t), 1408, 64)
        pane:apply(skin)
    elseif skin_config.option["Right Pane"] == prop.prop.right_pane_custom then
        local pane = SkinObject:new(panes.custom(t), 1408, 64)
        pane:apply(skin)
    end

    -- fade in
    table.insert(skin.destination, { id = prop.image.black, loop = -1, dst = {
        { time =   0, x = 0, y = 0, w = header.w, h = header.h, a = 255 },
        { time = 250, x = 0, y = 0, w = header.w, h = header.h, a = 0 },
    }})
    -- fade out
    table.insert(skin.destination, { id = prop.image.black, loop = 500, timer = prop.timer.fadeout, dst = {
        { time =   0, x = 0, y = 0, w = header.w, h = header.h, a = 0 },
        { time = 500, x = 0, y = 0, w = header.w, h = header.h, a = 255 },
    }})

    return skin
end

return {
    header = header,
    main = main,
}
