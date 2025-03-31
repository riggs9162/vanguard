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
    args[#args + 1] = "\n"

    MsgC(vanguard.info.color, "[VANGUARD] ", color_white, unpack(args))
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
    if ( !str or !find ) then
        print("Attempted to find a string with no value", str, find)
        return false
    end

    str = string.lower(str)
    find = string.lower(find)

    return string.find(str, find) != nil
end

function vanguard.util:FindText(txt, find)
    if ( !txt or !find ) then return end

    local words = string.Explode(" ", txt)
    for k, v in ipairs(words) do
        if ( self:FindString(v, find) ) then
            return true
        end
    end

    return false
end

function vanguard.util:FindPlayer(identifier)
    if ( !identifier ) then return nil end

    local identifierType = type(identifier)

    if ( self:FindString(identifierType, "player" ) ) then
        return identifier
    end

    if ( self:FindString(identifierType, "number") ) then
        return Player(identifier)
    end

    if ( self:FindString(identifierType, "string") ) then
        for k, v in ipairs(player.GetAll()) do
            if ( self:FindString(v:Name(), identifier) or self:FindString(v:SteamID(), identifier) or self:FindString(v:SteamID64(), identifier) ) then
                return v
            end
        end
    end

    if ( self:FindString(identifierType, "table") ) then
        for k, v in ipairs(identifier) do
            return self:FindString(v)
        end
    end

    return nil
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