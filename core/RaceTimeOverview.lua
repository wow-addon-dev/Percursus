local addonName, SRT = ...

local L = SRT.localization

local RaceTimeOverview = {}

local raceDataTable = SRT.RACE_DATA
local sortedRaceDataTable = SRT.SORTED_RACE_DATA

--------------
--- Frames ---
--------------
---
local raceOverviewFrame
local zoneOverviewFrame
local globalOverviewFrame

----------------------
--- Local funtions ---
----------------------

----------------------
--- Frame Funtions ---
----------------------

local function UpdateRaceOverview(npcID, scrollFrame)
    if scrollFrame.rows then
        for _, row in ipairs(scrollFrame.rows) do
            for _, element in ipairs(row) do
                element:Hide()
                element:SetParent(nil)
            end
        end
    end

    scrollFrame.rows = {}

    local offsetY = 0

    local zoneID = raceDataTable[npcID][2]
    local questID = raceDataTable[npcID][3].NORMAL[1]

    local quest = scrollFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    quest:SetPoint("TOP", 0, 35)

    QuestEventListener:AddCallback(questID, function()
        local name = C_QuestLog.GetTitleForQuestID(questID)
        quest:SetText(name)
    end)

    table.insert(scrollFrame.rows, {quest})

    local difficulties = raceDataTable[npcID][3]

    for _, modeKey in ipairs(SRT.DIFFICULTY_ORDER) do
        if difficulties[modeKey] then
            local lookupKey = "race-" .. modeKey:lower():gsub("_", "-")

            local racePersonalTime = -1
            local raceGoldTime = raceDataTable[npcID][3][modeKey][4]
            local raceSilverTime = raceDataTable[npcID][3][modeKey][5]

            if raceDataTable[npcID][3][modeKey][2] ~= 0 then
                racePersonalTime = C_CurrencyInfo.GetCurrencyInfo(raceDataTable[npcID][3][modeKey][2]).quantity / 1000
            end

            local mode = scrollFrame.scrollView:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            mode:SetPoint("TOPLEFT", 0, offsetY)
            mode:SetJustifyH("LEFT")
            mode:SetText(L[lookupKey])

            offsetY = offsetY - 20

            local bestTime = scrollFrame.scrollView:CreateFontString(nil, "OVERLAY", "GameFontWhite")
            bestTime:SetPoint("TOPLEFT", 0, offsetY)
            bestTime:SetJustifyH("LEFT")

            if racePersonalTime == -1 then
                bestTime:SetText(L["personal-best-time-not-available"])
            elseif racePersonalTime == 0 then
                bestTime:SetText(L["personal-best-time-no-race"])
            else
                local time

                if racePersonalTime <= raceGoldTime then
                    time = "|T616373:0|t |c" .. SRT.GOLD_FONT_COLOR .. racePersonalTime .. "|r"
                elseif racePersonalTime <= raceSilverTime then
                    time = "|T616375:0|t |c" .. SRT.COLOR_SILVER .. racePersonalTime .. "|r"
                else
                    time = "|T616372:0|t |c" .. SRT.COLOR_BRONZE .. racePersonalTime .. "|r"
                end

                bestTime:SetText(L["personal-best-time"]:format(time))
            end

            offsetY = offsetY - 20

            local goldSilverTime = scrollFrame.scrollView:CreateFontString(nil, "OVERLAY", "GameFontWhite")
            goldSilverTime:SetPoint("TOPLEFT", 0, offsetY)
            goldSilverTime:SetJustifyH("LEFT")
            goldSilverTime:SetText(L["gold-time"]:format(raceGoldTime) .. " - " .. L["silver-time"]:format(raceSilverTime))

            table.insert(scrollFrame.rows, {mode, bestTime, goldSilverTime})

            offsetY = offsetY - 40
        end
    end

    return zoneID
end

