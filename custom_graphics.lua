local gpu = require("gpu")

local custom_graphics = {}

function custom_graphics.write(text, x, y)
  local rel_x = 0
  local c_str = ffi.new("char[?]", #text + 1)
  ffi.copy(c_str, text)
  for char in c_str do
    gpu.fill(char, x + rel_x, y)
  end
end

return custom_graphics