-----------------------------------------------------------------------
-- Connection class.
--
-- **Depends on:** 
-- > @{Middleclass}
-- @usage Connection = dofile("connection.lua")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @classmod Connection
-----------------------------------------------------------------------

local Connection = class("Connection")

--- ConnectionType enum [`static`].
-- @field terminal
-- @field peripheral
-- @field network
-- @table connectionType
-- @usage Connection:new( Conncetion.conectionType.peripheral, ... )
Connection.static.connectionType = {
	terminal = 0,
	peripheral = 1,
	network = 2,
}

--- Connection class constructor.  
-- address does not matter when connectionType.terminal  
-- address is one of sides (top, right, etc.) when connectionType.peripheral  
-- <s>address is "modemSide:networkAddress" when connectionType.network</s> **NYI**
--
-- @tparam connectionType connectionType Type of connection
-- @tparam string address Destiantion
-- @usage local myMonitor = Connection.new( Connection.connectionType.side, "top" )
-- @usage local myTerminal = Connection.new( Connection.connectionType.terminal )
-- @warning Monitors via networking are not yet implemented
-- @todo Monitors via networking
-- @function Connection.new
function Connection:initialize( connectionType, address )
	assert(self ~= nil, "Call it using ':', i.e Connection:new()")
	if(connectionType == Connection.connectionType.terminal) then
		self.native = term
	elseif(connectionType == Connection.connectionType.peripheral) then
		self.native = peripheral.wrap(address)
	elseif(connectionType == Connection.connectionType.network) then
		error("connectionType.network is not yet implemented...")
	else
		error("Unknown connectionType!")
	end

	self.type = connectionType

	return self
end

return Connection