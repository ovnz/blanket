local main_state = require("main_state")

local prop = require("prop")
local SkinObject = require("skin_object")

local util = require("result/util")

local main_pane = require("result/pane/mainpane")
local custom = require("result/pane/custom")

return {
    main_pane = main_pane.pane,
    custom = custom
}
