local main_state = require("main_state")

local prop = require("prop")
local SkinObject = require("skin_object")

local util = require("result/util")

local function gauge_graph(t)
    local bg_x, bg_w = 0, 463

    if t.flip then
        bg_x, bg_w = bg_w, -bg_w
    end

    return {
        { id = "bg_graph",   dst = {{ x = bg_x, y = 0, w = bg_w, h = 256 }} },

        { id = "grade_aaa", op = { prop.op.now_aaa_1p }, dst = {{ x = 7, y = 60, w = 448, h = 132 }} },
        { id = "grade_aa",  op = { prop.op.now_aa_1p },  dst = {{ x = 7, y = 60, w = 448, h = 132 }} },
        { id = "grade_a",   op = { prop.op.now_a_1p },   dst = {{ x = 7, y = 60, w = 448, h = 132 }} },
        { id = "grade_b",   op = { prop.op.now_b_1p },   dst = {{ x = 7, y = 60, w = 448, h = 132 }} },
        { id = "grade_c",   op = { prop.op.now_c_1p },   dst = {{ x = 7, y = 60, w = 448, h = 132 }} },
        { id = "grade_d",   op = { prop.op.now_d_1p },   dst = {{ x = 7, y = 60, w = 448, h = 132 }} },
        { id = "grade_e",   op = { prop.op.now_e_1p },   dst = {{ x = 7, y = 60, w = 448, h = 132 }} },
        { id = "grade_f",   op = { prop.op.now_f_1p },   dst = {{ x = 7, y = 60, w = 448, h = 132 }} },

        { id = "gaugegraph", blend = 2, dst = {{ x = 6, y = 7, w = 455, h = 241, }} },
    }
end

