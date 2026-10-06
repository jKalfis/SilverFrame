-- Texturas originais do cliente Vanilla 1.12.1
local textures = {
    ["rare"]   = "Interface\\TargetingFrame\\UI-TargetingFrame-Rare",
    ["elite"]  = "Interface\\TargetingFrame\\UI-TargetingFrame-Elite",
    ["normal"] = "Interface\\TargetingFrame\\UI-PlayerFrame",
}

local function ApplySilverFrame()
    if not PlayerFrameTexture then return end

    local currentType = SilverFrameDB or "rare"
    local tex = textures[currentType] or textures["rare"]

    -- Repõe a posição original da textura padrão da Blizzard
    PlayerFrameTexture:ClearAllPoints()
    PlayerFrameTexture:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 6, -6)
    PlayerFrameTexture:SetTexture(tex)

    if currentType == "normal" then
        -- Textura normal da frame do jogador
        PlayerFrameTexture:SetTexCoord(0, 1, 0, 1)
    else
        -- Inverte horizontalmente a textura do Target para encaixar no Player Frame
        PlayerFrameTexture:SetTexCoord(1, 0, 0, 1)
    end
end

-- Hook clássico compatível com Vanilla 1.12.1 (substitui o hooksecurefunc)
if PlayerFrame_Update then
    local Old_PlayerFrame_Update = PlayerFrame_Update
    PlayerFrame_Update = function()
        Old_PlayerFrame_Update()
        ApplySilverFrame()
    end
end

-- Registo de eventos do jogo
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function()
    if event == "ADDON_LOADED" and arg1 == "SilverFrame" then
        if not SilverFrameDB then 
            SilverFrameDB = "rare" 
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        ApplySilverFrame()
    end
end)

-- Slash Commands (/sf e /silverframe)
SLASH_SILVERFRAME1 = "/silverframe"
SLASH_SILVERFRAME2 = "/sf"

SlashCmdList["SILVERFRAME"] = function(msg)
    local cmd = string.lower(msg or "")

    if cmd == "1" or cmd == "rare" or cmd == "silver" then
        SilverFrameDB = "rare"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame set to: |cff00ffffSilver Dragon (Rare)|r")
    elseif cmd == "2" or cmd == "elite" or cmd == "gold" then
        SilverFrameDB = "elite"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame set to: |cffffd700Gold Dragon (Elite)|r")
    elseif cmd == "normal" or cmd == "reset" or cmd == "0" then
        SilverFrameDB = "normal"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame restored to: |cffffffffNormal|r")
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame Commands]|r:")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf 1|r - Silver Dragon (Rare)")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf 2|r - Gold Dragon (Elite)")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf normal|r - Default Frame")
        return
    end

    ApplySilverFrame()
end
