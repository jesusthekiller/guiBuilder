-----------------------------------------------------------------------
-- Container for color pallete.
--  
-- **Depends on:**  
-- > @{Middleclass}  
-- @usage Color = dofile("color.lua")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @classmod Color
-----------------------------------------------------------------------
local Color = class("Color")

-- LDoc

--- Field containing table indexed by color labels.
-- @usage local myColorPallete = Color:new("textColor", colors.aqua)
-- local txtColor = myColorPallete.color.textColor
-- @tfield table color

--- Color constructor
-- @string label Label for color.
-- @number color Color from `colors.colorName`. Look [here](http://bit.ly/1evHuU0). Instead of color code, you can use `"random"` for random color (every thime another color) or `"random static"` for random color that will stay same as long, as program is not closed.
-- @param ... More colors and more labels, alternaiting.
-- @usage myColorPallete = Color:new(
-- 	"text", colors.black,
-- 	"background", colors.red,
-- 	"textPressed", "random static",
-- 	"backgroundPressed", "random"
-- )
-- @function Color.new
function Color:initialize( ... )
	self.color = {}

	-- Set metatable for random colors.
	-- Set auto-checking metatale
	setmetatable(self.color, {
		__index = function(table, key)
			if (rawget(table, key) == "random") then
				return 2^math.random(0, 15)
			else
				return rawget(table, key)
			end
		end,

		__newindex = function(table, key, value) 
			if (value == "random") then
				rawset(table, key, "random")
			end

			if (value == "static random") then
				rawset(table, key, 2^math.random(0, 15))
			end

			assert(type(value) == "number", "color "..key.." is not a number, \"random static\" or \"random\"")
			assert(value%1, "Color code (color "..key..") is not a whole number")
			assert(value > 0, "Color code (color "..key..") is smaller than 1")
			assert(value < 2^16, "Color code (color "..key..") is smaller bigger than 2^16-1")

			rawset(table, key, value)
		end
	})

	-- Put colors into table
	local tmpLabel = nil
	for k, v in ipairs({ ... }) do
		if (tmpLabel == nil) then -- Label time
			tmpLabel = v
		else -- Color time
			self.color[tmpLabel] = v
			tmpLabel = nil
		end
	end
end

return Color