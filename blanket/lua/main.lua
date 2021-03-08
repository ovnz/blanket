local property = {}

local filepath = {}

local header = {
    type = 7,
    name = "Blanket",
    w = 1920,
    h = 1080,
    scene = 3600000,
    input = 0,
    fadeout = 500,
    property = property,
    filepath = filepath,
}

local function main()
    local skin = {}

    for k, v in pairs(header) do
        skin[k] = v
    end

    return skin
end

return {
    header = header,
    main = main,
}
