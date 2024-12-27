local player = player
local table = table
local MsgC = MsgC
local Color = Color
local unpack = unpack
local Msg = Msg
local include = include
local AddCSLuaFile = AddCSLuaFile
local ipairs = ipairs
local file = file
local tobool = tobool
local string = string
local type = type
local Player = Player

vanguard.util = vanguard.util or {}

function vanguard.util:GetPlayers()
    local players = {}

    for _, v in player.Iterator() do
        if ( v:IsBot() ) then continue end

        table.insert(players, v)
    end

    return players
end

function vanguard.util:Message(...)
    local args = { ... }

    MsgC(vanguard.info.color, "[VANGUARD] ", color_white, unpack(args))
    Msg("\n")
end

function vanguard.util:Include(fileName, realm)
    if ( !fileName ) then
        self:Message("Attempted to include a file with no name.")
        return
    end

    if ( SERVER ) then
        self:Message("Including file \"" .. fileName .. "\".")
    end

    if ( ( realm == "server" or fileName:find("sv_") ) and SERVER ) then
        return include(fileName)
    elseif ( realm == "shared" or fileName:find("shared.lua") or fileName:find("sh_") ) then
        if ( SERVER ) then
            AddCSLuaFile(fileName)
        end

        return include(fileName)
    elseif ( realm == "client" or fileName:find("cl_") ) then
        if ( SERVER ) then
            AddCSLuaFile(fileName)
        else
            return include(fileName)
        end
    end
end

function vanguard.util:IncludeDir(directory)
    if ( SERVER ) then
        self:Message("Including directory \"" .. directory .. "\".")
    end

    for _, v in ipairs(file.Find(directory .. "/*.lua", "LUA")) do
        self:Include(directory .. "/" .. v)
    end
end

function vanguard.util:FindString(str, find)
    if ( !str or !find ) then return false end

    return tobool(string.find(string.lower(str), string.lower(find)))
end

function vanguard.util:FindText(txt, find)
    if ( !txt or !find ) then return end

    local words = string.Explode(" ", txt)
    local find = self.FindString
    for k, v in ipairs(words) do
        if ( find(v, find) ) then
            return true
        end
    end

    return false
end

function vanguard.util:FindPlayer(identifier)
    if ( !identifier ) then return end

    if ( type(identifier) == "Player" ) then
        return identifier
    end

    if ( type(identifier) == "string" ) then
        local find = self.FindString
        for k, v in player.Iterator() do
            if ( find(v:Name(), identifier) or find(v:SteamID(), identifier) or find(v:SteamID64(), identifier) ) then
                return v
            end
        end
    end

    if ( type(identifier) == "number" ) then
        return Player(identifier)
    end

    if ( type(identifier) == "table" ) then
        local find = self.FindPlayer
        for k, v in ipairs(identifier) do
            return find(v)
        end
    end
end

function vanguard.util:WrapText(text, font, maxWidth)
    surface.SetFont(font)

    local words = string.Explode(" ", text)
    local lines = {}
    local line = ""
    for k, v in ipairs(words) do
        local w = surface.GetTextSize(v)
        local lw = surface.GetTextSize(line)

        if ( lw + w > maxWidth ) then
            table.insert(lines, line)
            line = ""
        end

        line = line .. v .. " "
    end

    table.insert(lines, line)

    return lines
end

function vanguard.util:UpperCaseFirst(str)
    return str:gsub("^%l", string.upper)
end