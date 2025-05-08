local IsValid = IsValid
local chat = chat
local Color = Color
local net = net
local ipairs = ipairs
local util = util
local LocalPlayer = LocalPlayer

function vanguard.util:Notify(client, message)
    if ( !IsValid(client) or client:IsBot() ) then return end

    if ( CLIENT ) then
        chat.AddText(vanguard.info.color, "[Vanguard] ", color_white, message)
    else
        net.Start("Vanguard.Notify")
            net.WriteString(message)
        net.Send(client)
    end
end

function vanguard.util:NotifyAll(message)
    for _, v in ipairs(self:GetPlayers()) do
        self:Notify(v, message)
    end
end

function vanguard.util:NotifyAdmins(message)
    for _, v in ipairs(self:GetPlayers()) do
        if ( v:IsAdmin() ) then
            self:Notify(v, message)
        end
    end
end

if ( SERVER ) then
    util.AddNetworkString("Vanguard.Notify")
else
    net.Receive("Vanguard.Notify", function()
        local message = net.ReadString()

        vanguard.util:Notify(LocalPlayer(), message)
    end)
end