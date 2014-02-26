-----------------------------------------------------------------------
-- Superclass for all Gui objects.
-- This file is a template for your gui objects.  
-- **All gui objects have to implement ALL functions from this class!**  
-- Also, **All gui objects have be a subclass of GuiObject!**  
-- For information, how to make a subclass, look at `usage` bellow.
--  
-- **Depends on:**  
-- > @{Middleclass}  
-- > @{Event}  
-- > @{Listener}  
-- @usage GuiObject = dofile("guiObject.lua")
-- @usage -- Make new class using GuiObject as superclass
-- Button = class("Button", GuiObject)
-- -- This will also work:
-- Button = GuiObject:subclass("Button")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @classmod GuiObject
-----------------------------------------------------------------------
local GuiObject = class("guiObject")

--- Listeners table.
-- Table contains every registered listener.
-- Indexed by @{Listener.name}
-- @tfield table listenersTable

--- X position of upper left corner
-- @field x

--- Y position of uppse left corner
-- @field y

--- Width of your object
-- @field width

--- Height of your object
-- @field height

--- GuiObject constructor.
-- Child's constructor has to call parrent's constructor or implement all code from GuiObject constructor.
-- @number x X position of upper left corner
-- @number y Y position of uppse left corner
-- @number width Width of your object
-- @number height Height of your object
-- @param ... Other parameters that your GuiObject might need
-- @usage -- Call parrent's constructor
-- --       +---- Note dot here
-- --       V
-- GuiObject.new( self, x, y, width, height )
-- @function GuiObject.new
function GuiObject:initialize( x, y, width, height, ... )
	self.x, self.y, self.width, self.height = x, y, width, height
	self.listenersTable = {}
end

--- Draw function.
-- Called by @{Gui}
function GuiObject:draw()
	error("Your Gui object does not implement draw() funciton!")
end

--- Event receiver function.
-- Called by @{Gui}. All listeners will be launched from here.
-- @tparam Event event
function GuiObject:event( event )
	error("Your Gui object does not implement event() funciton!")
end

--- Add listener [`predefined`].
-- @tparam Listener listener
-- @param ... More listeners
-- @treturn bool False if this listener was already registered
-- @return ... one bool for each listener, in same order as in input
function GuiObject:addListener( ... )
	local args, ret = { ... }, {}

	for k,v in ipairs(argv) do
		assert(Utils.isInstance(Listener, "Argument #"..k.." is not an instance of class Listener"))

		ret[k] = (self.listenersTable[v.name])
		if (ret[k]) then self.listenersTable[v.name] = v end
	end

	return unpack(ret)
end

--- Remove listener from listeners list using @{Listener} object [`predefined`].
-- @tparam Listener listener Listener's name from @{Listener} constructor.
-- @param ... More listeners
-- @treturn bool False if this listener does not exists anymore
-- @return ... one bool for each listener, in same order as in input
function GuiObject:removeListener( ... )
		local argv, ret = { ... }, {}
	assert(#argv > 0, "No arguments specified")

	for k,v in ipairs(argv) do
		assert(Utils.isInstance(Listener, v), "Argument #"..k.." is not an instance of class Listener")
		
		ret[k] = (self.listenersTable[v.name] ~= nil)
		self.listenersTable[v.name] = nil
	end

	return unpack(ret)
end

--- Remove listener from listeners list using listeners name [`predefined`].
-- @string listenerName Listener's name from @{Listener} constructor.
-- @param ... More listeners
-- @treturn bool False if this listener does not exists anymore
-- @return ... one bool for each listener, in same order as in input
function GuiObject:removeListenerByName( ... )
	local argv, ret = { ... }, {}
	assert(#argv > 0, "No arguments specified")

	for k,v in ipairs(argv) do
		ret[k] = (self.listenersTable[v] ~= nil)
		self.listenersTable[v] = nil
	end

	return unpack(ret)
end

--- Drop all listeners from listeners list [`predefined`].
function GuiObject:removeAllListeners()
	self.listenersTable = {}
end

--- Get all listeners [`predefined`].
-- @treturn listenersTable
function GuiObject:getAllListeners()
	return self.listenersTable
end

return GuiObject