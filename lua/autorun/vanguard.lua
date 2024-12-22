--[[-------------------------------------------------------------------------
    Vanguard
    A utility library for Garry's Mod that provides a variety of useful functions. It is designed to be lightweight and easy to use, and is intended to be used as a base for other projects.
---------------------------------------------------------------------------]]

local http = http
local Color = Color
local AddCSLuaFile = AddCSLuaFile
local include = include
local hook = hook

vanguard = vanguard or {}

vanguard.info = vanguard.info or {}
vanguard.info.version = "0.0.1"
vanguard.info.versionLink = "https://raw.githubusercontent.com/Minerva-Servers/vanguard/refs/heads/main/VERSION.txt"
vanguard.info.color = Color(255, 100, 0)

AddCSLuaFile("vanguard/sh_util.lua")
include("vanguard/sh_util.lua")

vanguard.util:Message("Vanguard " .. vanguard.info.version .. " is being initialized...")

vanguard.util:IncludeDir("vanguard/core")
vanguard.util:IncludeDir("vanguard/hooks")
vanguard.modules:LoadFolder("vanguard/modules")

hook.Add("Initialize", "Vanguard.Initialize", function()
    if ( SERVER and vanguard.info.versionLink != "" ) then
        http.Fetch(vanguard.info.versionLink, function(body, len, headers, code)
            if ( body != vanguard.info.version ) then
                vanguard.util:Message(Color(255, 0, 0), "Your Vanguard library is out of date! Please update it.")
            end

            vanguard.util:Message(Color(0, 255, 0), "Vanguard " .. vanguard.info.version .. " has been successfully initialized.")
        end)
    else
        vanguard.util:Message(Color(0, 255, 0), "Vanguard " .. vanguard.info.version .. " has been successfully initialized.")
    end
end)