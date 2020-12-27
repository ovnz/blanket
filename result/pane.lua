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
        { id = "bg_frame", dst = {{ x = x.frame, y =  0, w = w.frame, h = 952 }} },
        -- flashing animation
        { id = "bg_frame", loop = 1, dst = {
            { time =    0, x = x.frame, y = 0, w = w.frame, h = 952, a = 150 },
            { time = 2000, x = x.frame, y = 0, w = w.frame, h = 952, a =  64 },
        } },

        { id = "bg_graph",   dst = {{ x = x.item, y = 672, w = w.item, h = 256 }} },
        { id = "bg_update1", dst = {{ x = x.item, y = 587, w = w.item, h =  47 }} },
        { id = "bg_update1", dst = {{ x = x.item, y = 528, w = w.item, h =  47 }} },
        { id = "bg_update1", dst = {{ x = x.item, y = 469, w = w.item, h =  47 }} },
        { id = "bg_update2", dst = {{ x = x.item, y = 410, w = w.item, h =  47 }} },
        { id = "bg_update2", dst = {{ x = x.item, y = 351, w = w.item, h =  47 }} },
        { id = "bg_judge",   dst = {{ x = x.item, y = 123, w = w.item, h = 194 }} },
        { id = "bg_fs",      dst = {{ x = x.item, y =  24, w = w.item, h =  64 }} },

        { id = "txt_best",   dst = {{ x = 192, y = 641, w = 127, h =  22 }} },
        { id = "txt_konkai", dst = {{ x = 346, y = 641, w = 127, h =  22 }} },

        { id = "txt_clearty", dst = {{ x = 41, y = 603, w = 128, h = 15 }} },
        { id = "txt_grade",   dst = {{ x = 41, y = 543, w = 128, h = 15 }} },
        { id = "txt_score",   dst = {{ x = 41, y = 485, w = 128, h = 15 }} },
        { id = "txt_missct",  dst = {{ x = 41, y = 426, w = 128, h = 15 }} },
        { id = "txt_target",  dst = {{ x = 41, y = 368, w = 128, h = 15 }} },

        { id = "txt_judge", dst = {{ x =  186, y = 299, w = 141, h = 11 }} },
        { id = "txt_cb",    dst = {{ x = cb_x, y =  77, w = 120, h =  8 }} },
        { id = "txt_fast",  dst = {{ x = fs_x, y =  62, w =  71, h = 17 }} },
        { id = "txt_slow",  dst = {{ x = fs_x, y =  34, w =  71, h = 17 }} },

        { id = "txt_pgreat", dst = {{ x = judge_x, y = 268, w = 62, h = 14 }} },
        { id = "txt_great",  dst = {{ x = judge_x, y = 234, w = 62, h = 14 }} },
        { id = "txt_good",   dst = {{ x = judge_x, y = 200, w = 62, h = 14 }} },
        { id = "txt_bad",    dst = {{ x = judge_x, y = 166, w = 62, h = 14 }} },
        { id = "txt_poor",   dst = {{ x = judge_x, y = 132, w = 62, h = 14 }} },

        { id = "grade_aaa", op = { prop.op.now_aaa_1p }, dst = {{ x = 25, y = 731, w = 448, h = 132 }} },
        { id = "grade_aa",  op = { prop.op.now_aa_1p },  dst = {{ x = 25, y = 731, w = 448, h = 132 }} },
        { id = "grade_a",   op = { prop.op.now_a_1p },   dst = {{ x = 25, y = 731, w = 448, h = 132 }} },
        { id = "grade_b",   op = { prop.op.now_b_1p },   dst = {{ x = 25, y = 731, w = 448, h = 132 }} },
        { id = "grade_c",   op = { prop.op.now_c_1p },   dst = {{ x = 25, y = 731, w = 448, h = 132 }} },
        { id = "grade_d",   op = { prop.op.now_d_1p },   dst = {{ x = 25, y = 731, w = 448, h = 132 }} },
        { id = "grade_e",   op = { prop.op.now_e_1p },   dst = {{ x = 25, y = 731, w = 448, h = 132 }} },
        { id = "grade_f",   op = { prop.op.now_f_1p },   dst = {{ x = 25, y = 731, w = 448, h = 132 }} },

        { id = "gaugegraph", blend = 2, dst = {{ x = 32, y = 679, w = 455, h = 241, }} },

        { id = "s_grade_aaa", op = { prop.op.now_aaa_1p },  dst = {{ x = 334, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_aa",  op = { prop.op.now_aa_1p },   dst = {{ x = 334, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_a",   op = { prop.op.now_a_1p },    dst = {{ x = 334, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_b",   op = { prop.op.now_b_1p },    dst = {{ x = 334, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_c",   op = { prop.op.now_c_1p },    dst = {{ x = 334, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_d",   op = { prop.op.now_d_1p },    dst = {{ x = 334, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_e",   op = { prop.op.now_e_1p },    dst = {{ x = 334, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_f",   op = { prop.op.now_f_1p },    dst = {{ x = 334, y = 537, w = 152, h = 28 }} },

        { id = "s_grade_aaa", op = { prop.op.best_aaa_1p }, dst = {{ x = 180, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_aa",  op = { prop.op.best_aa_1p },  dst = {{ x = 180, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_a",   op = { prop.op.best_a_1p },   dst = {{ x = 180, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_b",   op = { prop.op.best_b_1p },   dst = {{ x = 180, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_c",   op = { prop.op.best_c_1p },   dst = {{ x = 180, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_d",   op = { prop.op.best_d_1p },   dst = {{ x = 180, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_e",   op = { prop.op.best_e_1p },   dst = {{ x = 180, y = 537, w = 152, h = 28 }} },
        { id = "s_grade_f",   op = { prop.op.best_f_1p },   dst = {{ x = 180, y = 537, w = 152, h = 28 }} },

        { id = "best_clear",    dst = {{ x = 180, y = 598, w = 152, h = 24 }} },
        { id = "konkai_clear",  dst = {{ x = 334, y = 598, w = 152, h = 24 }} },
        { id = "best_score",    dst = {{ x = 212, y = 480, w =  22, h = 24 }} },
        { id = "konkai_score",  dst = {{ x = 363, y = 479, w =  24, h = 27 }} },
        { id = "konkai_missct", dst = {{ x = 363, y = 420, w =  24, h = 27 }} },
        { id = "target_score",  dst = {{ x = 363, y = 361, w =  24, h = 27 }} },
        { id = "judge_pgreat",  dst = {{ x = judge_num_x, y = 265, w =  15, h = 17 }} },
        { id = "judge_great",   dst = {{ x = judge_num_x, y = 232, w =  15, h = 17 }} },
        { id = "judge_good",    dst = {{ x = judge_num_x, y = 198, w =  15, h = 17 }} },
        { id = "judge_bad",     dst = {{ x = judge_num_x, y = 164, w =  15, h = 17 }} },
        { id = "judge_poor",    dst = {{ x = judge_num_x, y = 130, w =  15, h = 17 }} },
        { id = "cb_count",      dst = {{ x = cb_num_x,    y =  36, w =  24, h = 27 }} },
        { id = "fs_fast",       dst = {{ x = fs_num_x,    y =  63, w =  15, h = 17 }} },
        { id = "fs_slow",       dst = {{ x = fs_num_x,    y =  35, w =  15, h = 17 }} },

        { id = "fast_graph", dst = {{ x = fs_graph_x, y = 65, w = 104 * t.fast_w, h = 12 }} },
        { id = "slow_graph", dst = {{ x = fs_graph_x, y = 37, w = 104 * t.slow_w, h = 12 }} },

        -- update_clear apparently doesnt exist? TODO: find another way to do this
        -- TODO: make these float up and down (how tf does the acc property work)
     -- { id = "update_indicator", op = { prop.op.update_clear },      dst = {{ x = 473, y = 626, w = 28, h = 30 }} },
        { id = "update_indicator", op = { prop.op.update_scorerank },  dst = {{ x = 473, y = 536, w = 28, h = 30 }} },
        { id = "update_indicator", op = { prop.op.update_score },      dst = {{ x = 473, y = 477, w = 28, h = 30 }} },
        { id = "update_indicator", op = { prop.op.update_misscount },  dst = {{ x = 473, y = 418, w = 28, h = 30 }} },
        { id = "update_indicator", op = { prop.op.update_target },     dst = {{ x = 473, y = 359, w = 28, h = 30 }} },

        { id = "best_diff",   dst = {{ x = 399, y = 463, w = 12, h = 12 }} },
        { id = "missct_diff", dst = {{ x = 399, y = 404, w = 12, h = 12 }} },
        { id = "target_diff", dst = {{ x = 399, y = 345, w = 12, h = 12 }} },

        function(skin, origin_x, origin_y)
            util.make_judge_graph(skin, origin_x + x.judge_graph, origin_y + 207)
        end,
    }
end

return {
    main_pane = main_pane
}