local function UpdateZoneOverview(zoneID, scrollFrame)
    if scrollFrame.rows then
        for _, row in ipairs(scrollFrame.rows) do
            for _, element in ipairs(row) do
                element:Hide()
                element:SetParent(nil)
            end
        end
    end

    scrollFrame.rows = {}

    local zone = scrollFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    zone:SetPoint("TOP", 0, 35)
    zone:SetText(C_Map.GetMapInfo(zoneID).name)
    table.insert(scrollFrame.rows, {zone})

    local offsetY = 0
    local count = 1

    for _, raceData in ipairs(sortedRaceDataTable) do
        if raceData.zoneID == zoneID then
            local modes = raceData.modes
            local questID = modes.NORMAL[1]

            local header = scrollFrame.scrollView:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            header:SetPoint("TOPLEFT", 0, offsetY)
            header:SetJustifyH("LEFT")
            table.insert(scrollFrame.rows, {header})

            QuestEventListener:AddCallback(questID, function()
                local name = C_QuestLog.GetTitleForQuestID(questID)
                header:SetText(count .. ". " .. name)
                count = count + 1
            end)

            offsetY = offsetY - 20

            for _, mode in ipairs(SRT.DIFFICULTY_ORDER) do
                local data = modes[mode]

                if data then
                    local time = "-"
                    local difficulty
                    local racePersonalTime = -1
                    local raceGoldTime = data[4]
                    local raceSilverTime = data[5]

                    if data[2] ~= 0 then
                        racePersonalTime = C_CurrencyInfo.GetCurrencyInfo(data[2]).quantity / 1000
                    end

                    if mode == "NORMAL" then
                        difficulty = L["race-normal"]
                    elseif mode == "ADVANCED" then
                        difficulty = L["race-advanced"]
                    elseif mode == "REVERSE" then
                        difficulty = L["race-reverse"]
                    elseif mode == "CHALLENGE" then
                        difficulty = L["race-challenge"]
                    elseif mode == "CHALLENGE_REVERSE" then
                        difficulty = L["race-challenge-reverse"]
                    elseif mode == "STORM_GRYPHON" then
                        difficulty = L["race-storm-gryphon"]
                    end

                    local text = scrollFrame.scrollView:CreateFontString(nil, "OVERLAY", "GameFontWhite")
                    text:SetPoint("TOPLEFT", 0, offsetY)
                    text:SetJustifyH("LEFT")
                    table.insert(scrollFrame.rows, {text})

                    if racePersonalTime > 0 then
                        if racePersonalTime <= raceGoldTime then
                            time = "|T616373:0|t |c" .. SRT.GOLD_FONT_COLOR .. racePersonalTime .. "|r"
                        elseif racePersonalTime <= raceSilverTime then
                            time = "|T616375:0|t |c" .. SRT.COLOR_SILVER .. racePersonalTime .. "|r"
                        else
                            time = "|T616372:0|t |c" .. SRT.COLOR_BRONZE .. racePersonalTime .. "|r"
                        end

                        text:SetText(difficulty .. ": " .. time .. " " .. L['seconds-short'])
                    else
                        text:SetText(difficulty .. ": " .. time)
                    end

                    offsetY = offsetY - 16
                end
            end

            offsetY = offsetY - 16
        end
    end
end

