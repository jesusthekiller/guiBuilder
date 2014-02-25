-----------------------------------------------------------------------
-- Script loading all classes for Gui API.
-- 
-- @usage dofile("bootstrap.lua")
-- @release 0.01 (indev)
-- @author jesusthekiller
-- @script bootstrap
-----------------------------------------------------------------------

--[[
class = dofile("middleclass.lua")

Utils = dofile("utils.lua")

Connection = dofile("display/connection.lua")
Display = dofile("display/display.lua")

GuiObject = dofile("guiObject/guiObject.lua")
Listener = dofile("guiObject/listener.lua")

Gui = dofile("gui.lua")
]]

local toLoad = {
	{"/.guiBuilder/middleclass.lua", "class"},

	{"/.guiBuilder/utils.lua", "Utils"},
	
	{"/.guiBuilder/display/connection.lua", "Connection"},
	{"/.guiBuilder/display/display.lua", "Display"},

	{'/.guiBuilder/guiObject/guiObject.lua', "GuiObject"},
	{'/.guiBuilder/guiObject/event.lua', "Event"},
	{'/.guiBuilder/guiObject/listener.lua', "Listener"},

	{"/.guiBuilder/gui.lua", "Gui"},
}

for _,v in ipairs(toLoad) do
	loadstring(v[2].." = dofile(\""..v[1].."\")")()
end