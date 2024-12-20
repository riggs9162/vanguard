local sound = sound
local pairs = pairs

vanguard.sounds = vanguard.sounds or {}
vanguard.sounds.stored = vanguard.sounds.stored or {}

function vanguard.sounds:Register(name, path, pitch, volume, level)
    if ( !name or !path ) then return end

    local data = {
        path = path,
        pitch = pitch or 100,
        volume = volume or 1,
        level = level or 75
    }

    sound.Add({
        name = name,
        channel = CHAN_STATIC,
        volume = data.volume,
        level = data.level,
        pitch = data.pitch,
        sound = data.path
    })

    self.stored[name] = data

    if ( SERVER ) then
        vanguard.util:Message("Registered sound \"" .. name .. "\".")
    end

    return data
end

function vanguard.sounds:Find(identifier)
    if ( !identifier ) then return end

    for k, v in pairs(self.stored) do
        if ( vanguard.util:FindString(k, identifier) ) then
            return v
        end
    end
end