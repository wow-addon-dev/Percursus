local _, SRT = ...

local L = SRT.localization
local Utils = SRT.utils

local RaceTracker = {}

local defaultHigh
local defaultWidth

local canGlide = false

local count
local raceTicker
local finalTicker = nil

--------------
--- Frames ---
--------------

local raceTrackerFrame

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

local function SetBackgroundFrame(type, width, high)
    raceTrackerFrame:SetSize(width, high)

    if type == 0 then
        raceTrackerFrame.background:SetTexture(SRT.MEDIA_PATH .. "raceTrackerBackground-01-bg.blp")
        raceTrackerFrame.background:ClearAllPoints()
        raceTrackerFrame.background:SetSize(width, high - 8)
        raceTrackerFrame.background:SetPoint("TOPLEFT", 0, -4)

        raceTrackerFrame.top:SetTexture(SRT.MEDIA_PATH .. "raceTrackerBackground-01-border.blp")
        raceTrackerFrame.top:ClearAllPoints()
        raceTrackerFrame.top:SetSize(width, 4)
        raceTrackerFrame.top:SetPoint("TOPLEFT", 0, 0)

        raceTrackerFrame.bottom:SetTexture(SRT.MEDIA_PATH .. "raceTrackerBackground-01-border.blp")
        raceTrackerFrame.bottom:ClearAllPoints()
        raceTrackerFrame.bottom:SetSize(width, 4)
        raceTrackerFrame.bottom:SetPoint("BOTTOMLEFT", 0, 0)

        raceTrackerFrame.background:Show()
        raceTrackerFrame.top:Show()
        raceTrackerFrame.bottom:Show()
        raceTrackerFrame.left:Hide()
        raceTrackerFrame.right:Hide()
    elseif type == 1 then
        raceTrackerFrame.background:SetTexture(SRT.MEDIA_PATH .. "raceTrackerBackground-02-bg.blp")
        raceTrackerFrame.background:ClearAllPoints()
        raceTrackerFrame.background:SetSize(width - 4, high - 4)
        raceTrackerFrame.background:SetPoint("TOPLEFT", 2, -2)

        raceTrackerFrame.top:SetTexture(SRT.MEDIA_PATH .. "raceTrackerBackground-02-border.blp")
        raceTrackerFrame.top:ClearAllPoints()
        raceTrackerFrame.top:SetSize(width, 2)
        raceTrackerFrame.top:SetPoint("TOPLEFT", 0, 0)

        raceTrackerFrame.bottom:SetTexture(SRT.MEDIA_PATH .. "raceTrackerBackground-02-border.blp")
        raceTrackerFrame.bottom:ClearAllPoints()
        raceTrackerFrame.bottom:SetSize(width, 2)
        raceTrackerFrame.bottom:SetPoint("BOTTOMLEFT", 0, 0)

        raceTrackerFrame.left:SetTexture(SRT.MEDIA_PATH .. "raceTrackerBackground-02-border.blp")
        raceTrackerFrame.left:ClearAllPoints()
        raceTrackerFrame.left:SetSize(2, high)
        raceTrackerFrame.left:SetPoint("TOPLEFT", 0, 0)

        raceTrackerFrame.right:SetTexture(SRT.MEDIA_PATH .. "raceTrackerBackground-02-border.blp")
        raceTrackerFrame.right:ClearAllPoints()
        raceTrackerFrame.right:SetSize(2, high)
        raceTrackerFrame.right:SetPoint("TOPLEFT", width - 2, 0)

        raceTrackerFrame.background:Show()
        raceTrackerFrame.top:Show()
        raceTrackerFrame.bottom:Show()
        raceTrackerFrame.left:Show()
        raceTrackerFrame.right:Show()
    end
end

