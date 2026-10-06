-- Texturas válidas para o cliente Vanilla 1.12
local textures = {
    ["rare"]   = "Interface\\TargetingFrame\\UI-TargetingFrame-Rare",
    ["elite"]  = "Interface\\TargetingFrame\\UI-TargetingFrame-Elite",
    ["normal"] = "Interface\\TargetingFrame\\UI-PlayerFrame",
}

local function ApplySilverFrame()
    if PlayerFrameTexture then
        local currentType = SilverFrameDB or "rare"
        local tex = textures[currentType] or textures["rare"]
        
        PlayerFrameTexture:SetTexture(tex)
        
        if currentType == "normal" then
            -- Restaura a posição e orientação originais da Blizzard
            PlayerFrameTexture:ClearAllPoints()
            PlayerFrameTexture:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 6, -6)
            PlayerFrameTexture:SetTexCoord(0, 1, 0, 1)
        else
            -- Reposiciona a textura (+13px X, +10px Y) para alinhar perfeitamente o retrato e as barras
            PlayerFrameTexture:ClearAllPoints()
            PlayerFrameTexture:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 19, 4)
            PlayerFrameTexture:SetTexCoord(1, 0, 0, 1)
        end
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

-- Mantém a textura correta quando a frame do jogador é atualizada pelo jogo
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
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame set to: |cff00ffffSilver Dragon (Rare)|r")
    elseif cmd == "2" or cmd == "elite" or cmd == "gold" then
        SilverFrameDB = "elite"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame set to: |cffffd700Gold Dragon (Elite)|r")
    elseif cmd == "normal" or cmd == "reset" or cmd == "0" then
        SilverFrameDB = "normal"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame restored to: |cffffffffNormal|r")
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame Commands]|r:")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf 1|r or |cffffd100/sf rare|r - Silver Dragon (Rare)")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf 2|r or |cffffd100/sf elite|r - Gold Dragon (Elite)")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf normal|r - Default frame")
        return
    end
    
    ApplySilverFrame()
end
