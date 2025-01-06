local Color = Color
local string = string
local http = http
local pairs = pairs
local ipairs = ipairs
local file = file

vanguard.modules = vanguard.modules or {}
vanguard.modules.stored = vanguard.modules.stored or {}

function vanguard.modules:Register(info)
    if ( !info ) then
        if ( SERVER ) then
            vanguard.util:Message(Color(255, 0, 0), "Attempted to register an invalid module!")
        end

        return
    end

    if ( !info.Name ) then
        info.Name = "Unknown"
    end

    if ( !info.Description ) then
        info.Description = "No description provided."
    end

    if ( !info.Author ) then
        info.Author = "Unknown"
    end

    if ( !info.Version ) then
        info.Version = "0.0.0"
    end

    if ( !info.VersionLink ) then
        info.VersionLink = ""
    end

    -- Generate a unique ID for the module
    local uniqueID = string.lower(string.gsub(info.Name, "%s", "_"))
    info.uniqueID = uniqueID

    -- Store the module
    self.stored[uniqueID] = info

    -- Let's see if our module is up to date
    if ( SERVER and info.VersionLink != "" ) then
        http.Fetch(info.VersionLink, function(body, len, headers, code)
            if ( body != info.Version ) then
                vanguard.util:Message(Color(255, 0, 0), "Your " .. info.Name .. " module is out of date! Please update it.")
            end
        end)
    end

    if ( SERVER ) then
        vanguard.util:Message(info.Name .. " module has been registered.")
    end

    return uniqueID
end

function vanguard.modules:Get(identifier)
    if ( !identifier ) then
        vanguard.util:Message(Color(255, 0, 0), "Attempted to get an invalid module!")
        return
    end

    if ( self.stored[identifier] ) then
        return self.stored[identifier]
    end

    for k, v in pairs(self.stored) do
        if ( vanguard.util:FindString(v.Name, identifier) or vanguard.util:FindString(v.UniqueID, identifier) ) then
            return v
        end
    end
end

function vanguard.modules:LoadFolder(path)
    if ( !path ) then
        if ( SERVER ) then
            vanguard.util:Message(Color(255, 0, 0), "Attempted to load modules from an invalid folder!")
        end

        return
    end

    if ( SERVER ) then
        vanguard.util:Message("Loading modules from folder: " .. path)
    end

    -- Load modules from the main folder
    for k, v in ipairs(file.Find(path .. "/*.lua", "LUA")) do
        vanguard.util:Include(path .. "/" .. v)
    end

    -- Load modules from subfolders
    local files, folders = file.Find(path .. "/*", "LUA")
    for k, v in ipairs(folders) do
        local modulePath = path .. "/" .. v .. "/sh_module.lua"

        if ( file.Exists(modulePath, "LUA") ) then
            vanguard.util:Include(modulePath)
        else
            if ( SERVER ) then
                vanguard.util:Message(Color(255, 0, 0), "Failed to load module from folder: " .. v)
            end
        end
    end

    if ( SERVER ) then
        vanguard.util:Message("Loaded modules from folder: " .. path)
    end

    return true
end