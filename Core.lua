-- SilverDragonPlayer
-- OctoWoW / WoW 1.12.1. No ClassicAPI or pfUI required.

local function ApplySilverDragon()
    if PlayerFrameTexture then
        PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare")
    end
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_LEVEL_UP")

events:SetScript("OnEvent", function()
    ApplySilverDragon()
end)
