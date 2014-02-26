-----------------------------------------------------------------------
-- Postiton class.
--  
-- **Depends on:**  
-- > @{Middleclass}   
-- @usage Position = dofile("position.lua")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @classmod Position
-----------------------------------------------------------------------
local Position = class("Position")

-- LDoc

--- X coords fo upper left corner.
-- @field Position.x

--- Y coords fo upper left corner.
-- @field Position.y

--- Width.
-- @field Position.width

--- Height.
-- @field Position.height

--- Position constructor.
-- @number x
-- @number y
-- @number width Bigger than 0
-- @number height Bigger than 0
-- @usage myPosition = Position:new( x, y, width, height )
function Position:initialize( x, y, width, height )
	assert(type(x) == "number", "Argument x is not a number")
	assert(type(y) == "number", "Argument y is not a number")
	assert(type(height) == "number", "Argument height is not a number")
	assert(type(width) == "number", "Argument width is not a number")

	assert(width > 0, "Width is <= 0")
	assert(height > 0, "Height is <= 0")

	self.x = Utils.round(x)
	self.y = Utils.round(y)
	self.width = Utils.round(width)
	self.height = Utils.round(height)
end