local function InitializeFrames()
    do
        raceOverviewFrame = CreateFrame("Frame", "RaceTimeOverview", GossipFrame, "PortraitFrameTemplate")
        raceOverviewFrame:SetPoint("TOPLEFT", GossipFrame, "TOPRIGHT", 15, 0)
        raceOverviewFrame:SetSize(370, 430)
        raceOverviewFrame:SetTitle(addonName)
        raceOverviewFrame:Hide()

        raceOverviewFrame.portrait = raceOverviewFrame:GetPortrait()
        raceOverviewFrame.portrait:SetPoint('TOPLEFT', -5, 8)
        raceOverviewFrame.portrait:SetTexture(SRT.MEDIA_PATH .. "icon-round.blp")

        local background = CreateFrame("Frame", nil, raceOverviewFrame, "InsetFrameTemplate4")
        background:SetSize(350, 330)
        background:SetPoint("BOTTOM", raceOverviewFrame, "BOTTOM", 0, 37)
        background.texture = background:CreateTexture(nil, "BACKGROUND")
        background.texture:SetAllPoints(background)
        background.texture:SetPoint("CENTER")
        background.texture:SetAtlas("character-panel-background", false)

        raceOverviewFrame.scrollFrame = CreateFrame("ScrollFrame", nil, raceOverviewFrame, "SRT_OverviewScrollFrameTemplate")
        raceOverviewFrame.scrollFrame:SetPoint("TOPLEFT", background, "TOPLEFT", 15, -15)
        raceOverviewFrame.scrollFrame:SetPoint("BOTTOMRIGHT", background, "BOTTOMRIGHT", -25, 15)

        raceOverviewFrame.scrollFrame.scrollView = CreateFrame("Frame")
        raceOverviewFrame.scrollFrame.scrollView:SetSize(1, 1)
        raceOverviewFrame.scrollFrame:SetScrollChild(raceOverviewFrame.scrollFrame.scrollView)

        raceOverviewFrame.openButton = CreateFrame("Button", nil, raceOverviewFrame, "UIPanelButtonTemplate")
        raceOverviewFrame.openButton:SetPoint("TOPRIGHT", background, "BOTTOMRIGHT", -5, -5)
        raceOverviewFrame.openButton:SetSize(130, 22)
        raceOverviewFrame.openButton:SetText(L["button.zone-overview"])

        raceOverviewFrame.openButton:SetScript("OnClick", function()
            if zoneOverviewFrame:IsShown() then
                zoneOverviewFrame:Hide()
            else
                zoneOverviewFrame:Show()
            end
        end)
    end

    do
        zoneOverviewFrame = CreateFrame("Frame", nil, raceOverviewFrame, "DefaultPanelTemplate")
        zoneOverviewFrame:SetPoint("TOPLEFT", raceOverviewFrame, "TOPRIGHT", 15, 0)
        zoneOverviewFrame:SetSize(375, 430)
        zoneOverviewFrame:SetTitle(L["title.zone-overview"])
        zoneOverviewFrame:Hide()

        local background = CreateFrame("Frame", nil, zoneOverviewFrame, "InsetFrameTemplate4")
        background:SetSize(350, 330)
        background:SetPoint("BOTTOM", zoneOverviewFrame, "BOTTOM", 3, 37)
        background.texture = background:CreateTexture(nil, "BACKGROUND")
        background.texture:SetAllPoints(background)
        background.texture:SetPoint("CENTER")
        background.texture:SetAtlas("character-panel-background", false)

        zoneOverviewFrame.scrollFrame = CreateFrame("ScrollFrame", nil, zoneOverviewFrame, "SRT_OverviewScrollFrameTemplate")
        zoneOverviewFrame.scrollFrame:SetPoint("TOPLEFT", background, "TOPLEFT", 15, -15)
        zoneOverviewFrame.scrollFrame:SetPoint("BOTTOMRIGHT", background, "BOTTOMRIGHT", -25, 15)

        zoneOverviewFrame.scrollFrame.scrollView = CreateFrame("Frame")
        zoneOverviewFrame.scrollFrame.scrollView:SetSize(1, 1)
        zoneOverviewFrame.scrollFrame:SetScrollChild(zoneOverviewFrame.scrollFrame.scrollView)

        zoneOverviewFrame.closeButton = CreateFrame("Button", nil, zoneOverviewFrame, "UIPanelButtonTemplate")
        zoneOverviewFrame.closeButton:SetPoint("TOPRIGHT", background, "BOTTOMRIGHT", -5, -5)
        zoneOverviewFrame.closeButton:SetSize(100, 22)
        zoneOverviewFrame.closeButton:SetText(L["button.close"])

        zoneOverviewFrame.closeButton:SetScript("OnClick", function()
            zoneOverviewFrame:Hide()
        end)
    end
end

---------------------
--- Main funtions ---
---------------------

function RaceTimeOverview:Initialize()
    InitializeFrames()
end

function RaceTimeOverview:ShowRaceOverview(npcID)
    local zoneID = UpdateRaceOverview(npcID, raceOverviewFrame.scrollFrame)
    UpdateZoneOverview(zoneID, zoneOverviewFrame.scrollFrame)

    raceOverviewFrame:Show()
end

function RaceTimeOverview:HideRaceOverview()
    zoneOverviewFrame:Hide()
	raceOverviewFrame:Hide()
end

SRT.raceTimeOverview = RaceTimeOverview