local function ShowRaceTracker(raceQuestID, raceGoldTime, racePersonalTime)
    StopFinalTicker()

    defaultHigh = 64
    defaultWidth = 256

    raceTrackerFrame:SetPoint("CENTER", SRT.data.options["race-tracker-horizontal-shift"], SRT.data.options["race-tracker-vertical-shift"])

    raceTrackerFrame.timer:ClearAllPoints()
    raceTrackerFrame.timer:SetPoint("CENTER", 0, 10)
    raceTrackerFrame.timer:SetText(C_QuestLog.GetTitleForQuestID(raceQuestID))

    raceTrackerFrame.info:ClearAllPoints()
    raceTrackerFrame.info:SetPoint("CENTER", 0, -10)

    raceTrackerFrame.speed:Hide()

    if SRT.data.options["race-tracker-background"] then
        if SRT.data.options["race-tracker-background-type"] == 1 then
            local widthTimer = raceTrackerFrame.timer:GetStringWidth()
            Utils:PrintDebug(tostring(widthTimer))
            if widthTimer > 240 then
                SetBackgroundFrame(SRT.data.options["race-tracker-background-type"], widthTimer + 26, defaultHigh)
            else
                SetBackgroundFrame(SRT.data.options["race-tracker-background-type"], defaultWidth, defaultHigh)
            end
        else
            SetBackgroundFrame(SRT.data.options["race-tracker-background-type"], defaultWidth, defaultHigh)
        end
    else
        raceTrackerFrame.background:Hide()
        raceTrackerFrame.top:Hide()
        raceTrackerFrame.bottom:Hide()
        raceTrackerFrame.left:Hide()
        raceTrackerFrame.right:Hide()
    end

    if SRT.data.options["race-tracker-mode"] == 0 then
        raceTrackerFrame.info:SetText(L["gold-time"]:format(raceGoldTime))
    elseif SRT.data.options["race-tracker-mode"] == 1 then
        raceTrackerFrame.info:SetText(L["gold-time"]:format(raceGoldTime))
    elseif SRT.data.options["race-tracker-mode"] == 2 then
        if racePersonalTime == -1 then
            raceTrackerFrame.info:SetText(L["personal-best-time-not-available"])
        elseif racePersonalTime == 0 then
            raceTrackerFrame.info:SetText(L["personal-best-time-no-race"])
        else
            raceTrackerFrame.info:SetText(L["personal-best-time"]:format(racePersonalTime))
        end
    end

    C_Timer.After(5, function()
        if SRT.data.options["race-tracker-mode"] == 0 or (SRT.data.options["race-tracker-mode"] == 2 and racePersonalTime <= 0) then
            raceTrackerFrame.timer:SetText(string.format(L["time"], 0))
        elseif SRT.data.options["race-tracker-mode"] == 1 then
            raceTrackerFrame.timer:SetText(L["time"]:format(-raceGoldTime))
        elseif SRT.data.options["race-tracker-mode"] == 2 then
            raceTrackerFrame.timer:SetText(L["time"]:format(-racePersonalTime))
        end

        local _, c, _ = C_PlayerInfo.GetGlidingInfo()
        canGlide = c

        if SRT.data.options["race-tracker-gliding-speed"] and canGlide then
            defaultHigh = 84

            raceTrackerFrame.timer:ClearAllPoints()
            raceTrackerFrame.timer:SetPoint("CENTER", 0, 20)

            raceTrackerFrame.info:ClearAllPoints()
            raceTrackerFrame.info:SetPoint("CENTER", 0, 0)

            raceTrackerFrame.speed:ClearAllPoints()
            raceTrackerFrame.speed:SetPoint("CENTER", 0, -20)

            raceTrackerFrame.speed:Show()
        end

        SetBackgroundFrame(SRT.data.options["race-tracker-background-type"], defaultWidth, defaultHigh)
    end)

    raceTrackerFrame:Show()
end

local function InitializeFrames ()
    raceTrackerFrame = CreateFrame("Frame", nil, UIParent)
    raceTrackerFrame:Hide()

    raceTrackerFrame.background = raceTrackerFrame:CreateTexture(nil, "BACKGROUND")
    raceTrackerFrame.top = raceTrackerFrame:CreateTexture(nil, "BACKGROUND")
    raceTrackerFrame.bottom = raceTrackerFrame:CreateTexture(nil, "BACKGROUND")
    raceTrackerFrame.left = raceTrackerFrame:CreateTexture(nil, "BACKGROUND")
    raceTrackerFrame.right = raceTrackerFrame:CreateTexture(nil, "BACKGROUND")

    raceTrackerFrame.timer = raceTrackerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    raceTrackerFrame.info = raceTrackerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    raceTrackerFrame.speed = raceTrackerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
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

        if SRT.data.options["race-tracker-gliding-speed"] and canGlide then
            local _, _, forwardSpeed = C_PlayerInfo.GetGlidingInfo()

            raceTrackerFrame.speed:SetText(L["gliding-speed"]:format(tostring(Round(forwardSpeed))))
        end

        if isCountdown and not isFirstTry and not isInit then
            isInit = true
            raceStartTime = -1

            if SRT.data.options["race-tracker-mode"] == 0 or (SRT.data.options["race-tracker-mode"] == 2 and racePersonalTime <= 0) then
                raceTrackerFrame.timer:SetText(string.format(L["time"], 0))
            elseif SRT.data.options["race-tracker-mode"] == 1 then
                raceTrackerFrame.timer:SetText(L["time"]:format(-raceGoldTime))
            elseif SRT.data.options["race-tracker-mode"] == 2 then
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

            if SRT.data.options["race-tracker-mode"] == 0 then
                raceTrackerFrame.timer:SetText(L["time"]:format(elapsedTime))

                if elapsedTime <= raceGoldTime then
                    raceTrackerFrame.info:SetText(L["gold-time"]:format(raceGoldTime))
                elseif elapsedTime <= raceSilverTime then
                    raceTrackerFrame.info:SetText(L["silver-time"]:format(raceSilverTime))
                else
                    raceTrackerFrame.info:SetText(L["bronze-time"])
                end
            elseif SRT.data.options["race-tracker-mode"] == 1 then
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
            elseif SRT.data.options["race-tracker-mode"] == 2 then
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

    if SRT.data.options["race-tracker-gliding-speed"] then
        raceTrackerFrame.speed:SetText(L["gliding-speed"]:format("0"))
    end

    finalTicker = C_Timer.NewTicker(1, function()
        if count >= SRT.data.options["race-tracker-fadeout-delay"] then
            raceTrackerFrame:Hide()
            StopFinalTicker()
        else
            count = count + 1
        end
    end)
end

SRT.raceTracker = RaceTracker
