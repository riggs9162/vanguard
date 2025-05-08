local concommand = concommand
local IsValid = IsValid
local http = http
local Color = Color

concommand.Add("vanguard_reload", function(client, cmd, args)
    if ( !IsValid(client) or client:IsSuperAdmin() ) then
        vanguard.util:Message("Reloading Vanguard...")

        vanguard.util:IncludeDir("vanguard/core")
        vanguard.modules:LoadFolder("vanguard/modules")

        http.Fetch(vanguard.info.versionLink, function(body, len, headers, code)
            if ( body != vanguard.info.version ) then
                vanguard.util:Message(Color(255, 0, 0), "Your Vanguard library is out of date! Please update it.")
            end

            vanguard.util:Message(Color(0, 255, 0), "Vanguard has been successfully reloaded.")
        end)
    end
end)