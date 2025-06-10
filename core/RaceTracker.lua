local _, PER = ...

local L = PER.localization
local Utils = PER.utils

local RaceTracker = {}

local canGlide = false

local count
local raceTicker
local finalTicker = nil

--------------
--- Frames ---
--------------

local raceTrackerFrame
local speedDisplayFrame

----------------------
--- Local funtions ---
----------------------

local function StopFinalTicker()
    local status, err = pcall(function ()
        if finalTicker and not finalTicker:IsCancelled() then
            finalTicker:Cancel()
            finalTicker = nil
        end
    end)

    if not status then
        Utils:PrintDebug("Method StopFinalTicker() aborted with exception: " .. err)
    end
end

----------------------
--- Frame Funtions ---
----------------------

local function ShowRaceTracker(raceQuestID, raceGoldTime, racePersonalTime)
    StopFinalTicker()

    raceTrackerFrame:SetPoint("CENTER", PER.data.options["race-tracker-horizontal-shift"], PER.data.options["race-tracker-vertical-shift"])
    speedDisplayFrame:SetPoint("CENTER", PER.data.options["race-tracker-speed-display-horizontal-shift"], PER.data.options["race-tracker-speed-display-vertical-shift"])

	raceTrackerFrame.timer:SetText(C_QuestLog.GetTitleForQuestID(raceQuestID))

    if PER.data.options["race-tracker-background"] ~= 0 then
		local style = PER.RACE_TRACKER_BACKGROUNDS[PER.data.options["race-tracker-background"]]

		raceTrackerFrame:SetSize(style.width, style.height)

		raceTrackerFrame.background:SetAllPoints(raceTrackerFrame)
		raceTrackerFrame.background:SetPoint("CENTER")

		if style.type == "file" then
			raceTrackerFrame.background:SetTexture(PER.MEDIA_PATH .. style.texture)
		elseif style.type == "atlas" then
			raceTrackerFrame.background:SetAtlas(style.texture)
		end

		raceTrackerFrame.info:ClearAllPoints()
		raceTrackerFrame.info:SetPoint("CENTER", 0, style.yOffsets.info)

		raceTrackerFrame.timer:ClearAllPoints()
		raceTrackerFrame.timer:SetPoint("CENTER", 0, style.yOffsets.timer)

		raceTrackerFrame.background:Show()
    else
		raceTrackerFrame:SetSize(256, 64)

		raceTrackerFrame.timer:ClearAllPoints()
		raceTrackerFrame.timer:SetPoint("CENTER", 0, 10)

		raceTrackerFrame.info:ClearAllPoints()
		raceTrackerFrame.info:SetPoint("CENTER", 0, -10)

		raceTrackerFrame.background:Hide()
    end

    if PER.data.options["race-tracker-mode"] == 0 then
        raceTrackerFrame.info:SetText(L["gold-time"]:format(raceGoldTime))
    elseif PER.data.options["race-tracker-mode"] == 1 then
        raceTrackerFrame.info:SetText(L["gold-time"]:format(raceGoldTime))
    elseif PER.data.options["race-tracker-mode"] == 2 then
        if racePersonalTime == -1 then
            raceTrackerFrame.info:SetText(L["personal-best-time-not-available"])
        elseif racePersonalTime == 0 then
            raceTrackerFrame.info:SetText(L["personal-best-time-no-race"])
        else
            raceTrackerFrame.info:SetText(L["personal-best-time"]:format(racePersonalTime))
        end
    end

    C_Timer.After(5, function()
        if PER.data.options["race-tracker-mode"] == 0 or (PER.data.options["race-tracker-mode"] == 2 and racePersonalTime <= 0) then
            raceTrackerFrame.timer:SetText(string.format(L["time"], 0))
        elseif PER.data.options["race-tracker-mode"] == 1 then
            raceTrackerFrame.timer:SetText(L["time"]:format(-raceGoldTime))
        elseif PER.data.options["race-tracker-mode"] == 2 then
            raceTrackerFrame.timer:SetText(L["time"]:format(-racePersonalTime))
        end

        local _, c, _ = C_PlayerInfo.GetGlidingInfo()
        canGlide = c

        if PER.data.options["race-tracker-speed-display"] and canGlide then
            speedDisplayFrame:Show()
        end
    end)

	speedDisplayFrame:Hide()
    raceTrackerFrame:Show()
end

