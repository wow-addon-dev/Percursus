local _, PER = ...

local L = PER.localization
local Utils = PER.utils

local RaceTracker = {}

local canGlide = false
local raceTicker

--------------
--- Frames ---
--------------

local raceTrackerFrame
local resultTrackerFrame
local speedDisplayFrame

----------------------
--- Local funtions ---
----------------------

----------------------
--- Frame Funtions ---
----------------------

local function ShowRaceTracker(raceQuestID, raceGoldTime, racePersonalTime)
	resultTrackerFrame:HideFrame()

	raceTrackerFrame:ClearAllPoints()
	resultTrackerFrame:ClearAllPoints()
	speedDisplayFrame:ClearAllPoints()

    raceTrackerFrame:SetPoint("CENTER", PER.data.options["race-tracker-horizontal-shift"], PER.data.options["race-tracker-vertical-shift"])
    resultTrackerFrame:SetPoint("CENTER", PER.data.options["race-tracker-horizontal-shift"], PER.data.options["race-tracker-vertical-shift"])
	speedDisplayFrame:SetPoint("CENTER", PER.data.options["race-tracker-speed-display-horizontal-shift"], PER.data.options["race-tracker-speed-display-vertical-shift"])

    if PER.data.options["race-tracker-background-type"] ~= 0 then
		local style = PER.RACE_TRACKER_BACKGROUNDS[PER.data.options["race-tracker-background-type"]]

		raceTrackerFrame:SetBackground(style)
		resultTrackerFrame:SetBackground(style)
    else
		raceTrackerFrame:RemoveBackground()
		resultTrackerFrame:RemoveBackground()
    end

	raceTrackerFrame:SetTimerText(C_QuestLog.GetTitleForQuestID(raceQuestID))

    if PER.data.options["race-tracker-mode"] == 0 then
        raceTrackerFrame:SetInfoText(L["gold-time"]:format(raceGoldTime))
    elseif PER.data.options["race-tracker-mode"] == 1 then
        raceTrackerFrame:SetInfoText(L["gold-time"]:format(raceGoldTime))
    elseif PER.data.options["race-tracker-mode"] == 2 then
        if racePersonalTime == -1 then
            raceTrackerFrame:SetInfoText(L["personal-best-time-not-available"])
        elseif racePersonalTime == 0 then
            raceTrackerFrame:SetInfoText(L["personal-best-time-no-race"])
        else
            raceTrackerFrame:SetInfoText(L["personal-best-time"]:format(racePersonalTime))
        end
    end

    C_Timer.After(5, function()
        if PER.data.options["race-tracker-mode"] == 0 or (PER.data.options["race-tracker-mode"] == 2 and racePersonalTime <= 0) then
            raceTrackerFrame:SetTimerText(string.format(L["time"], 0))
        elseif PER.data.options["race-tracker-mode"] == 1 then
            raceTrackerFrame:SetTimerText(L["time"]:format(-raceGoldTime))
        elseif PER.data.options["race-tracker-mode"] == 2 then
            raceTrackerFrame:SetTimerText(L["time"]:format(-racePersonalTime))
        end

        local _, c, _ = C_PlayerInfo.GetGlidingInfo()
        canGlide = c

        if PER.data.options["race-tracker-speed-display"] and canGlide then
			speedDisplayFrame:SetSpeedBar(0)
            speedDisplayFrame:ShowFrame()
        end
    end)

    raceTrackerFrame:ShowFrame()
end

local function InitializeFrames ()
	raceTrackerFrame = CreateFrame("Frame", nil, UIParent, "PercursusRaceTrackerTemplate")
    resultTrackerFrame = CreateFrame("Frame", nil, UIParent, "PercursusRaceTrackerTemplate")
    speedDisplayFrame = CreateFrame("Frame", nil, UIParent, "PercursusRaceTrackerSpeedDisplayTemplate")
end

---------------------
--- Main funtions ---
---------------------

function RaceTracker:Initialize()
    InitializeFrames()
end

