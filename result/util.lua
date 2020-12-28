local main_state = require("main_state")
local prop = require("prop")

local function total_played_notes()
    return main_state.number(prop.num.perfect)
         + main_state.number(prop.num.great)
         + main_state.number(prop.num.good)
         + main_state.number(prop.num.bad)
         + main_state.number(prop.num.poor)
end

local function next_grade()
    if     main_state.option(prop.op._1p_aaa) then return "max"
    elseif main_state.option(prop.op._1p_aa)  then return "aaa"
    elseif main_state.option(prop.op._1p_a)   then return "aa"
    elseif main_state.option(prop.op._1p_b)   then return "a"
    elseif main_state.option(prop.op._1p_c)   then return "b"
    elseif main_state.option(prop.op._1p_d)   then return "c"
    elseif main_state.option(prop.op._1p_e)   then return "d"
    elseif main_state.option(prop.op._1p_f)   then return "e"
    else return nil end
end

local function next_grade_diff()
    local ex = main_state.number(prop.num.score)
    local max = main_state.number(prop.num.maxscore)
    local rate = ex / max
    local nextrate
    for n = 1, 9 do
        if rate < n / 9 then
            nextrate = n / 9
            break
        end
    end
    return math.floor(max * nextrate)
end

local function make_judge_graph(skin, centre_x, centre_y)
    -- local origin = { x = 1551 - 75, y = 269 - 4, w = 150, h = 8 }
    local origin = { x = centre_x - 75, y = centre_y - 4, w = 150, h = 8 }
    local start_angle = 90

    local poor_ct   = main_state.number(prop.num.poor)
    local bad_ct    = main_state.number(prop.num.bad)
    local good_ct   = main_state.number(prop.num.good)
    local great_ct  = main_state.number(prop.num.great)
    local pgreat_ct = main_state.number(prop.num.perfect)
    local total_notes = total_played_notes()

    local poor_a    = poor_ct
    local bad_a     = bad_ct + poor_a
    local good_a    = good_ct + bad_a
    local great_a   = great_ct + good_a
    local pgreat_a  = pgreat_ct + great_ct

    local poor      = 360 * (poor_a / total_notes)
    local bad       = 360 * (bad_a / total_notes)
    local good      = 360 * (good_a / total_notes)
    local great     = 360 * (great_a / total_notes)
    local pgreat    = 360 * (pgreat_a / total_notes)

    for i=0,360,0.5 do
        local colour
        if i < poor then
            colour = { r = 255, g =   0, b =   0 }
        elseif i < bad then
            colour = { r = 255, g = 127, b =   0 }
        elseif i <= good then
            colour = { r = 255, g = 196, b =   0 }
        elseif i <= great then
            colour = { r = 255, g = 255, b =   0 }
        else
            colour = { r =   0, g = 127, b = 255 }
        end
        local angle = start_angle + i
        table.insert(skin.destination, { id = "judge_graph", filter = 1, dst = {
            { x = origin.x, y = origin.y, w = origin.w, h = origin.h,
              r = colour.r, g = colour.g, b = colour.b,
              angle = angle }
        }})
    end

    table.insert(skin.destination, { id = "judge_graph_border", dst = {
        { x = centre_x - 154 / 2, y = centre_y - 154 / 2, w = 154, h = 154 }
    }})
end

return {
    total_played_notes = total_played_notes,
    make_judge_graph = make_judge_graph,
    next_grade = next_grade,
    next_grade_diff = next_grade_diff,
}
