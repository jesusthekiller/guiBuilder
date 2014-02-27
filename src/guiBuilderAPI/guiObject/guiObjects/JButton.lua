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
	"shadow", colors.gray,
	"shadowPressed", colors.black
)

--- JButton constructor.  
-- 
-- **Colors in** `color`**:**   
-- 	* text  
-- 	* background   
-- 	* shadow  
-- 	* textPressed (Color when button is pressed  
-- 	* backgroundPressed (Color when button is pressed)  
-- 	* shadowPressed (Color when button is pressed)  
-- **Note:** *if color will be left unspecified, default from* @{JButton._DEFAULT_COLOR} *will be used.* 
-- @tparam Position position
-- @string text Text to be displayed on button
-- @tparam Color color
-- @number timeout Click animation length (in seconds). Optional, default = @{JButton._DEFAULT_TIMEOUT}.
-- @bool shadow Draw shadow? Optional, default = @{JButton._DEFAULT_SHADOW}
-- @usage myButton = JButton:new(position, color)
-- @function JButton.new
function JButton:initialize( position, text, color, timeout, shadow )
	-- Run superclass'es constructor
	GuiObject.initialize(self, position)

	-- Save colors
	assert(Utils.isSubclass(Color, color) or color == nil, "Argument \"color\" is not an instance of Color or nil")

	-- If nil, use default
	if (color == nil) then
		color = JButton._DEFAULT_COLOR
	end

	-- Check for missing colors
	for k,v in pairs(JButton._DEFAULT_COLOR.color) do
		if (color[k] == nil) then
			color[k] = v
		end
	end
	self.color = color

	-- Timeout
	if (type(timeout) ~= "number") then
		self.timeout = JButton._DEFAULT_TIMEOUT
	else
		self.timeout = timeout
	end

	-- Some private stuff
	self._isPressed = false
	self._shadowPos = Position:new(self.position.x+1, self.position.y+1, self.position.width, self.position.height)
end

--- As specified by @{GuiObject}.
function JButton:draw()
	self.display:setBackgroundColor(colors.red)
	self.display:clear()

	local bkg, txt, shadow

	if (self._isPressed) then
		bkg, txt, shadow = self.color.color.backgroundPressed, self.color.color.textPressed, self.color.color.shadowPressed
	else
		bkg, txt, shadow = self.color.color.background, self.color.color.text, self.color.color.shadow
	end

	-- Draw shadow
	Utils.drawRectangle(self._shadowPos, shadow, self.display)

	-- Draw button
	Utils.drawRectangle(self.position, bkg, self.display)

	-- Draw text
	Utils.drawText(self.position, self.text, txt, self.display)
end

--- As specified by @{GuiObject}.
function JButton:event( event )
	assert(Utils.isInstance(Event, event), "Non-event object was passed to JButton:draw!")

	-- Handle button click before calling user's Listeners
	if (event.type == Event.type.display_touch) then
		if (event:isWithin(self.position)) then
			if (not self._isPressed) then
				self._isPressed = true
				self._pressedTimerID = os.startTimer(self.timeout)
				self:draw()
			end
		end

		-- Spawn clicked
		if (event:isWithin(self.position)) then
			self:event(Event:new(Event.type.clicked))
		end
	end

	-- Alarm for unpress
	if (self._isPressed and event.type == Event.type.alarm and event.param[1] == self._pressedTimerID) then
		self._pressedTimerID = nil
		self._isPressed = false
		self:draw()
	end

	-- Pass event to listeners
	local parallelRun = {}

	for k,v in pairs(self.listenersTable) do
		if (v.type == event.type) then
			table.insert(parallelRun, v.callback)
		end
	end

	-- Run listeners, if any
	if (#parallelRun > 0) then
		parallel.waitForAll(unpack(parallelRun))
	end
end

return JButton