local function InitializeFrames ()
    raceTrackerFrame = CreateFrame("Frame", nil, UIParent)
    raceTrackerFrame:Hide()

    raceTrackerFrame.background = raceTrackerFrame:CreateTexture(nil, "BACKGROUND")
    raceTrackerFrame.timer = raceTrackerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    raceTrackerFrame.info = raceTrackerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")

    speedDisplayFrame = CreateFrame("Frame", nil, UIParent)
	speedDisplayFrame:SetSize(130, 25)
    speedDisplayFrame:Hide()

    speedDisplayFrame.border = speedDisplayFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
	speedDisplayFrame.border:SetPoint("CENTER")
	speedDisplayFrame.border:SetAtlas("worldstate-capturebar-frame-boss", true)

	speedDisplayFrame.background = speedDisplayFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
	speedDisplayFrame.background:SetPoint("CENTER")
	speedDisplayFrame.background:SetSize(125, 9)
	speedDisplayFrame.background:SetAtlas("worldstate-capturebar-neutralfill-boss")

	speedDisplayFrame.race = speedDisplayFrame:CreateTexture(nil, "BACKGROUND", nil, -1)
	speedDisplayFrame.race:SetPoint("CENTER")
	speedDisplayFrame.race:SetSize(1, 9)
	speedDisplayFrame.race:SetAtlas("worldstate-capturebar-neutralfill-target")
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

        if PER.data.options["race-tracker-speed-display"] and canGlide then
            local _, _, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
			local speed = 125 * Round(forwardSpeed) / 100

			if speed == 0 then
				speedDisplayFrame.race:SetSize(1, 9)
				speedDisplayFrame.race:Hide()
			else
				speedDisplayFrame.race:SetSize(speed, 9)
				speedDisplayFrame.race:Show()
			end
        end

        if isCountdown and not isFirstTry and not isInit then
            isInit = true
            raceStartTime = -1

            if PER.data.options["race-tracker-mode"] == 0 or (PER.data.options["race-tracker-mode"] == 2 and racePersonalTime <= 0) then
                raceTrackerFrame.timer:SetText(string.format(L["time"], 0))
            elseif PER.data.options["race-tracker-mode"] == 1 then
                raceTrackerFrame.timer:SetText(L["time"]:format(-raceGoldTime))
            elseif PER.data.options["race-tracker-mode"] == 2 then
                raceTrackerFrame.timer:SetText(L["time"]:format(-racePersonalTime))
            end

            Utils:PrintDebug("The race was interrupted.")
        elseif isRace and not isCountdown then
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
                raceTrackerFrame.timer:SetText(L["time"]:format(elapsedTime))

                if elapsedTime <= raceGoldTime then
                    raceTrackerFrame.info:SetText(L["gold-time"]:format(raceGoldTime))
                elseif elapsedTime <= raceSilverTime then
                    raceTrackerFrame.info:SetText(L["silver-time"]:format(raceSilverTime))
                else
                    raceTrackerFrame.info:SetText(L["bronze-time"])
                end
            elseif PER.data.options["race-tracker-mode"] == 1 then
                if elapsedTime <= raceGoldTime then
                    local remainingTime = -(raceGoldTime - elapsedTime)
                    raceTrackerFrame.timer:SetText(L["time"]:format(remainingTime))
                    raceTrackerFrame.info:SetText(L["gold-time"]:format(raceGoldTime))
                elseif elapsedTime <= raceSilverTime then
                    local remainingTime = -(raceSilverTime - elapsedTime)
                    raceTrackerFrame.timer:SetText(L["time"]:format(remainingTime))
                    raceTrackerFrame.info:SetText(L["silver-time"]:format(raceSilverTime))
                else
                    raceTrackerFrame.timer:SetText(L["time"]:format(0))
                    raceTrackerFrame.info:SetText(L["bronze-time"])
                end
            elseif PER.data.options["race-tracker-mode"] == 2 then
                if racePersonalTime == -1 then
                    raceTrackerFrame.timer:SetText(L["time"]:format(elapsedTime))
                    raceTrackerFrame.info:SetText(L["personal-best-time-not-available"])
                elseif racePersonalTime == 0 then
                    raceTrackerFrame.timer:SetText(L["time"]:format(elapsedTime))
                    raceTrackerFrame.info:SetText(L["personal-best-time-no-race"])
                else
                    if elapsedTime <= racePersonalTime then
                        local remainingTime = -(racePersonalTime - elapsedTime)
                        raceTrackerFrame.timer:SetText(L["time"]:format(remainingTime))
                        raceTrackerFrame.info:SetText(L["personal-best-time"]:format(racePersonalTime))
                    else
                        raceTrackerFrame.timer:SetText(L["time"]:format(0))
                        raceTrackerFrame.info:SetText(L["personal-best-time-failed"])
                    end
                end
            end
        end
    end)
end

function RaceTracker:Stop()
    count = 1
    raceTicker:Cancel()

	speedDisplayFrame:Hide()

    finalTicker = C_Timer.NewTicker(1, function()
        if count >= PER.data.options["race-tracker-fadeout-delay"] then
            raceTrackerFrame:Hide()
            StopFinalTicker()
        else
            count = count + 1
        end
    end)
end

PER.raceTracker = RaceTracker