local function score_info(t)
    local bg_x, bg_w = 0, 463
    local txt_x, up_x, grade_y = 17, 449, 133

    if t.flip then
        bg_x, bg_w = bg_w, -bg_w
    end

    local update_clear, update_scorerank, update_score, update_target
        = "noupdate_indicator", "noupdate_indicator", "noupdate_indicator", "noupdate_indicator"
    if main_state.number(prop.num.clear) > main_state.number(prop.num.target_clear) then update_clear = "update_indicator" end
    if main_state.option(prop.op.update_scorerank) then update_scorerank = "update_indicator" end
    if main_state.option(prop.op.update_score) then update_score = "update_indicator" end
    if main_state.option(prop.op.update_target) then update_target = "update_indicator" end

    return {
        { id = "bg_update2", dst = {{ x = bg_x, y =   6, w = bg_w, h = 47 }} },
        { id = "bg_update1", dst = {{ x = bg_x, y =  65, w = bg_w, h = 47 }} },
        { id = "bg_update1", dst = {{ x = bg_x, y = 124, w = bg_w, h = 47 }} },
        { id = "bg_update1", dst = {{ x = bg_x, y = 183, w = bg_w, h = 47 }} },

        { id = "txt_best",   dst = {{ x = 168, y = 238, w = 127, h =  22 }} },
        { id = "txt_konkai", dst = {{ x = 322, y = 237, w = 127, h =  22 }} },

        { id = "txt_target",  dst = {{ x = txt_x, y =  22, w = 128, h = 15 }} },
        { id = "txt_score",   dst = {{ x = txt_x, y =  81, w = 128, h = 15 }} },
        { id = "txt_grade",   dst = {{ x = txt_x, y = 139, w = 128, h = 15 }} },
        { id = "txt_clearty", dst = {{ x = txt_x, y = 199, w = 128, h = 15 }} },

        { id = "s_grade_aaa", op = { prop.op.now_aaa_1p },  dst = {{ x = 310, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_aa",  op = { prop.op.now_aa_1p },   dst = {{ x = 310, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_a",   op = { prop.op.now_a_1p },    dst = {{ x = 310, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_b",   op = { prop.op.now_b_1p },    dst = {{ x = 310, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_c",   op = { prop.op.now_c_1p },    dst = {{ x = 310, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_d",   op = { prop.op.now_d_1p },    dst = {{ x = 310, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_e",   op = { prop.op.now_e_1p },    dst = {{ x = 310, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_f",   op = { prop.op.now_f_1p },    dst = {{ x = 310, y = grade_y, w = 152, h = 28 }} },

        { id = "s_grade_aaa", op = { prop.op.best_aaa_1p }, dst = {{ x = 156, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_aa",  op = { prop.op.best_aa_1p },  dst = {{ x = 156, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_a",   op = { prop.op.best_a_1p },   dst = {{ x = 156, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_b",   op = { prop.op.best_b_1p },   dst = {{ x = 156, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_c",   op = { prop.op.best_c_1p },   dst = {{ x = 156, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_d",   op = { prop.op.best_d_1p },   dst = {{ x = 156, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_e",   op = { prop.op.best_e_1p },   dst = {{ x = 156, y = grade_y, w = 152, h = 28 }} },
        { id = "s_grade_f",   op = { prop.op.best_f_1p },   dst = {{ x = 156, y = grade_y, w = 152, h = 28 }} },

        { id = "best_clear",    dst = {{ x = 156, y = 195, w = 152, h = 24 }} },
        { id = "konkai_clear",  dst = {{ x = 310, y = 195, w = 152, h = 24 }} },
        { id = "best_score",    dst = {{ x = 188, y =  76, w =  22, h = 24 }} },
        { id = "konkai_score",  dst = {{ x = 339, y =  75, w =  24, h = 27 }} },
        { id = "target_score",  dst = {{ x = 339, y =  16, w =  24, h = 27 }} },

        { id = update_clear,     dst = {{ x = up_x, y = 192, w = 28, h = 30 }} },
        { id = update_scorerank, dst = {{ x = up_x, y = 133, w = 28, h = 30 }} },
        { id = update_score,     dst = {{ x = up_x, y =  74, w = 28, h = 30 }} },
        { id = update_target,    dst = {{ x = up_x, y =  15, w = 28, h = 30 }} },

        { id = "best_diff",   dst = {{ x = 375, y = 59, w = 12, h = 12 }} },
        { id = "target_diff", dst = {{ x = 375, y =  0, w = 12, h = 12 }} },

        { id = "best_rate",       dst = {{ x = 199, y = 118, w = 12, h = 12 }} },
        { id = "dot",             dst = {{ x = 223, y = 118, w =  3, h =  4 }} },
        { id = "best_rate_dec",   dst = {{ x = 226, y = 118, w = 12, h = 12 }} },
        { id = "percent",         dst = {{ x = 250, y = 118, w = 12, h = 12 }} },

        { id = "konkai_rate",     dst = {{ x = 352, y = 118, w = 12, h = 12 }} },
        { id = "dot",             dst = {{ x = 376, y = 118, w =  3, h =  4 }} },
        { id = "konkai_rate_dec", dst = {{ x = 379, y = 118, w = 12, h = 12 }} },
        { id = "percent",         dst = {{ x = 403, y = 118, w = 12, h = 12 }} },
    }
end

local function misscount_combo(t)
    local bg_x, bg_w = 0, 463
    local missct_x, combo_x, missct_num_x, combo_num_x, missct_diff_x, combo_diff_x, missct_up_x, combo_up_x
        = 53,       293,     65,           262,         82,            318,          212,         449

    if t.flip then
        bg_x, bg_w = bg_w, -bg_w
        missct_x, combo_x, missct_num_x, combo_num_x, missct_diff_x, combo_diff_x, missct_up_x,    combo_up_x
        = 303,    69,      303,          24,          335,           99,           combo_up_x - 1, missct_up_x
    end

    local update_missct, update_combo = "noupdate_indicator", "noupdate_indicator"
    if main_state.option(prop.op.update_misscount) then update_missct = "update_indicator" end
    if main_state.option(prop.op.update_maxcombo) then update_maxcombo = "update_indicator" end

    return {
        { id = "bg_miss_combo", dst = {{ x = bg_x, y = 6, w = bg_w, h = 65 }} },

        { id = "txt_missct",   dst = {{ x = missct_x, y = 59, w = 121, h = 9 }} },
        { id = "txt_maxcombo", dst = {{ x = combo_x,  y = 59, w = 115, h = 9 }} },
        { id = "slash",        dst = {{ x = combo_num_x + 99, y = 18, w = 14, h = 25 }} },

        { id = "missct",       dst = {{ x = missct_num_x, y = 17, w = 24, h = 27 }} },
        { id = "combo",        dst = {{ x = combo_num_x,  y = 17, w = 24, h = 27 }} },
        { id = "maxcombo",     dst = {{ x = combo_num_x + 116, y = 17, w = 15, h = 17 }} },

        { id = "missct_diff",  dst = {{ x = missct_diff_x, y = 0, w = 12, h = 12 }} },
        { id = "combo_diff",   dst = {{ x = combo_diff_x,  y = 0, w = 12, h = 12 }} },

        { id = update_missct,  dst = {{ x = missct_up_x,   y = 23, w = 28, h = 30 }} },
        { id = update_combo,   dst = {{ x = combo_up_x,    y = 23, w = 28, h = 30 }} },
    }
end

local function judge_detail(t)
    local text_x, num_x, graph_x = 243, 389, 118
    local bg_x, bg_w = 0, 463

    if t.flip then
        text_x, num_x, graph_x = 14, 160, bg_w - graph_x
        bg_x, bg_w = bg_w, -bg_w
    end

    return {
        { id = "bg_judge",   dst = {{ x = bg_x, y = 0, w = bg_w, h = 194 }} },

        { id = "txt_judge", dst = {{ x = 162, y = 176, w = 141, h = 11 }} },

        { id = "txt_judge_bg",  dst = {{ x = text_x - 15, y = 136, w = 86, h = 32 }} },
        { id = "txt_judge_bg",  dst = {{ x = text_x - 15, y = 102, w = 86, h = 32 }} },
        { id = "txt_judge_bg",  dst = {{ x = text_x - 15, y =  68, w = 86, h = 32 }} },
        { id = "txt_judge_bg",  dst = {{ x = text_x - 15, y =  34, w = 86, h = 32 }} },
        { id = "txt_judge_bg",  dst = {{ x = text_x - 15, y =   0, w = 86, h = 32 }} },

        { id = "txt_pgreat", dst = {{ x = text_x, y = 145, w = 62, h = 14 }} },
        { id = "txt_great",  dst = {{ x = text_x, y = 111, w = 62, h = 14 }} },
        { id = "txt_good",   dst = {{ x = text_x, y =  77, w = 62, h = 14 }} },
        { id = "txt_bad",    dst = {{ x = text_x, y =  43, w = 62, h = 14 }} },
        { id = "txt_poor",   dst = {{ x = text_x, y =   9, w = 62, h = 14 }} },

        { id = "judge_pgreat",  dst = {{ x = num_x, y = 143, w =  15, h = 17 }} },
        { id = "judge_great",   dst = {{ x = num_x, y = 110, w =  15, h = 17 }} },
        { id = "judge_good",    dst = {{ x = num_x, y =  76, w =  15, h = 17 }} },
        { id = "judge_bad",     dst = {{ x = num_x, y =  42, w =  15, h = 17 }} },
        { id = "judge_poor",    dst = {{ x = num_x, y =   8, w =  15, h = 17 }} },

        function(skin, origin_x, origin_y)
            util.make_judge_graph(skin, origin_x + graph_x, origin_y + 84)
        end,
    }
end

local function fs_combo_break(t)
    local bg_x, bg_w = 0, 463
    local cb_x, fs_x, cb_num_x, fs_num_x, fs_graph_x =
        319, 25, 332, 116, 169

    if t.flip then
        bg_x, bg_w = bg_w, -bg_w
        cb_x, fs_x, cb_num_x, fs_num_x, fs_graph_x =
            23, 367, 35, 191, 244
    end

    local fast_count = main_state.number(prop.num.totalearly)
    local slow_count = main_state.number(prop.num.totallate)
    local note_count = util.total_played_notes()

    local fast_w = fast_count / note_count
    local slow_w = slow_count / note_count

    return {
        { id = "bg_fs",     dst = {{ x = bg_x, y =  0, w = bg_w, h =  64 }} },

        { id = "txt_cb",    dst = {{ x = cb_x, y = 53, w = 120, h =  8 }} },
        { id = "txt_fast",  dst = {{ x = fs_x, y = 38, w =  71, h = 17 }} },
        { id = "txt_slow",  dst = {{ x = fs_x, y = 10, w =  71, h = 17 }} },

        { id = "cb_count",  dst = {{ x = cb_num_x, y = 12, w =  24, h = 27 }} },
        { id = "fs_fast",   dst = {{ x = fs_num_x, y = 39, w =  15, h = 17 }} },
        { id = "fs_slow",   dst = {{ x = fs_num_x, y = 11, w =  15, h = 17 }} },

        { id = "fast_graph", dst = {{ x = fs_graph_x, y = 41, w = 104 * fast_w, h = 12 }} },
        { id = "slow_graph", dst = {{ x = fs_graph_x, y = 13, w = 104 * slow_w, h = 12 }} },
    }
end

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

        SkinObject:new(gauge_graph(t),     24, 672),
        SkinObject:new(score_info(t),      24, 405),
        SkinObject:new(misscount_combo(t), 24, 319),
        SkinObject:new(judge_detail(t),    24, 110),
        SkinObject:new(fs_combo_break(t),  24,  24),
    }
end

return {
    pane = main_pane,
    objects = {
        gauge_graph     = { obj = gauge_graph,     dim = { w = 463, h = 256 },
                                op = prop.prop.custom_gauge_graph  },
        score_info      = { obj = score_info,      dim = { w = 463, h = 259 },
                                op = prop.prop.custom_score_info   },
        misscount_combo = { obj = misscount_combo, dim = { w = 463, h =  71 },
                                op = prop.prop.custom_missct_combo },
        judge_detail    = { obj = judge_detail,    dim = { w = 463, h = 194 },
                                op = prop.prop.custom_judge_detail },
        fs_combo_break  = { obj = fs_combo_break,  dim = { w = 463, h =  64 },
                                op = prop.prop.custom_fs_cb        },
    },
}
