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

--- Safely checks if `test` is an instance of `class` [`static`].
-- @param class Class
-- @param test Object to be tested
-- @treturn bool Is instance? If any of args are not object, return false.
function Utils.static.isInstance( class, test )
	local success, result = pcall(function() return test:isInstanceOf(class) end)
	return (success and result)
end

--- Round number [`static`].
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

return Utils