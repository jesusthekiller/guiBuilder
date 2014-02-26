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
	{"/guiBuilderAPI/middleclass.lua", "class"},

	{"/guiBuilderAPI/utils.lua", "Utils"},
	
	{"/guiBuilderAPI/display/connection.lua", "Connection"},
	{"/guiBuilderAPI/display/display.lua", "Display"},

	{'/guiBuilderAPI/guiObject/guiObject.lua', "GuiObject"},
	{'/guiBuilderAPI/guiObject/event.lua', "Event"},
	{'/guiBuilderAPI/guiObject/listener.lua', "Listener"},

	{"/guiBuilderAPI/gui.lua", "Gui"},
}

for _,v in ipairs(toLoad) do
	loadstring(v[2].." = dofile(\""..v[1].."\")")()
end