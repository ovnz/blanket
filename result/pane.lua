local prop = require("prop")

local util = require("result/util")

local function main_pane(t)
    local flip = false
    if t.flip ~= nil then
        flip = true
    end

    local full_w = 512

    local x = {
        frame = 0,
        item = 24,
        judge_graph = 142,
    }
    local w = {
        frame = 512,
        item = 463,
    }

    local judge_x     = 267
    local judge_num_x = 413
    local fs_x        = 49
    local fs_num_x    = 140
    local fs_graph_x  = 193
    local cb_x        = 343
    local cb_num_x    = 356

    if flip then
        judge_x     = 40
        judge_num_x = 185
        fs_x        = 392
        fs_num_x    = 215
        fs_graph_x  = 268
        cb_x        = 49
        cb_num_x    = 60

        for k,v in pairs(x) do
            x[k] = full_w - v
        end
        for k,v in pairs(w) do
            w[k] = -v
        end
    end

    return {
        -- pane frame
        { id = "bg_frame", dst = {{ x = x.frame, y =  0, w = w.frame, h = 984 }} },
        -- flashing animation
        { id = "bg_frame", loop = 1, dst = {
            { time =    0, x = x.frame, y = 0, w = w.frame, h = 984, a = 150 },
            { time = 2000, x = x.frame, y = 0, w = w.frame, h = 984, a =  64 },
        } },

        { id = "bg_graph",   dst = {{ x = x.item, y = 703, w = w.item, h = 256 }} },
        { id = "bg_update1", dst = {{ x = x.item, y = 618, w = w.item, h =  47 }} },
        { id = "bg_update1", dst = {{ x = x.item, y = 559, w = w.item, h =  47 }} },
        { id = "bg_update1", dst = {{ x = x.item, y = 500, w = w.item, h =  47 }} },
        { id = "bg_update2", dst = {{ x = x.item, y = 441, w = w.item, h =  47 }} },
        { id = "bg_update2", dst = {{ x = x.item, y = 382, w = w.item, h =  47 }} },
        { id = "bg_judge",   dst = {{ x = x.item, y = 138, w = w.item, h = 194 }} },
        { id = "bg_fs",      dst = {{ x = x.item, y =  19, w = w.item, h =  64 }} },

        { id = "txt_best",   dst = {{ x = 192, y = 672, w = 127, h =  22 }} },
        { id = "txt_konkai", dst = {{ x = 346, y = 672, w = 127, h =  22 }} },

        { id = "txt_clearty", dst = {{ x = 41, y = 634, w = 128, h = 15 }} },
        { id = "txt_grade",   dst = {{ x = 41, y = 574, w = 128, h = 15 }} },
        { id = "txt_score",   dst = {{ x = 41, y = 516, w = 128, h = 15 }} },
        { id = "txt_missct",  dst = {{ x = 41, y = 457, w = 128, h = 15 }} },
        { id = "txt_target",  dst = {{ x = 41, y = 399, w = 128, h = 15 }} },

        { id = "txt_judge", dst = {{ x = 186, y = 314, w = 141, h = 11 }} },
        { id = "txt_cb",    dst = {{ x = cb_x, y =  72, w = 120, h =  8 }} },
        { id = "txt_fast",  dst = {{ x = fs_x, y =  57, w =  71, h = 17 }} },
        { id = "txt_slow",  dst = {{ x = fs_x, y =  29, w =  71, h = 17 }} },

        { id = "txt_pgreat", dst = {{ x = judge_x, y = 283, w = 62, h = 14 }} },
        { id = "txt_great",  dst = {{ x = judge_x, y = 249, w = 62, h = 14 }} },
        { id = "txt_good",   dst = {{ x = judge_x, y = 215, w = 62, h = 14 }} },
        { id = "txt_bad",    dst = {{ x = judge_x, y = 181, w = 62, h = 14 }} },
        { id = "txt_poor",   dst = {{ x = judge_x, y = 147, w = 62, h = 14 }} },

        { id = "grade_aaa", op = { prop.op.now_aaa_1p }, dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_aa",  op = { prop.op.now_aa_1p },  dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_a",   op = { prop.op.now_a_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_b",   op = { prop.op.now_b_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_c",   op = { prop.op.now_c_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_d",   op = { prop.op.now_d_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_e",   op = { prop.op.now_e_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },
        { id = "grade_f",   op = { prop.op.now_f_1p },   dst = {{ x = 25, y = 762, w = 448, h = 132 }} },

        { id = "gaugegraph", blend = 2, dst = {
            { x = 32, y = 711, w = 455, h = 241, },
        } },

        { id = "s_grade_aaa", op = { prop.op.now_aaa_1p },  dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_aa",  op = { prop.op.now_aa_1p },   dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_a",   op = { prop.op.now_a_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_b",   op = { prop.op.now_b_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_c",   op = { prop.op.now_c_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_d",   op = { prop.op.now_d_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_e",   op = { prop.op.now_e_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_f",   op = { prop.op.now_f_1p },    dst = {{ x = 334, y = 568, w = 152, h = 28 }} },

        { id = "s_grade_aaa", op = { prop.op.best_aaa_1p }, dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_aa",  op = { prop.op.best_aa_1p },  dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_a",   op = { prop.op.best_a_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_b",   op = { prop.op.best_b_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_c",   op = { prop.op.best_c_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_d",   op = { prop.op.best_d_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_e",   op = { prop.op.best_e_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },
        { id = "s_grade_f",   op = { prop.op.best_f_1p },   dst = {{ x = 180, y = 568, w = 152, h = 28 }} },

        { id = "best_clear",    dst = {{ x = 180, y = 629, w = 152, h = 24 }} },
        { id = "konkai_clear",  dst = {{ x = 334, y = 629, w = 152, h = 24 }} },
        { id = "best_score",    dst = {{ x = 212, y = 511, w =  22, h = 24 }} },
        { id = "konkai_score",  dst = {{ x = 363, y = 510, w =  24, h = 27 }} },
        { id = "konkai_missct", dst = {{ x = 363, y = 451, w =  24, h = 27 }} },
        { id = "target_score",  dst = {{ x = 363, y = 392, w =  24, h = 27 }} },
        { id = "judge_pgreat",  dst = {{ x = judge_num_x, y = 281, w =  15, h = 17 }} },
        { id = "judge_great",   dst = {{ x = judge_num_x, y = 248, w =  15, h = 17 }} },
        { id = "judge_good",    dst = {{ x = judge_num_x, y = 214, w =  15, h = 17 }} },
        { id = "judge_bad",     dst = {{ x = judge_num_x, y = 180, w =  15, h = 17 }} },
        { id = "judge_poor",    dst = {{ x = judge_num_x, y = 146, w =  15, h = 17 }} },
        { id = "cb_count",      dst = {{ x = cb_num_x,    y =  30, w =  24, h = 27 }} },
        { id = "fs_fast",       dst = {{ x = fs_num_x,    y =  57, w =  15, h = 17 }} },
        { id = "fs_slow",       dst = {{ x = fs_num_x,    y =  29, w =  15, h = 17 }} },

        { id = "fast_graph", dst = {{ x = fs_graph_x, y = 60, w = 104 * t.fast_w, h = 12 }} },
        { id = "slow_graph", dst = {{ x = fs_graph_x, y = 32, w = 104 * t.slow_w, h = 12 }} },

        -- update_clear apparently doesnt exist? TODO: find another way to do this
        -- TODO: make these float up and down (how tf does the acc property work)
     -- { id = "update_indicator", op = { prop.op.update_clear },      dst = {{ x = 473, y = 626, w = 28, h = 30 }} },
        { id = "update_indicator", op = { prop.op.update_scorerank },  dst = {{ x = 473, y = 567, w = 28, h = 30 }} },
        { id = "update_indicator", op = { prop.op.update_score },      dst = {{ x = 473, y = 508, w = 28, h = 30 }} },
        { id = "update_indicator", op = { prop.op.update_misscount },  dst = {{ x = 473, y = 449, w = 28, h = 30 }} },
        { id = "update_indicator", op = { prop.op.update_target },     dst = {{ x = 473, y = 390, w = 28, h = 30 }} },

        function(skin, origin_x, origin_y)
            util.make_judge_graph(skin, origin_x + x.judge_graph, origin_y + 222)
        end,
    }
end

return {
    main_pane = main_pane
}
