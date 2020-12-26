-- TODO (will only consider the skin complete once these are done):
-- * show the options the player used
-- * show score diffs and updates
-- * show score rate
-- * show playlevel, difficulty, notecount, sp/dp
-- * show ir info

-- FUTURE IDEAS:
-- * add different kinds of judge graphs
-- * modular pane system (player able to change the type of the left and right
--   panes, each displaying different information and in different ways)

-- IMPORTANT TODOs:
-- * add a table containing the offsets of each DST from the top-left of the
--   pane and use these to compute the absolute coordinates instead of
--   hardcoding everything
-- * try to decouple as much of the currently implemented functionality as
--   possible

local op = require("prop")
local util = require("result/util")
local main_state = require("main_state")

local PROPERTY_OP = 899
local function property_op()
    PROPERTY_OP = PROPERTY_OP + 1
    return PROPERTY_OP
end

op.prop = {
    stagefile_off   = property_op(),
    stagefile_on    = property_op(),
}

local property = {
    { name = "Use stagefile as background image", item = {
        { name = "ON",  op = op.prop.stagefile_on  },
        { name = "OFF", op = op.prop.stagefile_off },
    }},
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
    name = "marie result skin",
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

    local fast_count = main_state.number(op.num.totalearly)
    local slow_count = main_state.number(op.num.totallate)
    local note_count = util.total_played_notes()

    local fast_w = fast_count / note_count
    local slow_w = slow_count / note_count

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
        { id = "title", path = "fonts/rounded-mgenplus-1p-regular.ttf" },
        { id = "artist", path = "fonts/mplus-2c-black.ttf" },
    }

    local title_size  = 38
    local artist_size = 24

    skin.text = {
        { id = "title",  font = "title",  size = title_size,  outlineColor = "000000ff",
          outlineWidth = 2, align = 1, ref = op.text.fulltitle,  overflow = 1, },
        { id = "artist", font = "artist", size = artist_size, outlineColor = "000000ff",
          outlineWidth = 2, align = 1, ref = op.text.fullartist, overflow = 1, },
    }

    skin.image = {
        { id = "vignette", src = "vignette", x = 0, y = 0, w = header.w, h = header.h },

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

        { id = "bg_frame",   src = "parts",  x =   0, y =   0, w = 512, h = 984 },
        { id = "bg_graph",   src = "parts",  x = 514, y = 360, w = 463, h = 256 },
        { id = "bg_update1", src = "parts",  x = 514, y =   0, w = 463, h =  47 },
        { id = "bg_update2", src = "parts",  x = 514, y =  49, w = 463, h =  47 },
        { id = "bg_judge",   src = "parts",  x = 514, y =  98, w = 463, h = 194 },
        { id = "bg_fs",      src = "parts",  x = 514, y = 294, w = 463, h =  64 },

        { id = "txt_best",    src = "parts",  x =  981, y =   2, w = 127, h = 22 },
        { id = "txt_konkai",  src = "parts",  x =  981, y =  27, w = 127, h = 22 },

        { id = "txt_clearty", src = "parts",  x =  981, y =  55, w = 128, h = 15 },
        { id = "txt_grade",   src = "parts",  x =  981, y =  72, w = 128, h = 15 },
        { id = "txt_score",   src = "parts",  x =  981, y =  89, w = 128, h = 15 },
        { id = "txt_missct",  src = "parts",  x =  981, y = 106, w = 128, h = 15 },
        { id = "txt_target",  src = "parts",  x =  981, y = 123, w = 128, h = 15 },

        { id = "txt_judge",   src = "parts",  x =  980, y = 140, w = 141, h = 11 },
        { id = "txt_cb",      src = "parts",  x =  979, y = 153, w = 120, h =  8 },
        { id = "txt_fast",    src = "parts",  x = 1048, y = 163, w =  71, h = 17 },
        { id = "txt_slow",    src = "parts",  x = 1048, y = 182, w =  71, h = 17 },

        { id = "judge_pg", src = "parts",  x = 980, y = 163, w = 62, h = 14 },
        { id = "judge_gr", src = "parts",  x = 980, y = 179, w = 62, h = 14 },
        { id = "judge_gd", src = "parts",  x = 980, y = 195, w = 62, h = 14 },
        { id = "judge_bd", src = "parts",  x = 980, y = 211, w = 62, h = 14 },
        { id = "judge_pr", src = "parts",  x = 980, y = 227, w = 62, h = 14 },

        { id = "konkai_clear", src = "parts", x = 986, y = 248, w = 152, h = 264,
            divy = 11, len = 11, ref = op.num.clear },
        { id = "best_clear",   src = "parts", x = 986, y = 248, w = 152, h = 264,
            divy = 11, len = 11, ref = op.num.target_clear },

        { id = "fast_graph", src = "parts", x = 980, y = 519, w = 104, h = 12 },
        { id = "slow_graph", src = "parts", x = 980, y = 532, w = 104, h = 12 },

        { id = "judge_graph", src = "parts", x = 1396, y = 1, w = 150, h = 8 },
        { id = "judge_graph_border", src = "parts", x = 1394, y = 24, w = 154, h = 154 },
    }

    skin.value = {
        { id = "konkai_score",  src = "parts", digit = 4, ref = op.num.score,
          x = 1122, y = 3,  w = 264, h = 27,   divx = 11, zeropadding = 1 },
        { id = "konkai_missct", src = "parts", digit = 4, ref = op.num.misscount,
          x = 1122, y = 3,  w = 264, h = 27,   divx = 11, zeropadding = 1 },
        { id = "best_score",    src = "parts", digit = 4, ref = op.num.highscore,
          x = 1122, y = 59, w = 242, h = 24,   divx = 11, zeropadding = 1 },
        -- beatoraja does not seem to support best score misscount
        -- { id = "best_missct",   src = "parts", digit = 4, ref = op.num.best_missct,
        --   x = 1122, y = 59, w = 242, h = 24,   divx = 11, zeropadding = 1 },
        { id = "target_score",  src = "parts", digit = 4, ref = op.num.target_score,
          x = 1122, y = 31, w = 264, h = 27,   divx = 11, zeropadding = 1 },
        { id = "cb_count",      src = "parts", digit = 4, ref = op.num.combobreak,
          x = 1122, y =102, w = 264, h = 27,   divx = 11, align = 2},
        { id = "fs_fast",       src = "parts", digit = 3, ref = op.num.totalearly,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "fs_slow",       src = "parts", digit = 3, ref = op.num.totallate,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "judge_pgreat",  src = "parts", digit = 4, ref = op.num.perfect,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "judge_great",   src = "parts", digit = 4, ref = op.num.great,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "judge_good",    src = "parts", digit = 4, ref = op.num.good,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "judge_bad",     src = "parts", digit = 4, ref = op.num.bad,
          x = 1122, y = 84, w = 150, h = 17,   divx = 10, },
        { id = "judge_poor",    src = "parts", digit = 4, ref = op.num.poor,
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
        { id = "bg_clear", op = { op.opt.result_clear }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},
        -- stagefile
        { id = op.image.stagefile, op = { op.prop.stagefile_on, op.opt.result_clear }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},
        -- custom backgrounds
        { id = "bg_aaa", op = { op.prop.stagefile_off, op.opt.result_aaa_1p, op.opt.result_clear }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},
        { id = "bg_aa",  op = { op.prop.stagefile_off, op.opt.result_aa_1p,  op.opt.result_clear }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},
        { id = "bg_a",   op = { op.prop.stagefile_off, op.opt.result_a_1p,   op.opt.result_clear }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},
        -- failed bg
        { id = "bg_failed", op = { op.opt.result_fail }, dst = {
            { x = 0, y = 0, w = header.w, h = header.h, filter = 1 }
        }},

        { id = "vignette",   dst = {{ x = 0, y = 0, w = header.w, h = header.h }} },

        { id = "bg_frame",   dst = {{ x = 1408, y =  46, w = 512, h = 984 }} },
        -- flashing animation
        { id = "bg_frame",  loop = 1,   dst = {
            { time =    0,     x = 1408, y =  46, w = 512, h = 984, a = 150 },
            { time = 2000,     x = 1408, y =  46, w = 512, h = 984, a =  64},
        } },

        { id = "bg_graph",   dst = {{ x = 1432, y = 749, w = 463, h = 256 }} },
        { id = "bg_update1", dst = {{ x = 1432, y = 664, w = 463, h =  47 }} },
        { id = "bg_update1", dst = {{ x = 1432, y = 605, w = 463, h =  47 }} },
        { id = "bg_update1", dst = {{ x = 1432, y = 546, w = 463, h =  47 }} },
        -- this one was originally bg_update1, changed it since beatoraja
        -- doesnt support best score misscounts
        { id = "bg_update2", dst = {{ x = 1432, y = 487, w = 463, h =  47 }} },
        { id = "bg_update2", dst = {{ x = 1432, y = 428, w = 463, h =  47 }} },
        { id = "bg_judge",   dst = {{ x = 1432, y = 184, w = 463, h = 194 }} },
        { id = "bg_fs",      dst = {{ x = 1432, y =  65, w = 463, h =  64 }} },

        { id = "grade_aaa", op = { op.opt.now_aaa_1p }, dst = {{ x = 1433, y = 808, w = 448, h = 132 }} },
        { id = "grade_aa",  op = { op.opt.now_aa_1p },  dst = {{ x = 1433, y = 808, w = 448, h = 132 }} },
        { id = "grade_a",   op = { op.opt.now_a_1p },   dst = {{ x = 1433, y = 808, w = 448, h = 132 }} },
        { id = "grade_b",   op = { op.opt.now_b_1p },   dst = {{ x = 1433, y = 808, w = 448, h = 132 }} },
        { id = "grade_c",   op = { op.opt.now_c_1p },   dst = {{ x = 1433, y = 808, w = 448, h = 132 }} },
        { id = "grade_d",   op = { op.opt.now_d_1p },   dst = {{ x = 1433, y = 808, w = 448, h = 132 }} },
        { id = "grade_e",   op = { op.opt.now_e_1p },   dst = {{ x = 1433, y = 808, w = 448, h = 132 }} },
        { id = "grade_f",   op = { op.opt.now_f_1p },   dst = {{ x = 1433, y = 808, w = 448, h = 132 }} },

        { id = "s_grade_aaa", op = { op.opt.now_aaa_1p }, dst = {{ x = 1742, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_aa",  op = { op.opt.now_aa_1p },  dst = {{ x = 1742, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_a",   op = { op.opt.now_a_1p },   dst = {{ x = 1742, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_b",   op = { op.opt.now_b_1p },   dst = {{ x = 1742, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_c",   op = { op.opt.now_c_1p },   dst = {{ x = 1742, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_d",   op = { op.opt.now_d_1p },   dst = {{ x = 1742, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_e",   op = { op.opt.now_e_1p },   dst = {{ x = 1742, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_f",   op = { op.opt.now_f_1p },   dst = {{ x = 1742, y = 614, w = 152, h = 28 }} },

        { id = "s_grade_aaa", op = { op.opt.best_aaa_1p }, dst = {{ x = 1588, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_aa",  op = { op.opt.best_aa_1p },  dst = {{ x = 1588, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_a",   op = { op.opt.best_a_1p },   dst = {{ x = 1588, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_b",   op = { op.opt.best_b_1p },   dst = {{ x = 1588, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_c",   op = { op.opt.best_c_1p },   dst = {{ x = 1588, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_d",   op = { op.opt.best_d_1p },   dst = {{ x = 1588, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_e",   op = { op.opt.best_e_1p },   dst = {{ x = 1588, y = 614, w = 152, h = 28 }} },
        { id = "s_grade_f",   op = { op.opt.best_f_1p },   dst = {{ x = 1588, y = 614, w = 152, h = 28 }} },


        { id = "txt_best",   dst = {{ x = 1600, y = 718, w = 127, h =  22 }} },
        { id = "txt_konkai", dst = {{ x = 1754, y = 718, w = 127, h =  22 }} },

        { id = "txt_clearty", dst = {{ x = 1449, y = 680, w = 128, h = 15 }} },
        { id = "txt_grade",   dst = {{ x = 1449, y = 620, w = 128, h = 15 }} },
        { id = "txt_score",   dst = {{ x = 1449, y = 562, w = 128, h = 15 }} },
        { id = "txt_missct",  dst = {{ x = 1449, y = 503, w = 128, h = 15 }} },
        { id = "txt_target",  dst = {{ x = 1449, y = 445, w = 128, h = 15 }} },

        { id = "txt_judge", dst = {{ x = 1594, y = 360, w = 141, h = 11 }} },
        { id = "txt_cb",    dst = {{ x = 1751, y = 118, w = 120, h =  8 }} },
        { id = "txt_fast",  dst = {{ x = 1457, y = 103, w =  71, h = 17 }} },
        { id = "txt_slow",  dst = {{ x = 1457, y =  75, w =  71, h = 17 }} },

        { id = "judge_pg", dst = {{ x = 1675, y = 329, w = 62, h = 14 }} },
        { id = "judge_gr", dst = {{ x = 1675, y = 295, w = 62, h = 14 }} },
        { id = "judge_gd", dst = {{ x = 1675, y = 261, w = 62, h = 14 }} },
        { id = "judge_bd", dst = {{ x = 1675, y = 227, w = 62, h = 14 }} },
        { id = "judge_pr", dst = {{ x = 1675, y = 193, w = 62, h = 14 }} },

        { id = "best_clear",    dst = {{ x = 1588, y = 676, w = 152, h = 24 }} },
        { id = "konkai_clear",  dst = {{ x = 1742, y = 676, w = 152, h = 24 }} },
        { id = "best_score",    dst = {{ x = 1620, y = 557, w =  22, h = 24 }} },
        { id = "konkai_score",  dst = {{ x = 1771, y = 556, w =  24, h = 27 }} },
        { id = "konkai_missct", dst = {{ x = 1771, y = 497, w =  24, h = 27 }} },
        -- { id = "best_missct",   dst = {{ x = 1620, y = 498, w =  22, h = 24 }} },
        { id = "target_score",  dst = {{ x = 1771, y = 438, w =  24, h = 27 }} },
        { id = "cb_count",      dst = {{ x = 1764, y = 76,  w =  24, h = 27 }} },
        { id = "fs_fast",       dst = {{ x = 1548, y = 103, w =  15, h = 17 }} },
        { id = "fs_slow",       dst = {{ x = 1548, y = 75,  w =  15, h = 17 }} },
        { id = "judge_pgreat",  dst = {{ x = 1821, y = 327, w =  15, h = 17 }} },
        { id = "judge_great",   dst = {{ x = 1821, y = 294, w =  15, h = 17 }} },
        { id = "judge_good",    dst = {{ x = 1821, y = 260, w =  15, h = 17 }} },
        { id = "judge_bad",     dst = {{ x = 1821, y = 226, w =  15, h = 17 }} },
        { id = "judge_poor",    dst = {{ x = 1821, y = 192, w =  15, h = 17 }} },

        { id = "gaugegraph", blend = 2, dst = {
            { x = 1440, y = 757, w = 455, h = 241, },
        } },

        { id = "fast_graph", dst = {{ x = 1601, y = 106, w = 104 * fast_w, h = 12 }} },
        { id = "slow_graph", dst = {{ x = 1601, y =  78, w = 104 * slow_w, h = 12 }} },

        { id = "title",  dst = {{ x = 960, y = 80, w = 880, h = title_size }} },
        { id = "artist", dst = {{ x = 960, y = 52, w = 880, h = artist_size }} },
    }

    util.make_judge_graph(skin, 1551, 269)

    -- fade in
    table.insert(skin.destination, { id = op.image.black, loop = -1, dst = {
        { time =   0, x = 0, y = 0, w = header.w, h = header.h, a = 255 },
        { time = 250, x = 0, y = 0, w = header.w, h = header.h, a = 0 },
    }})
    -- fade out
    table.insert(skin.destination, { id = op.image.black, loop = 500, timer = op.timer.fadeout, dst = {
        { time =   0, x = 0, y = 0, w = header.w, h = header.h, a = 0 },
        { time = 500, x = 0, y = 0, w = header.w, h = header.h, a = 255 },
    }})

    return skin
end

return {
    header = header,
    main = main,
}
