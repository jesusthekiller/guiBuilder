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
-- @field Event.parameters

--- Type of event.
-- Is field from @{Event.type}
-- @usage if (myEvent.event == Event.type.alarm) then
-- 	print("Alarm just fired!")
-- end
-- @field Event.event

--- Event types.
-- @field display_touch Fires when @{Display} is touched. Parameters: `x`, `y`, `mouse button` (when monitor always `1`)
-- @field http Combined `http_success` and `http_failure`. Parameters: `success`, `url`, `site contents` (when failed `nil`)
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
	display_touch = "display_touch",
	http = "http",

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

--- Check if eventType is valid @{Event.type}.
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
-- @tab parameters Table containing all event parameters; number indexed; starting from 1
-- @function Event.new
function Event:initialize( eventType, parameters )
	assert(Event.isEventType(eventType), "Parameter #1 is not valid Event.type")
	assert(type(params) == "table", "Parameter #2 is not an table")

	self.event = eventType
	self.parameters = parameters
end

return Event