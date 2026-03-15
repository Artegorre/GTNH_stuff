local charts = require("charts")
local component = require("component")
local term = require("term")

-- parameters
local tank_face = 5

local graph_width = 35
local graph_height = 17
local short_spacing = 2
local long_spacing = 12
local bar_width = 2 * graph_width + short_spacing
local bar_height = 8


-- variables
local containers = {}
local graphs = {}

-- fuel graphs
local fuel_bar = charts.Container{
    x = short_spacing,
    y = short_spacing,
    bg = 0x808080,
    width = bar_width,
    height = bar_height
}
local fuel_bar_G = charts.ProgressBar{
}
fuel_bar.payload = fuel_bar_G
containers["fuel_bar"] = fuel_bar
graphs["fuel_bar"] = fuel_bar_G

local fuel_long = charts.Container{
    x = short_spacing,
    y = 2 * short_spacing + bar_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}
local fuel_long_G = charts.Histogram {
    max = component.transposer.getTankCapacity(tank_face),
    align = charts.sides.RIGHT,
    colorFunc = function(index, norm, value, self, contrainer)
        return 0x20ff20
    end
}
fuel_long.payload = fuel_long_G
containers["fuel_long"] = fuel_long
graphs["fuel_long"] = fuel_long_G


local fuel_long_delta = charts.Container{
    x = 2 * short_spacing + graph_width,
    y = 2 * short_spacing + bar_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}
local fuel_long_delta_G = charts.Histogram {
}
fuel_long_delta.payload = fuel_long_delta_G
containers["fuel_long_delta"] = fuel_long_delta
graphs["fuel_long_delta"] = fuel_long_delta_G


local fuel_short = charts.Container{
    x = short_spacing,
    y = 3 * short_spacing + bar_height + graph_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}
local fuel_short_G = charts.Histogram {
}
fuel_short.payload = fuel_short_G
containers["fuel_short"] = fuel_short
graphs["fuel_short"] = fuel_short_G


local fuel_short_delta = charts.Container{
    x = 2 * short_spacing + graph_width,
    y = 3 * short_spacing + bar_height + graph_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}
local fuel_short_delta_G = charts.Histogram {
}
fuel_short_delta.payload = fuel_short_delta_G
containers["fuel_short_delta"] = fuel_short_delta
graphs["fuel_short_delta"] = fuel_short_delta_G


-- EU graphs
local EU_bar = charts.Container{
    x = 2 * short_spacing + 2 * graph_width + long_spacing,
    y = short_spacing,
    bg = 0x808080,
    width = bar_width,
    height = bar_height
}
local EU_bar_G = charts.ProgressBar{
}
EU_bar.payload = EU_bar_G
containers["EU_bar"] = EU_bar
graphs["EU_bar"] = EU_bar_G

local EU_long = charts.Container{
    x = 2 * short_spacing + 2 * graph_width + long_spacing,
    y = 2 * short_spacing + bar_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}
local EU_long_G = charts.Histogram {
}
EU_long.payload = EU_long_G
containers["EU_long"] = EU_long
graphs["EU_long"] = EU_long_G


local EU_long_delta = charts.Container{
    x = 3 * short_spacing + 3 * graph_width + long_spacing,
    y = 2 * short_spacing + bar_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}
local EU_long_delta_G = charts.Histogram {
}
EU_long_delta.payload = EU_long_delta_G
containers["EU_long_delta"] = EU_long_delta
graphs["EU_long_delta"] = EU_long_delta_G


local EU_short = charts.Container{
    x = 2 * short_spacing + 2 * graph_width + long_spacing,
    y = 3 * short_spacing + bar_height + graph_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}
local EU_short_G = charts.Histogram {
}
EU_short.payload = EU_short_G
containers["EU_short"] = EU_short
graphs["EU_short"] = EU_short_G


local EU_short_delta = charts.Container{
    x = 3 * short_spacing + 3 * graph_width + long_spacing,
    y = 3 * short_spacing + bar_height + graph_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}
local EU_short_delta_G = charts.Histogram {
}
EU_short_delta.payload = EU_short_delta_G
containers["EU_short_delta"] = EU_short_delta
graphs["EU_short_delta"] = EU_short_delta_G


-- update and draw 
term.clear()

while 1 do
    -- update every 10 minutes
    table.insert(graphs["fuel_long"].values, component.transposer.getTankLevel(tank_face))


    for i=1,60,1 do
        -- update every 10 seconds
        table.insert(graphs["fuel_short"].values, component.transposer.getTankLevel(tank_face))
    
        -- draw
        for k,v in pairs(containers) do
            v:draw()
        end
        os.sleep(10)
    end
end