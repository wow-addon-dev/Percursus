local addonName, PER = ...

local L = PER.localization
local Utils = PER.utils
local Dialog = PER.dialog
local Options = PER.options
local RaceTracker = PER.raceTracker
local RaceTimeOverview = PER.raceTimeOverview

local raceDataTable = PER.RACE_DATA

local raceQuestID = -1
local raceSpellID = -1
local raceGoldTime = -1
local raceSilverTime = -1
local racePersonalTime = -1

----------------------
--- Local funtions ---
----------------------

local function CheckRaceQuest(questID)
    for _, dataWrapper in pairs(raceDataTable) do
        local _, _, modes = unpack(dataWrapper)
        for _, data in pairs(modes) do
            if data[1] == questID then
                return true
            end
        end
    end

    return false
end

local function GetRaceData(questID)
    for _, dataWrapper in pairs(raceDataTable) do
        local _, _, modes = unpack(dataWrapper)
        for mode, data in pairs(modes) do
            if data[1] == questID then
                return {
                    mode = mode,
                    questID = data[1],
                    raceTime = data[2],
                    spellID = data[3],
                    goldTime = data[4],
                    silverTime = data[5]
                }
            end
        end
    end

    return nil
end

local function SlashCommand(msg, editbox)
    if not msg or msg:trim() == "" then
        Settings.OpenToCategory("Skyriding Race Tracker")
	else
        Utils:PrintDebug("No arguments will be accepted.")
	end
end

--------------
--- Frames ---
--------------

local percursusFrame = CreateFrame("Frame", "Percursus")

---------------------
--- Main funtions ---
---------------------

function percursusFrame:OnEvent(event, ...)
	self[event](self, event, ...)
end

function percursusFrame:ADDON_LOADED(_, addOnName)
    if addOnName == addonName then
        Utils:InitializeDatabase()
        Dialog:InitializeDialog()
        Options:Initialize()
        RaceTracker:Initialize()
        RaceTimeOverview:Initialize()

        Utils:PrintDebug("Addon fully loaded.")
    end
end

function percursusFrame:QUEST_ACCEPTED(_, questID)
    local result = GetRaceData(questID)

    --Utils:PrintDebug("questID: " .. questID)

    if result ~= nil then
        Utils:PrintDebug("Event 'QUEST_ACCEPTED' fired. Payload: " .. C_QuestLog.GetTitleForQuestID(questID) .. " (" .. questID ..")")

        if PER.data.options["race-tracker"] then
            raceQuestID = result.questID
            raceSpellID = result.spellID
            raceGoldTime = result.goldTime
            raceSilverTime = result.silverTime

            if result.raceTime ~= 0 then
                racePersonalTime = C_CurrencyInfo.GetCurrencyInfo(result.raceTime).quantity / 1000
            end

            RaceTracker:Start(raceQuestID, raceSpellID, raceGoldTime, raceSilverTime, racePersonalTime)
        else
            Utils:PrintDebug("No race tracker requested.")
        end
    end
end

function percursusFrame:QUEST_REMOVED(_, questID)
    if CheckRaceQuest(questID) then
        raceQuestID = -1
        raceSpellID = -1
        raceGoldTime = -1
        raceSilverTime = -1
        racePersonalTime = -1

        RaceTracker:Stop()

        Utils:PrintDebug("Event 'QUEST_REMOVED' fired. Payload: " .. C_QuestLog.GetTitleForQuestID(questID) .. " (" .. questID ..")")
    end
end

function percursusFrame:DISPLAY_EVENT_TOASTS()
    Utils:PrintDebug("Event 'DISPLAY_EVENT_TOASTS' fired. No payload.")
	--local toastInfo = C_EventToastManager.GetNextToastToDisplay()

	--print(tostring(toastInfo.title))
	--print(tostring(toastInfo.eventToastID))
	--print(tostring(toastInfo.eventType))
	--print(tostring(toastInfo.displayType))

	--C_EventToastManager.RemoveCurrentToast()
	--EventToastManagerFrame:Hide()
end

GossipFrame:HookScript("OnShow",function()
    if UnitExists("target") and PER.data.options["race-time-overview"] then
		local npcID = select(6, strsplit("-", tostring(UnitGUID("target"))))
        npcID = tonumber(npcID)

        --skyridingRaceTracker:PrintDebug("npcID: " .. npcID)

        if raceDataTable[npcID] ~= nil then
            RaceTimeOverview:ShowRaceOverview(npcID)
        end
    end
end)

GossipFrame:HookScript("OnHide",function()
    RaceTimeOverview:HideRaceOverview()
end)

percursusFrame:RegisterEvent("ADDON_LOADED")
percursusFrame:RegisterEvent("QUEST_ACCEPTED")
percursusFrame:RegisterEvent("QUEST_REMOVED")
percursusFrame:RegisterEvent("DISPLAY_EVENT_TOASTS")
percursusFrame:SetScript("OnEvent", percursusFrame.OnEvent)

SLASH_Percursus1, SLASH_Percursus2 = '/per', '/Percursus'

SlashCmdList["Percursus"] = SlashCommand
