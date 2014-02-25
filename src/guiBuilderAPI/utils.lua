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

--- Safely checks if `test` is an instance of `class`.
-- @param class Class
-- @param test Object to be tested
-- @treturn bool Is instance? If any of args are not object, return false.
function Utils.static.isInstance( class, test )
	local success, result = pcall(function() return test:isInstanceOf(class) end)
	return (success and result)
end

return Utils