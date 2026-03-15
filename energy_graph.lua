local charts = require("charts")
local component = require("component")

-- parameters
local tank_face = 5

local graph_width = 35
local graph_height = 17
local short_spacing = 2
local long_spacing = 12
local bar_width = 2 * graph_width + short_spacing
local bar_height = 8

-- fuel graphs


local fuel_bar = charts.Container{
    x = short_spacing,
    y = short_spacing,
    bg = 0x808080,
    width = bar_width,
    height = bar_height
}

local fuel_long = charts.Container{
    x = short_spacing,
    y = 2 * short_spacing + bar_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}
local fuel_long_G = charts.Histogram {
    max = 41472000, -- change dinamically
    align = charts.sides.RIGHT,
    colorFunc = function(index, norm, value, self, contrainer)
        return 0x20ff20
    end
}
fuel_long.payload = fuel_long_G


local fuel_long_delta = charts.Container{
    x = 2 * short_spacing + graph_width,
    y = 2 * short_spacing + bar_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}


local fuel_short = charts.Container{
    x = short_spacing,
    y = 3 * short_spacing + bar_height + graph_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}


local fuel_short_delta = charts.Container{
    x = 2 * short_spacing + graph_width,
    y = 3 * short_spacing + bar_height + graph_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}

-- EU graphs

local EU_bar = charts.Container{
    x = 2 * short_spacing + 2 * graph_width + long_spacing,
    y = short_spacing,
    bg = 0x808080,
    width = bar_width,
    height = bar_height
}

local EU_long = charts.Container{
    x = 2 * short_spacing + 2 * graph_width + long_spacing,
    y = 2 * short_spacing + bar_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}


local EU_long_delta = charts.Container{
    x = 3 * short_spacing + 3 * graph_width + long_spacing,
    y = 2 * short_spacing + bar_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}


local EU_short = charts.Container{
    x = 2 * short_spacing + 2 * graph_width + long_spacing,
    y = 3 * short_spacing + bar_height + graph_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}


local EU_short_delta = charts.Container{
    x = 3 * short_spacing + 3 * graph_width + long_spacing,
    y = 3 * short_spacing + bar_height + graph_height,
    bg = 0x808080,
    width = graph_width,
    height = graph_height
}

-- draw 

while 1 do
    table.insert(fuel_long_G.values, component.transposer.getTankLevel(tank_face))
    
    -- stock containers and graphs in maps to do that more efficiently
    fuel_bar:draw()
    fuel_long:draw()
    fuel_long_delta:draw()
    fuel_short:draw()
    fuel_short_delta:draw()
    EU_bar:draw()
    EU_long:draw()
    EU_long_delta:draw()
    EU_short:draw()
    EU_short_delta:draw()


    os.sleep(.05)
end