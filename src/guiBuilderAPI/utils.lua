-----------------------------------------------------------------------
-- Utilities class.
--  
-- **Depends on:**  
-- > @{Middleclass}  
-- @usage Utils = dofile("utils.lua")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @classmod Utils
-----------------------------------------------------------------------
local Utils = class("Utils")

--- [`static`] Safely checks if `test` is an instance of `class`.
-- @param class Class
-- @param test Object to be tested
-- @treturn bool Is instance? If any of args are not object, return false.
function Utils.static.isInstance( class, test )
	local success, result = pcall(function() return test:isInstanceOf(class) end)
	return (success and result)
end

--- [`static`] Round number.
-- @number number
-- @treturn number Rounded number
function Utils.static.round( number )
	number = tonumber(number)
	assert(type(number) == "number", "Not a number")

	local r = number%1
	if (r < 0.5) then
		return number - r
	else
		return number + (1 - r)
	end
end

--- [`static`] Draw rectangle onto `display`.
-- @tparam Position position
-- @number color
-- @tparam Display display
function Utils.static.drawRectangle( position, color, display )
	assert(Utils.isInstance(Position, position), "Argument is not an instance of Position")
	assert(Utils.isInstance(Display, display), "Argument is not an instance of Position")
	assert(type(color) == "number", "Argument color is not an color")
	assert(color >= 0 and color < 2^16, "Invalid color code")

	display.setBackgroundColor(color)

	-- Prepare string
	local s = ""
	s = s:rep(position.width)

	-- Draw line
	for y=position.y, position.height+position.y do
		display.setCursorPos(y, position.x)
		display.rawWrite(s) -- No line folding
	end
end

return Utils