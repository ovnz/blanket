local prop = require("prop")
local skin_object = require("skin_object")

local util = require("result/util")

local function main_pane(t)
    return {
        -- pane frame
        { id = "bg_frame", dst = {{ x = 0, y =  0, w = 512, h = 984 }} },
        -- flashing animation
        { id = "bg_frame", loop = 1, dst = {
            { time =    0, x = 0, y = 0, w = 512, h = 984, a = 150 },
            { time = 2000, x = 0, y = 0, w = 512, h = 984, a =  64 },
        } },

        { id = "bg_graph",   dst = {{ x = 24, y = 703, w = 463, h = 256 }} },
        { id = "bg_update1", dst = {{ x = 24, y = 618, w = 463, h =  47 }} },
        { id = "bg_update1", dst = {{ x = 24, y = 559, w = 463, h =  47 }} },
        { id = "bg_update1", dst = {{ x = 24, y = 500, w = 463, h =  47 }} },
        { id = "bg_update2", dst = {{ x = 24, y = 441, w = 463, h =  47 }} },
        { id = "bg_update2", dst = {{ x = 24, y = 382, w = 463, h =  47 }} },
        { id = "bg_judge",   dst = {{ x = 24, y = 138, w = 463, h = 194 }} },
        { id = "bg_fs",      dst = {{ x = 24, y =  19, w = 463, h =  64 }} },

        { id = "txt_best",   dst = {{ x = 192, y = 672, w = 127, h =  22 }} },
        { id = "txt_konkai", dst = {{ x = 346, y = 672, w = 127, h =  22 }} },

        { id = "txt_clearty", dst = {{ x = 41, y = 634, w = 128, h = 15 }} },
        { id = "txt_grade",   dst = {{ x = 41, y = 574, w = 128, h = 15 }} },
        { id = "txt_score",   dst = {{ x = 41, y = 516, w = 128, h = 15 }} },
        { id = "txt_missct",  dst = {{ x = 41, y = 457, w = 128, h = 15 }} },
        { id = "txt_target",  dst = {{ x = 41, y = 399, w = 128, h = 15 }} },

        { id = "txt_judge", dst = {{ x = 186, y = 314, w = 141, h = 11 }} },
        { id = "txt_cb",    dst = {{ x = 343, y =  72, w = 120, h =  8 }} },
        { id = "txt_fast",  dst = {{ x =  49, y =  57, w =  71, h = 17 }} },
        { id = "txt_slow",  dst = {{ x =  49, y =  29, w =  71, h = 17 }} },

        { id = "grade_aaa", op = { prop.opt.now_aaa_1p }, dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_aa",  op = { prop.opt.now_aa_1p },  dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_a",   op = { prop.opt.now_a_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_b",   op = { prop.opt.now_b_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_c",   op = { prop.opt.now_c_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_d",   op = { prop.opt.now_d_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_e",   op = { prop.opt.now_e_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_f",   op = { prop.opt.now_f_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },

        { id = "gaugegraph", blend = 2, dst = {
            { x = 32, y = 711, w = 455, h = 241, },
        } },

        { id = "s_grade_aaa", op = { prop.opt.now_aaa_1p },  dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_aa",  op = { prop.opt.now_aa_1p },   dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_a",   op = { prop.opt.now_a_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_b",   op = { prop.opt.now_b_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_c",   op = { prop.opt.now_c_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_d",   op = { prop.opt.now_d_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_e",   op = { prop.opt.now_e_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_f",   op = { prop.opt.now_f_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },

        { id = "s_grade_aaa", op = { prop.opt.best_aaa_1p }, dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_aa",  op = { prop.opt.best_aa_1p },  dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_a",   op = { prop.opt.best_a_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_b",   op = { prop.opt.best_b_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_c",   op = { prop.opt.best_c_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_d",   op = { prop.opt.best_d_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_e",   op = { prop.opt.best_e_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_f",   op = { prop.opt.best_f_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },

        { id = "best_clear",    dst = {{ x = 180, y = 629, w = 152, h = 24 }} },
        { id = "konkai_clear",  dst = {{ x = 334, y = 629, w = 152, h = 24 }} },
        { id = "best_score",    dst = {{ x = 212, y = 511, w =  22, h = 24 }} },
        { id = "konkai_score",  dst = {{ x = 363, y = 510, w =  24, h = 27 }} },
        { id = "konkai_missct", dst = {{ x = 363, y = 451, w =  24, h = 27 }} },
        { id = "target_score",  dst = {{ x = 363, y = 392, w =  24, h = 27 }} },
        { id = "judge_pgreat",  dst = {{ x = 413, y = 281, w =  15, h = 17 }} },
        { id = "judge_great",   dst = {{ x = 413, y = 248, w =  15, h = 17 }} },
        { id = "judge_good",    dst = {{ x = 413, y = 214, w =  15, h = 17 }} },
        { id = "judge_bad",     dst = {{ x = 413, y = 180, w =  15, h = 17 }} },
        { id = "judge_poor",    dst = {{ x = 413, y = 146, w =  15, h = 17 }} },
        { id = "cb_count",      dst = {{ x = 356, y =  30, w =  24, h = 27 }} },
        { id = "fs_fast",       dst = {{ x = 140, y =  57, w =  15, h = 17 }} },
        { id = "fs_slow",       dst = {{ x = 140, y =  29, w =  15, h = 17 }} },

        { id = "fast_graph", dst = {{ x = 193, y = 60, w = 104 * t.fast_w, h = 12 }} },
        { id = "slow_graph", dst = {{ x = 193, y = 32, w = 104 * t.slow_w, h = 12 }} },

        function(skin, x, y)
            util.make_judge_graph(skin, x + 142, y + 222)
        end,
    }
end

return {
    main_pane = main_pane
}
