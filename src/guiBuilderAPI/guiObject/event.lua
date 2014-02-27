-----------------------------------------------------------------------
-- Defines all events supported by guiBuilder.
--  
-- **Depends on:**  
-- > @{Middleclass}  
-- @usage Event = dofile("event.lua")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @classmod Event
-----------------------------------------------------------------------
local Event = class("Event")

-- LDoc

--- Parametes of event.
-- Table indexed from 1.
-- @usage for key, value in ipairs( myEvent.paratemets ) do
-- 	print(key..": "..value)
-- end
-- @field Event.param

--- Type of event.
-- Is field from @{Event.type}
-- @usage if (myEvent.type == Event.type.alarm) then
-- 	print("Alarm just fired!")
-- end
-- @field Event.type

--- [`static`] Event types.
-- @field clicked Fires when object is clicked. For user's listeners. **Note:** *Has to be implemented by subclass of GuiObject*
-- @field display_touch Fires when @{Display} is touched. Parameters: `x`, `y`, `mouse button` (when monitor always `1`)
-- @field http Combined `http_success` and `http_failure`. Parameters: `success`, `url`, `site contents` (when failed `nil`)
-- @field stop Event fired, when @{Gui:stop} is called.
-- @field mouse_scroll Terminal only
-- @field mouse_drag Terminal only
-- @field char Terminal only
-- @field key Terminal only
-- @field alarm
-- @field redstone
-- @field disk
-- @field disk_eject
-- @field peripheral
-- @field peripheral_detach
-- @field rednet_message
-- @field modem_message
-- @field http_success
-- @field http_failure
-- @field turtle_inventory Turtle only
-- @field terminate
-- @table Event.type
Event.static.type = {
	clicked = "clicked",
	display_touch = "display_touch",
	http = "http",
	stop = "stop",

	char = "char",
	key = "key",
	alarm = "alarm",
	redstone = "redstone",
	terminate = "terminate",
	disk = "disk",
	disk_eject = "disk_eject",
	peripheral = "peripheral",
	peripheral_detach = "peripheral_detach",
	rednet_message = "rednet_message",
	modem_message = "modem_message",
	http_success = "http_success",
	http_failure = "http_failure",
	mouse_scroll = "mouse_scroll",
	mouse_drag = "mouse_drag",
	turtle_inventory = "turtle_inventory",
}

--- [`static`] Check if eventType is valid @{Event.type}.
-- @tparam Event.type eventType
function Event.static.isEventType( eventType )
	-- Validate eventType
	local ok = false

	for _,v in pairs(Event.type) do
		ok = (eventType == v)
		if ok then break end
	end

	return ok
end

--- Event constructor.
-- @tparam Event.type eventType
-- @param ... Event parameters
-- @usage local myEvent = Event:new( Event.type.display_touch, params )
-- @function Event.new
function Event:initialize( eventType, ... )
	local parameters = {...}
	assert(Event.isEventType(eventType), "Parameter \"eventType\" is not valid Event.type")

	self.type = eventType
	self.param = parameters
	-- self.parameters = self.param
end

--- Check if event of type `display_touch` is within `position`.
-- @tparam Position position
-- @treturn bool
function Event:isWithin( position )
	assert(Utils.isInstance(Position, position), "Argument \"position\" is not an instance of Position")
	assert(self.type == Event.type.display_touch, "Event is not as \"display_touch\" event")
	local ex, ey = tonumber(self.param[1]), tonumber(self.param[2])
	local minX, minY = position.x, position.y
	local maxX, maxY = minX+position.width-1, minY+position.height-1
	--                Within X range                    Within Y range
	return (((ex >= minX) and (ex <= maxX)) and ((ey >= minY) and (ey <= maxY)))
end

return Event