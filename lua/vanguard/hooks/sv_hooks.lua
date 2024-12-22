hook.Add("CheckPassword", "Vanguard:CheckPassword", function(steamid64, ip, svpass, clpass, name)
    vanguard.util:Message("Checking password for " .. name .. " (" .. steamid64 .. ").")

    if ( svpass != clpass ) then
        vanguard.util:Message("Passwords do not match for " .. name .. " (" .. steamid64 .. "), server password: " .. svpass .. ", client password: " .. clpass .. ".")
        return
    end

    vanguard.util:Message("Passwords match for " .. name .. " (" .. steamid64 .. ").")
end)