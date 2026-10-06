-- Available textures
local textures = {
    ["rare-elite"] = "Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite",
    ["rare"]       = "Interface\\TargetingFrame\\UI-TargetingFrame-Rare",
    ["elite"]      = "Interface\\TargetingFrame\\UI-TargetingFrame-Elite",
    ["normal"]     = "Interface\\TargetingFrame\\UI-TargetingFrame",
}

local function ApplySilverFrame()
    if PlayerFrameTexture then
        local currentType = SilverFrameDB or "rare-elite"
        local tex = textures[currentType] or textures["rare-elite"]
        
        PlayerFrameTexture:SetTexture(tex)
        
        if currentType == "normal" then
            PlayerFrameTexture:SetTexCoord(0, 1, 0, 1) -- Restore default orientation
        else
            PlayerFrameTexture:SetTexCoord(1, 0, 0, 1) -- Flip horizontally to fit player frame
        end
    end
end

-- Load events
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function()
    if event == "ADDON_LOADED" and arg1 == "SilverFrame" then
        if not SilverFrameDB then 
            SilverFrameDB = "rare-elite" 
        end
    end
    ApplySilverFrame()
end)

-- Preserve texture on player frame updates
if PlayerFrame_Update then
    hooksecurefunc("PlayerFrame_Update", ApplySilverFrame)
end

-- Slash Commands (/sf and /silverframe)
SLASH_SILVERFRAME1 = "/silverframe"
SLASH_SILVERFRAME2 = "/sf"

SlashCmdList["SILVERFRAME"] = function(msg)
    local cmd = string.lower(msg or "")
    
    if cmd == "1" or cmd == "rare" or cmd == "rare-elite" then
        SilverFrameDB = "rare-elite"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame set to: |cff00ffffWinged Silver Dragon (Rare Elite)|r")
    elseif cmd == "2" or cmd == "rare2" or cmd == "raresimple" then
        SilverFrameDB = "rare"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame set to: |cff00ffffSimple Silver Dragon (Rare)|r")
    elseif cmd == "3" or cmd == "elite" or cmd == "gold" then
        SilverFrameDB = "elite"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame set to: |cffffd700Gold Dragon (Elite)|r")
    elseif cmd == "normal" or cmd == "reset" or cmd == "0" then
        SilverFrameDB = "normal"
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame]|r Frame restored to: |cffffffffNormal|r")
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SilverFrame Commands]|r:")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf 1|r or |cffffd100/sf rare|r - Winged Silver Dragon (Rare Elite)")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf 2|r or |cffffd100/sf rare2|r - Simple Silver Dragon (Rare)")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf 3|r or |cffffd100/sf elite|r - Gold Dragon (Elite)")
        DEFAULT_CHAT_FRAME:AddMessage(" |cffffd100/sf normal|r - Default frame")
        return
    end
    
    ApplySilverFrame()
end