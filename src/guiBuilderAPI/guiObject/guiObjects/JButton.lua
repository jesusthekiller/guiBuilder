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

--- [`static`] Default timeout.
-- @tfield number _DEFAULT_TIMEOUT 0.2 second
JButton.static._DEFAULT_TIMEOUT = 0.2

--- [`static`] Default shadow setting.
-- @tfield bool _DEFAULT_SHADOW true
JButton.static._DEFAULT_SHADOW = true

--- [`static`] Default color scheme.  
-- **Values:**  
-- 	text: black  
-- 	background: light gray  
-- 	shadow: gray  
-- 	textPressed: white  
-- 	backgroundPressed: gray  
-- @tfield Color _DEFAULT_COLOR
JButton.static._DEFAULT_COLOR = Color:new(
	"text", colors.black,
	"background", colors.lightGray,
	"textPressed", colors.white,
	"backgroundPressed", colors.gray,
	"shadow", colors.gray
)

--- JButton constructor.  
-- 
-- **Colors in** `color`**:**   
-- 	* text  
-- 	* background   
-- 	* shadow  
-- 	* textPressed (Color when button is pressed  
-- 	* backgroundPressed (Color when button is pressed)  
-- **Note:** *if color will be left unspecified, default from* @{JButton._DEFAULT_COLOR} *will be used.* 
-- @tparam Position position
-- @tparam Color color
-- @number timeout Click animation length (in seconds). Optional, default = @{JButton._DEFAULT_TIMEOUT}.
-- @bool shadow Draw shadow? Optional, default = @{JButton._DEFAULT_SHADOW}
-- @usage myButton = JButton:new(position, color)
-- @function JButton.new
function JButton:initialize( position, color, timeout, shadow )
	-- Run superclasse's constructor
	GuiObject.initialize(self, position)

	-- Save colors
	assert(Utils.isSubclass(Color, color), "Argument \"color\" is not an instance of Color")
	self.color = color

	-- Timeout
	if (type(timeout) ~= "number") then
		self.timeout = self._DEFAULT_TIMEOUT
	else
		self.timeout = timeout
	end

	-- Some private stuff
	self._isPressed = false
end

--- As specified by @{GuiObject}.
function JButton:draw( display )
	

	-- Draw button itself
	if (self._isPressed) then
		Utils.drawRectangle(self.position, self.color.color.backgroundPressed, display)
	else

	end
end

return JButton