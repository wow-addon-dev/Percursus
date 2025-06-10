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
local resultDisplayFrame
local speedDisplayFrame

----------------------
--- Local funtions ---
----------------------

----------------------
--- Frame Funtions ---
----------------------

local function ShowRaceTracker(raceQuestID, raceGoldTime, racePersonalTime)
	resultDisplayFrame:Hide()

    raceTrackerFrame:SetPoint("CENTER", PER.data.options["race-tracker-horizontal-shift"], PER.data.options["race-tracker-vertical-shift"])
    resultDisplayFrame:SetPoint("CENTER", PER.data.options["race-tracker-horizontal-shift"], PER.data.options["race-tracker-vertical-shift"])
	speedDisplayFrame:SetPoint("CENTER", PER.data.options["race-tracker-speed-display-horizontal-shift"], PER.data.options["race-tracker-speed-display-vertical-shift"])

	raceTrackerFrame.timer:SetText(C_QuestLog.GetTitleForQuestID(raceQuestID))

    if PER.data.options["race-tracker-background"] ~= 0 then
		local style = PER.RACE_TRACKER_BACKGROUNDS[PER.data.options["race-tracker-background"]]

		raceTrackerFrame:SetSize(style.width, style.height)
		resultDisplayFrame:SetSize(style.width, style.height)

		raceTrackerFrame.background:SetAllPoints(raceTrackerFrame)
		raceTrackerFrame.background:SetPoint("CENTER")
		resultDisplayFrame.background:SetAllPoints(raceTrackerFrame)
		resultDisplayFrame.background:SetPoint("CENTER")

		if style.type == "file" then
			raceTrackerFrame.background:SetTexture(PER.MEDIA_PATH .. style.texture)
			resultDisplayFrame.background:SetTexture(PER.MEDIA_PATH .. style.texture)
		elseif style.type == "atlas" then
			raceTrackerFrame.background:SetAtlas(style.texture)
			resultDisplayFrame.background:SetAtlas(style.texture)
		end

		raceTrackerFrame.info:ClearAllPoints()
		raceTrackerFrame.info:SetPoint("CENTER", 0, style.yOffsets.info)
		resultDisplayFrame.info:ClearAllPoints()
		resultDisplayFrame.info:SetPoint("CENTER", 0, style.yOffsets.info)

		raceTrackerFrame.timer:ClearAllPoints()
		raceTrackerFrame.timer:SetPoint("CENTER", 0, style.yOffsets.timer)
		resultDisplayFrame.timer:ClearAllPoints()
		resultDisplayFrame.timer:SetPoint("CENTER", 0, style.yOffsets.timer)

		raceTrackerFrame.background:Show()
		resultDisplayFrame.background:Show()
    else
		raceTrackerFrame:SetSize(256, 64)
		resultDisplayFrame:SetSize(256, 64)

		raceTrackerFrame.timer:ClearAllPoints()
		raceTrackerFrame.timer:SetPoint("CENTER", 0, 10)
		resultDisplayFrame.timer:ClearAllPoints()
		resultDisplayFrame.timer:SetPoint("CENTER", 0, 10)

		raceTrackerFrame.info:ClearAllPoints()
		raceTrackerFrame.info:SetPoint("CENTER", 0, -10)
		resultDisplayFrame.info:ClearAllPoints()
		resultDisplayFrame.info:SetPoint("CENTER", 0, -10)

		raceTrackerFrame.background:Hide()
		resultDisplayFrame.background:Hide()
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

    resultDisplayFrame = CreateFrame("Frame", nil, UIParent)
    resultDisplayFrame:Hide()

    resultDisplayFrame.background = resultDisplayFrame:CreateTexture(nil, "BACKGROUND")
    resultDisplayFrame.timer = resultDisplayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    resultDisplayFrame.info = resultDisplayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")

    speedDisplayFrame = CreateFrame("Frame", nil, UIParent)
	speedDisplayFrame:SetSize(220, 31)
    speedDisplayFrame:Hide()

    speedDisplayFrame.borderCenter = speedDisplayFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
	speedDisplayFrame.borderCenter:SetPoint("CENTER")
	speedDisplayFrame.borderCenter:SetSize(150, 31)
	speedDisplayFrame.borderCenter:SetAtlas("UI-Frame-Bar-BorderCenter")

	speedDisplayFrame.borderLeft = speedDisplayFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
	speedDisplayFrame.borderLeft:SetPoint("LEFT")
	speedDisplayFrame.borderLeft:SetSize(35, 31)
	speedDisplayFrame.borderLeft:SetAtlas("UI-Frame-Bar-BorderLeft")

	speedDisplayFrame.borderRight = speedDisplayFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
	speedDisplayFrame.borderRight:SetPoint("RIGHT")
	speedDisplayFrame.borderRight:SetSize(35, 31)
	speedDisplayFrame.borderRight:SetAtlas("UI-Frame-Bar-BorderRight")

	speedDisplayFrame.backgroundCenter = speedDisplayFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
	speedDisplayFrame.backgroundCenter:SetPoint("CENTER")
	speedDisplayFrame.backgroundCenter:SetSize(150, 18)
	speedDisplayFrame.backgroundCenter:SetAtlas("UI-Frame-Bar-BGCenter")

	speedDisplayFrame.backgroundLeft = speedDisplayFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
	speedDisplayFrame.backgroundLeft:SetPoint("LEFT", 6, 0)
	speedDisplayFrame.backgroundLeft:SetSize(29, 18)
	speedDisplayFrame.backgroundLeft:SetAtlas("UI-Frame-Bar-BGLeft")

	speedDisplayFrame.backgroundRight = speedDisplayFrame:CreateTexture(nil, "BACKGROUND", nil, -2)
	speedDisplayFrame.backgroundRight:SetPoint("RIGHT", -6, 0)
	speedDisplayFrame.backgroundRight:SetSize(29, 18)
	speedDisplayFrame.backgroundRight:SetAtlas("UI-Frame-Bar-BGRight")

	speedDisplayFrame.race = speedDisplayFrame:CreateTexture(nil, "BACKGROUND", nil, -1)
	speedDisplayFrame.race:SetPoint("CENTER")
	speedDisplayFrame.race:SetSize(1, 18)
	speedDisplayFrame.race:SetAtlas("UI-Frame-DastardlyDuos-ProgressBar-Fill-yellow")
	speedDisplayFrame.race:Hide()
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
			local speed = 208 * Round(forwardSpeed) / 100

			if speed == 0 then
				speedDisplayFrame.race:SetSize(1, 18)
				speedDisplayFrame.race:Hide()
			else
				speedDisplayFrame.race:SetSize(speed, 15)
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
    raceTicker:Cancel()

	speedDisplayFrame.race:Hide()
	speedDisplayFrame:Hide()

	resultDisplayFrame.timer:SetText(raceTrackerFrame.timer:GetText())
	resultDisplayFrame.info:SetText(raceTrackerFrame.info:GetText())

	resultDisplayFrame:Show()
	raceTrackerFrame:Hide()
end

function RaceTracker:HideResultDisplay()
	resultDisplayFrame:Hide()
end

PER.raceTracker = RaceTracker
