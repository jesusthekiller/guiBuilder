-----------------------------------------------------------------------
-- Button Gui Object.
-- Subclass of @{GuiObject}
--  
-- **Depends on:**  
-- > @{Middleclass}  
-- > @{Event}  
-- > @{Listener}  
-- > @{GuiObject}  
-- > @{Position}
-- > @{Color}
-- @usage JButton = dofile("guiObjects/JButton.lua")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @classmod JButton
-----------------------------------------------------------------------
local JButton = GuiObject:subclass("JButton")

--- JButton constructor.
-- @tparam Position position
-- @tparam Color colors
-- @usage myButton = JButton:new(position, colors)
-- @function JButton.new
function JButton:initialize( position, colors )

end

return JButton