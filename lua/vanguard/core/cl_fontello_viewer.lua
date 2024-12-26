local alphabet = {
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
}

local numbers = {
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
}

local symbols = {
    "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "+", "=", "[", "]", "{", "}", ";", ":", "'", "\"", ",", "<", ".", ">", "/", "?", "\\", "|", "`", "~"
}

local PANEL = {}

function PANEL:Init()
    vanguard.fontelloViewer = self

    self:SetSize(ScrW() / 2.5, ScrH() / 1.5)
    self:Center()
    self:MakePopup()
    self:SetTitle("Fontello Viewer")
    self:SetDraggable(true)
    self:DockPadding(16, 40, 16, 16)

    self:SetAlpha(0)
    self:AlphaTo(255, 0.5, 0)

    self.tabs = self:Add("DPropertySheet")
    self.tabs:SetPos(0, 24)
    self.tabs:SetSize(self:GetWide(), self:GetTall() - 64)
    self.tabs.Paint = nil

    self:CreateAlphabetTab()
    self:CreateNumbersTab()
    self:CreateSymbolsTab()
end

function PANEL:CreateAlphabetTab()
    local tab = self.tabs:AddSheet("Alphabet", vgui.Create("DPanel", self.tabs), "icon16/font.png")
    local panel = tab.Panel

    panel:Dock(FILL)
    panel.Paint = nil

    local scroller = panel:Add("DScrollPanel")
    scroller:Dock(FILL)
    scroller:GetVBar():SetWide(0)

    local label = scroller:Add("DLabel")
    label:Dock(TOP)
    label:DockMargin(0, 0, 0, 16)
    label:SetText("Capital Letters")
    label:SetFont("Vanguard.SubTitle")
    label:SetContentAlignment(5)
    label:SizeToContents()
    label:SetTextColor(color_white)
    label:SetExpensiveShadow(1, Color(0, 0, 0, 255))

    local layout = scroller:Add("DIconLayout")
    layout:Dock(TOP)
    layout:SetSpaceX(8)
    layout:SetSpaceY(8)
    layout:SetBorder(8)

    local size = self:GetWide() / 8 - 9
    for _, char in ipairs(alphabet) do
        local box = layout:Add("DPanel")
        box:SetSize(size, size)
        box.Paint = function(self, width, height)
            draw.RoundedBox(32, 0, 0, width, height, Color(40, 40, 40, 255))
            draw.SimpleText(char, "Vanguard.Fontello", width / 2, height / 2 + 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            draw.SimpleText(char, "Vanguard.FontelloViewer", width / 2, height / 2 - 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        end
    end

    local label = scroller:Add("DLabel")
    label:Dock(TOP)
    label:DockMargin(0, 8, 0, 16)
    label:SetText("Lowercase Letters")
    label:SetFont("Vanguard.SubTitle")
    label:SetContentAlignment(5)
    label:SizeToContents()
    label:SetTextColor(color_white)
    label:SetExpensiveShadow(1, Color(0, 0, 0, 255))

    local layout = scroller:Add("DIconLayout")
    layout:Dock(TOP)
    layout:SetSpaceX(8)
    layout:SetSpaceY(8)
    layout:SetBorder(8)

    for _, char in ipairs(alphabet) do
        local box = layout:Add("DPanel")
        box:SetSize(size, size)
        box.Paint = function(self, width, height)
            draw.RoundedBox(32, 0, 0, width, height, Color(40, 40, 40, 255))
            draw.SimpleText(string.lower(char), "Vanguard.Fontello", width / 2, height / 2 + 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            draw.SimpleText(string.lower(char), "Vanguard.FontelloViewer", width / 2, height / 2 - 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        end
    end
end

function PANEL:CreateNumbersTab()
    local tab = self.tabs:AddSheet("Numbers", vgui.Create("DPanel", self.tabs), "icon16/font.png")
    local panel = tab.Panel

    panel:Dock(FILL)
    panel.Paint = nil

    local scroller = panel:Add("DScrollPanel")
    scroller:Dock(FILL)
    scroller:GetVBar():SetWide(0)

    local label = scroller:Add("DLabel")
    label:Dock(TOP)
    label:DockMargin(0, 0, 0, 16)
    label:SetText("Numbers")
    label:SetFont("Vanguard.SubTitle")
    label:SetContentAlignment(5)
    label:SizeToContents()
    label:SetTextColor(color_white)
    label:SetExpensiveShadow(1, Color(0, 0, 0, 255))

    local layout = scroller:Add("DIconLayout")
    layout:Dock(TOP)
    layout:SetSpaceX(8)
    layout:SetSpaceY(8)
    layout:SetBorder(8)

    local size = self:GetWide() / 8 - 9
    for _, char in ipairs(numbers) do
        local box = layout:Add("DPanel")
        box:SetSize(size, size)
        box.Paint = function(self, width, height)
            draw.RoundedBox(32, 0, 0, width, height, Color(40, 40, 40, 255))
            draw.SimpleText(char, "Vanguard.Fontello", width / 2, height / 2 + 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            draw.SimpleText(char, "Vanguard.FontelloViewer", width / 2, height / 2 - 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        end
    end
end

function PANEL:CreateSymbolsTab()
    local tab = self.tabs:AddSheet("Symbols", vgui.Create("DPanel", self.tabs), "icon16/font.png")
    local panel = tab.Panel

    panel:Dock(FILL)
    panel.Paint = nil

    local scroller = panel:Add("DScrollPanel")
    scroller:Dock(FILL)
    scroller:GetVBar():SetWide(0)

    local label = scroller:Add("DLabel")
    label:Dock(TOP)
    label:DockMargin(0, 0, 0, 16)
    label:SetText("Symbols")
    label:SetFont("Vanguard.SubTitle")
    label:SetContentAlignment(5)
    label:SizeToContents()
    label:SetTextColor(color_white)
    label:SetExpensiveShadow(1, Color(0, 0, 0, 255))

    local layout = scroller:Add("DIconLayout")
    layout:Dock(TOP)
    layout:SetSpaceX(8)
    layout:SetSpaceY(8)
    layout:SetBorder(8)

    local size = self:GetWide() / 8 - 9
    for _, char in ipairs(symbols) do
        local box = layout:Add("DPanel")
        box:SetSize(size, size)
        box.Paint = function(self, width, height)
            draw.RoundedBox(32, 0, 0, width, height, Color(40, 40, 40, 255))
            draw.SimpleText(char, "Vanguard.Fontello", width / 2, height / 2 + 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            draw.SimpleText(char, "Vanguard.FontelloViewer", width / 2, height / 2 - 4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        end
    end
end

function PANEL:Paint(width, height)
    draw.RoundedBox(16, 0, 0, width, height, Color(20, 20, 20, 255))
    draw.RoundedBox(8, 0, 0, width, 24, Color(40, 40, 40, 255))
end

function PANEL:OnClose()
    self:Remove()
end

vgui.Register("Vanguard.FontelloViewer", PANEL, "DFrame")

concommand.Add("vanguard_fontello_viewer", function()
    vgui.Create("Vanguard.FontelloViewer")
end)

if ( IsValid(vanguard.fontelloViewer) ) then
    vanguard.fontelloViewer:Remove()

    vgui.Create("Vanguard.FontelloViewer")
end