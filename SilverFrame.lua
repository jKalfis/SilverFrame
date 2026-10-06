-- Texturas originais do cliente Vanilla 1.12
local textures = {
    ["rare"]   = "Interface\\TargetingFrame\\UI-TargetingFrame-Rare",
    ["elite"]  = "Interface\\TargetingFrame\\UI-TargetingFrame-Elite",
    ["normal"] = "Interface\\TargetingFrame\\UI-PlayerFrame",
}

local function ApplySilverFrame()
    if not PlayerFrameTexture then return end

    local currentType = SilverFrameDB or "rare"
    local tex = textures[currentType] or textures["rare"]

    -- Restaura a posição exata e padrão da textura na UI da Blizzard (6, -6)
    PlayerFrameTexture:ClearAllPoints()
    PlayerFrameTexture:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 6, -6)
    PlayerFrameTexture:SetTexture(tex)

    if currentType == "normal" then
        -- Textura normal do jogador (sem inverter)
        PlayerFrameTexture:SetTexCoord(0, 1, 0, 1)
    else
        -- Inverte a textura do Target para alinhar no Player Frame
        PlayerFrameTexture:SetTexCoord(1, 0, 0, 1)
    end
end

-- Eventos de carregamento
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function()
    if event == "ADDON_LOADED" and arg1 == "SilverFrame" then
        if not SilverFrameDB then 
            SilverFrameDB = "rare" 
        end
    end
    ApplySilverFrame()
end)

-- Previne que o jogo restaure a textura original em atualizações de frame
if PlayerFrame_Update then
    hooksecurefunc("PlayerFrame_Update", ApplySilverFrame)
end

-- Slash Commands (/sf e /silverframe)
SLASH_SILVERFRAME1 = "/silverframe"
SLASH_SILVERFRAME2 = "/sf"

SlashCmdList["SILVERFRAME"] = function(msg)
    local cmd = string.lower(msg or "")

    if cmd == "1" or cmd == "rare" or cmd == "silver" then
        SilverFrameDB = "rare"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame: |cff00ffffSilver Dragon (Rare)|r")
    elseif cmd == "2" or cmd == "elite" or cmd == "gold" then
        SilverFrameDB = "elite"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame: |cffffd700Gold Dragon (Elite)|r")
    elseif cmd == "normal" or cmd == "reset" or cmd == "0" then
        SilverFrameDB = "normal"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame: |cffffffffNormal|r")
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame Comandos]|r:")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf 1|r - Dragao Prateado (Rare)")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf 2|r - Dragao Dourado (Elite)")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf normal|r - Restaurar padrao")
        return
    end

    ApplySilverFrame()
end