function RaceTracker:Start(raceQuestID, raceSpellID, raceGoldTime, raceSilverTime, racePersonalTime)
    local isFirstTry = true
    local isInit = false
    local raceStartTime = -1

    local isCountdown = false
    local isRace = false

    ShowRaceTracker(raceQuestID, raceGoldTime, racePersonalTime)

    local function foo(_, _, _, _, _, _, _, _, _, spellId, ...)
        if spellId == 369968 then
            isRace = true
        elseif spellId == raceSpellID then
            isCountdown = true
        end
    end

    raceTicker = C_Timer.NewTicker(0.03, function()
        isCountdown = false
        isRace = false

        AuraUtil.ForEachAura("player", "HELPFUL", nil, foo)

        if isCountdown and not isFirstTry and not isInit then
            isInit = true
            raceStartTime = -1

            if PER.data.options["race-tracker-mode"] == 0 or (PER.data.options["race-tracker-mode"] == 2 and racePersonalTime <= 0) then
                raceTrackerFrame:SetTimerText(string.format(L["time"], 0))
            elseif PER.data.options["race-tracker-mode"] == 1 then
                raceTrackerFrame:SetTimerText(L["time"]:format(-raceGoldTime))
            elseif PER.data.options["race-tracker-mode"] == 2 then
                raceTrackerFrame:SetTimerText(L["time"]:format(-racePersonalTime))
            end

            Utils:PrintDebug("The race was interrupted.")
        elseif isRace and not isCountdown then
			if PER.data.options["race-tracker-speed-display"] and canGlide then
				local _, _, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
				local speed = 208 * Round(forwardSpeed) / 100

				speedDisplayFrame:SetSpeedBar(speed)
			end

            if raceStartTime == -1 then
                isInit = false
                raceStartTime = GetTime()

                if isFirstTry then
                    isFirstTry = false
                else
                    Utils:PrintDebug("The race was restarted.")
                end
            end

            local elapsedTime = GetTime() - raceStartTime

            if PER.data.options["race-tracker-mode"] == 0 then
                raceTrackerFrame:SetTimerText(L["time"]:format(elapsedTime))

                if elapsedTime <= raceGoldTime then
                    raceTrackerFrame:SetInfoText(L["gold-time"]:format(raceGoldTime))
                elseif elapsedTime <= raceSilverTime then
                    raceTrackerFrame:SetInfoText(L["silver-time"]:format(raceSilverTime))
                else
                    raceTrackerFrame:SetInfoText(L["bronze-time"])
                end
            elseif PER.data.options["race-tracker-mode"] == 1 then
                if elapsedTime <= raceGoldTime then
                    local remainingTime = -(raceGoldTime - elapsedTime)
                    raceTrackerFrame:SetTimerText(L["time"]:format(remainingTime))
                    raceTrackerFrame:SetInfoText(L["gold-time"]:format(raceGoldTime))
                elseif elapsedTime <= raceSilverTime then
                    local remainingTime = -(raceSilverTime - elapsedTime)
                    raceTrackerFrame:SetTimerText(L["time"]:format(remainingTime))
                    raceTrackerFrame:SetInfoText(L["silver-time"]:format(raceSilverTime))
                else
                    raceTrackerFrame:SetTimerText(L["time"]:format(0))
                    raceTrackerFrame:SetInfoText(L["bronze-time"])
                end
            elseif PER.data.options["race-tracker-mode"] == 2 then
                if racePersonalTime == -1 then
                    raceTrackerFrame:SetTimerText(L["time"]:format(elapsedTime))
                    raceTrackerFrame:SetInfoText(L["personal-best-time-not-available"])
                elseif racePersonalTime == 0 then
                    raceTrackerFrame:SetTimerText(L["time"]:format(elapsedTime))
                    raceTrackerFrame:SetInfoText(L["personal-best-time-no-race"])
                else
                    if elapsedTime <= racePersonalTime then
                        local remainingTime = -(racePersonalTime - elapsedTime)
                        raceTrackerFrame:SetTimerText(L["time"]:format(remainingTime))
                        raceTrackerFrame:SetInfoText(L["personal-best-time"]:format(racePersonalTime))
                    else
                        raceTrackerFrame:SetTimerText(L["time"]:format(0))
                        raceTrackerFrame:SetInfoText(L["personal-best-time-failed"])
                    end
                end
            end
        end
    end)
end

function RaceTracker:Stop()
    raceTicker:Cancel()

	speedDisplayFrame:HideFrame()

	resultTrackerFrame:SetTimerText(raceTrackerFrame:GetTimerText())
	resultTrackerFrame:SetInfoText(raceTrackerFrame:GetInfoText())

	resultTrackerFrame:ShowFrame()
	raceTrackerFrame:HideFrame()
end

function RaceTracker:HideResultTracker()
	resultTrackerFrame:HideFrame()
end

PER.raceTracker = RaceTracker
