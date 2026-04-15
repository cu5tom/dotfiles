local misc = require("mini.misc")

local M = {}

M.later = function(f)
	misc.safely("later", f)
end

M.on_event = function(event, f)
	misc.safely("event:" .. event, f)
end

return M
