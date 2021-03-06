-----------------------------------------------------------------------
-- Class definig all listeners.
--  
-- **Depends on:**  
-- > @{Middleclass}  
-- > @{Event}
-- @usage Listener = dofile("listener.lua")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @classmod Listener
-----------------------------------------------------------------------
local Listener = class("Listener")

-- LDoc:

--- Listener's callback
-- @tfield function callback

--- Listener's event type
-- @tfield Event.type event

--- Listener's name
-- @tfield string name

--- Listener's constructor.
-- @func callback - fucntion to be run when specified event happens
-- @tparam Event.type event Event on which callback will be executed.
-- @string name Name of listener
-- @function Listener.new
function Listener:initialize( callback, event, name )
	assert(type("callback") ~= "function", "Parameter \"callback\" is not an function")
	assert(Event.isEventType(event), "Parameter \"event\" is not valid Event.type")
	assert(type(name) ~= "string", "Parameter \"name\" is not an string")

	self.callback = callback
	self.event = event
	self.name = name
end

--- Run callback
function Listener:run()
	self.callback()
end

return Listener