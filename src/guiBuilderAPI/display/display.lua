-----------------------------------------------------------------------
-- Display class unifying all types of displays.
-- Many of theese functions are simple wrappers around [Term API](bit.ly/1gu3zoz).
-- Wrappers (not only functions described as 'wrapper' but also those without description)
-- are passing all arguments to native function via `( ... )`, everything is returned as well.  
--  
-- **Depends on:** 
-- > @{Middleclass}  
-- > @{Connection}  
-- @usage Display = dofile("display.lua")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @classmod Display
-----------------------------------------------------------------------

local Display = class("Display")

--- Display class constructor
-- @tparam Connection connection connection object between display and API
-- @usage local myDisplay = Display.new( connection )
-- @function Display.new
function Display:initialize( connection )
	assert(self ~= nil, "Call it using ':', i.e Display:new()")

	if (not Utils.isInstance(Connection, connection)) then
		error("Argument #1 is not an instance of class Connection!", 1)
	end

	self.native = connection.native
	self.type = connection.type

	--- Display width
	-- @tfield int x

	--- Display height
	-- @tfield int y
	self.x, self.y = self.native.getSize()
end

---
-- @string s text to write
function Display:rawWrite( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.write( ... )
end

--- Works like `write()`.   
-- Not a wrapper  
-- Borrowed from `bios.lua`  
-- **author: Dan200**
-- @usage myDisplay:write( "text", "to", "write" )
-- @string sText String to write
function Display:write( sText )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	local w,h = self.native.getSize()
	local x,y = self.native.getCursorPos()

	local nLinesPrinted = 0
	local function newLine()
		if y + 1 <= h then
			self.native.setCursorPos(1, y + 1)
		else
			self.native.setCursorPos(1, h)
			self.native.scroll(1)
		end
		x, y = self.native.getCursorPos()
		nLinesPrinted = nLinesPrinted + 1
	end

	-- Print the line with proper word wrapping
	while string.len(sText) > 0 do
		local whitespace = string.match( sText, "^[ \t]+" )
		if whitespace then
			-- Print whitespace
			self.native.write( whitespace )
			x,y = self.native.getCursorPos()
			sText = string.sub( sText, string.len(whitespace) + 1 )
		end

		local newline = string.match( sText, "^\n" )
		if newline then
			-- Print newlines
			newLine()
			sText = string.sub( sText, 2 )
		end

		local text = string.match( sText, "^[^ \t\n]+" )
		if text then
			sText = string.sub( sText, string.len(text) + 1 )
			if string.len(text) > w then
				-- Print a multiline word
				while string.len( text ) > 0 do
					if x > w then
						newLine()
					end
					self.native.write( text )
					text = string.sub( text, (w-x) + 2 )
					x,y = self.native.getCursorPos()
				end
			else
				-- Print a word normally
				if x + string.len(text) - 1 > w then
					newLine()
				end
				self.native.write( text )
				x,y = self.native.getCursorPos()
			end
		end
	end

	return nLinesPrinted
end

--- Works like `print()`.   
-- Not a wrapper  
-- Borrowed from `bios.lua`  
-- **author: Dan200**
-- @usage myDisplay:print( "text", "to", "print" )
-- @param ... strings to print
function Display:print( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	local nLinesPrinted = 0
	for n,v in ipairs( { ... } ) do
		nLinesPrinted = nLinesPrinted + self:write( tostring( v ) )
	end
	nLinesPrinted = nLinesPrinted + self:write( "\n" )
	return nLinesPrinted
end

--- 
function Display:clear( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.clear( ... )
end

--- 
function Display:clearLine( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.clearLine( ... )
end

--- 
-- @treturn int x
-- @treturn int y
function Display:getCursorPos( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.getCursorPos( ... )
end

--- 
-- @int x
-- @int y
function Display:setCursorPos( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.setCursorPos( ... )
end

--- 
-- @bool blink
function Display:setCursorBlink( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.setCursorBlink( ... )
end

--- 
-- @treturn bool isColor
function Display:isColor( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.isColor( ... )
end

--- Wrapper to @{Display:isColor}
-- @treturn bool isColour
function Display:isColour( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self:isColor( ... )
end

--- 
-- @treturn number x
-- @treturn number y
function Display:getSize( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.getSize( ... )
end

---
-- @int lines
function Display:scroll( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.scroll( ... )
end

--[[
---
-- @param target Object returned form peripheral.wrap
function Display:redirect( ... )
	return self.native.redirect( ... )
end
]]

---
-- @int color
function Display:setTextColor( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.setTextColor( ... )
end

--- Wrapper to @{Display:setTextColor}
-- @see Display:setTextColor
function Display:setTextColour( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self:setTextColor( ... )
end

---
-- @int color
function Display:setBackgroundColor( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self.native.setBackgroundColor( ... )
end

--- Wrapper to @{Display:setBackgroundColor}
-- @see Display:setBackgroundColor
function Display:setBackgroundColour( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	return self:setBackgroundColor( ... )
end

--- Not really a wrapper.  
-- Updates @{Display.x} and @{Display.y} on success
-- @int scale
-- @return false if terminal
-- @return result of `Display.native.setTextScale( ... )` if monitor
function Display:setTextScale( ... )
	assert(self, "Call it using ':', i.e myDisplay:doSomething()")
	if(self.type ~= Connection.connectionType.terminal) then
		self.x, self.y = self:getSize() -- Update size
		return Display.native.setTextScale( ... )
	else
		return false
	end
end

return Display