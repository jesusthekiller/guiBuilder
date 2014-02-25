-----------------------------------------------------------------------
-- Main class for Gui API.
--  
-- **Depends on:**  
-- > @{Middleclass}  
-- > @{Connection}  
-- > @{Display}  
-- @usage Gui = dofile("gui.lua")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @classmod Gui
-----------------------------------------------------------------------

local Gui = class("Gui")

--- Gui API version [`static`]
-- @usage print(Gui._VERSION)
Gui.static._VERSION = 0.01

--- Gui class constructor
-- @tparam Display display Display object that gui will be rendered onto
-- @usage local myGui = Gui.new( display )
-- @function Gui.new
function Gui:initialize( display )
	-- body
end

function Gui:registerScreen( screen )

end

function Gui:registerWindow( window )

end

function Gui:start()

end

function Gui:stop()

end

return Gui