-- table containing functions returning the dst calls for every type of pane

local main_pane = require("result/panes/mainpane")
local custom = require("result/panes/custom")

return {
    main_pane = main_pane,
    custom = custom
}
