local charts = require("charts")
local component = require("component")

local fuel_long = charts.Container{
    x = 2,
    y = 12,
    bg = 0x808080,
    width = 35,
    height = 17
}
local fuel_long_G = charts.Histogram {
    max = 41472000, -- change dinamically
    align = charts.sides.RIGHT,
    colorFunc = function(index, norm, value, self, contrainer)
        return 0x20ff20
    end
}
fuel_long.payload = fuel_long_G

local continue = 1
while continue == 1 do
    table.insert(fuel_long_G.values, component.transposer.getTankLevel(5))
    fuel_long:draw()
    os.sleep(.05)
end