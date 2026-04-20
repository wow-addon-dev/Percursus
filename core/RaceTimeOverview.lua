local addonName, PER = ...

local L = PER.localization

local RaceTimeOverview = {}

local raceDataTable = PER.RACE_DATA
local sortedRaceDataTable = PER.SORTED_RACE_DATA

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
	local count = raceDataTable[npcID][3]

	if count >= 1 then
		raceOverviewFrame.openButton:Disable()

		local npc = scrollFrame:CreateFontString(nil, "OVERLAY", "Fancy16Font")
		npc:SetPoint("TOP", 5, 40)

		local function GetNPCNameByIDAsync(npcID, callback)
			if not npcID or type(callback) ~= "function" then return end

			local hyperlink = string.format("unit:Creature-0-0-0-0-%d-0", npcID)

			local function CheckForName()
				local tooltipInfo = C_TooltipInfo.GetHyperlink(hyperlink)
				if tooltipInfo and tooltipInfo.lines and tooltipInfo.lines[1] then
					local name = tooltipInfo.lines[1].leftText
					if name and name ~= "" then
						return name
					end
				end
				return nil
			end

			local immediateName = CheckForName()
			if immediateName then
				callback(immediateName)
				return
			end

			local maxRetries = 20
			local attempts = 0
			local ticker

			ticker = C_Timer.NewTicker(0.1, function()
				attempts = attempts + 1
				local fetchedName = CheckForName()

				if fetchedName then
					ticker:Cancel()
					callback(fetchedName)
				elseif attempts >= maxRetries then
					ticker:Cancel()
					callback(nil)
				end
			end)
		end

		GetNPCNameByIDAsync(npcID, function(name)
			if name then
				npc:SetText("|cnNORMAL_FONT_COLOR:".. name .. "|r")
			end
		end)

		table.insert(scrollFrame.rows, {npc})

		local races = raceDataTable[npcID][4]

		for _, modeKey in ipairs(PER.RACE_ORDER) do
			if races[modeKey] then
				local questID = raceDataTable[npcID][4][modeKey][1]

				local racePersonalTime = -1
				local raceGoldTime = raceDataTable[npcID][4][modeKey][4]
				local raceSilverTime = raceDataTable[npcID][4][modeKey][5]

				if raceDataTable[npcID][4][modeKey][2] ~= 0 then
					racePersonalTime = C_CurrencyInfo.GetCurrencyInfo(raceDataTable[npcID][4][modeKey][2]).quantity / 1000
				end

				local mode = scrollFrame.scrollView:CreateFontString(nil, "OVERLAY", "GameFontNormal")
				mode:SetPoint("TOPLEFT", 0, offsetY)
				mode:SetJustifyH("LEFT")

				QuestEventListener:AddCallback(questID, function()
					local name = C_QuestLog.GetTitleForQuestID(questID)
					mode:SetText(name)
				end)

				offsetY = offsetY - 20

				local bestTime = scrollFrame.scrollView:CreateFontString(nil, "OVERLAY", "GameFontWhite")
				bestTime:SetPoint("TOPLEFT", 0, offsetY)
				bestTime:SetJustifyH("LEFT")

				if racePersonalTime == -1 then
					bestTime:SetText(L["race.personal-best-time-not-available"])
				elseif racePersonalTime == 0 then
					bestTime:SetText(L["race.personal-best-time-no-race"])
				else
					local time

					if racePersonalTime <= raceGoldTime then
						time = "|T616373:0|t |cnGOLD_FONT_COLOR:".. racePersonalTime .. "|r"
					elseif racePersonalTime <= raceSilverTime then
						time = "|T616375:0|t |c" .. PER.COLOR_SILVER .. racePersonalTime .. "|r"
					else
						time = "|T616372:0|t |c" .. PER.COLOR_BRONZE .. racePersonalTime .. "|r"
					end

					bestTime:SetText(L["race.personal-best-time"]:format(time))
				end

				offsetY = offsetY - 20

				local goldSilverTime = scrollFrame.scrollView:CreateFontString(nil, "OVERLAY", "GameFontWhite")
				goldSilverTime:SetPoint("TOPLEFT", 0, offsetY)
				goldSilverTime:SetJustifyH("LEFT")
				goldSilverTime:SetText(L["race.gold-time"]:format(raceGoldTime) .. " - " .. L["race.silver-time"]:format(raceSilverTime))

				table.insert(scrollFrame.rows, {mode, bestTime, goldSilverTime})

				offsetY = offsetY - 40
			end
		end
	else
		raceOverviewFrame.openButton:Enable()

		local questID = raceDataTable[npcID][4].NORMAL[1]

		local quest = scrollFrame:CreateFontString(nil, "OVERLAY", "Fancy16Font")
		quest:SetPoint("TOP", 5, 40)

		QuestEventListener:AddCallback(questID, function()
			local name = C_QuestLog.GetTitleForQuestID(questID)
			quest:SetText("|cnNORMAL_FONT_COLOR:".. name .. "|r")
		end)

		table.insert(scrollFrame.rows, {quest})

		local difficulties = raceDataTable[npcID][4]

		for _, modeKey in ipairs(PER.DIFFICULTY_ORDER) do
			if difficulties[modeKey] then
				local lookupKey = "race.type-" .. modeKey:lower():gsub("_", "-")

				local racePersonalTime = -1
				local raceGoldTime = raceDataTable[npcID][4][modeKey][4]
				local raceSilverTime = raceDataTable[npcID][4][modeKey][5]

				if raceDataTable[npcID][4][modeKey][2] ~= 0 then
					racePersonalTime = C_CurrencyInfo.GetCurrencyInfo(raceDataTable[npcID][4][modeKey][2]).quantity / 1000
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
					bestTime:SetText(L["race.personal-best-time-not-available"])
				elseif racePersonalTime == 0 then
					bestTime:SetText(L["race.personal-best-time-no-race"])
				else
					local time

					if racePersonalTime <= raceGoldTime then
						time = "|T616373:0|t |cnGOLD_FONT_COLOR:".. racePersonalTime .. "|r"
					elseif racePersonalTime <= raceSilverTime then
						time = "|T616375:0|t |c" .. PER.COLOR_SILVER .. racePersonalTime .. "|r"
					else
						time = "|T616372:0|t |c" .. PER.COLOR_BRONZE .. racePersonalTime .. "|r"
					end

					bestTime:SetText(L["race.personal-best-time"]:format(time))
				end

				offsetY = offsetY - 20

				local goldSilverTime = scrollFrame.scrollView:CreateFontString(nil, "OVERLAY", "GameFontWhite")
				goldSilverTime:SetPoint("TOPLEFT", 0, offsetY)
				goldSilverTime:SetJustifyH("LEFT")
				goldSilverTime:SetText(L["race.gold-time"]:format(raceGoldTime) .. " - " .. L["race.silver-time"]:format(raceSilverTime))

				table.insert(scrollFrame.rows, {mode, bestTime, goldSilverTime})

				offsetY = offsetY - 40
			end
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

    local zone = scrollFrame:CreateFontString(nil, "OVERLAY", "Fancy16Font")
    zone:SetPoint("TOP", 5, 40)
    zone:SetText("|cnNORMAL_FONT_COLOR:".. C_Map.GetMapInfo(zoneID).name .. "|r")
    table.insert(scrollFrame.rows, {zone})

    local offsetY = 0
    local count = 1

    for _, raceData in ipairs(sortedRaceDataTable) do
        if raceData.zoneID == zoneID and raceData.count == 0 then
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

            for _, mode in ipairs(PER.DIFFICULTY_ORDER) do
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
                        difficulty = L["race.type-normal"]
                    elseif mode == "ADVANCED" then
                        difficulty = L["race.type-advanced"]
                    elseif mode == "REVERSE" then
                        difficulty = L["race.type-reverse"]
                    elseif mode == "CHALLENGE" then
                        difficulty = L["race.type-challenge"]
                    elseif mode == "CHALLENGE_REVERSE" then
                        difficulty = L["race.type-challenge-reverse"]
                    elseif mode == "STORM_GRYPHON" then
                        difficulty = L["race.type-storm-gryphon"]
                    end

                    local text = scrollFrame.scrollView:CreateFontString(nil, "OVERLAY", "GameFontWhite")
                    text:SetPoint("TOPLEFT", 0, offsetY)
                    text:SetJustifyH("LEFT")
                    table.insert(scrollFrame.rows, {text})

                    if racePersonalTime > 0 then
                        if racePersonalTime <= raceGoldTime then
                            time = "|T616373:0|t |cnGOLD_FONT_COLOR:" .. racePersonalTime .. "|r"
                        elseif racePersonalTime <= raceSilverTime then
                            time = "|T616375:0|t |c" .. PER.COLOR_SILVER .. racePersonalTime .. "|r"
                        else
                            time = "|T616372:0|t |c" .. PER.COLOR_BRONZE .. racePersonalTime .. "|r"
                        end

                        text:SetText(difficulty .. ": " .. time .. " " .. L["race.seconds-short"])
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
        raceOverviewFrame = CreateFrame("Frame", nil, GossipFrame, "PortraitFrameTemplate")
        raceOverviewFrame:SetPoint("TOPLEFT", GossipFrame, "TOPRIGHT", 15, 0)
        raceOverviewFrame:SetSize(338, 430)
		raceOverviewFrame:SetFrameStrata("MEDIUM")
        raceOverviewFrame:SetTitle(addonName)
        raceOverviewFrame:Hide()

        raceOverviewFrame.portrait = raceOverviewFrame:GetPortrait()
        raceOverviewFrame.portrait:SetPoint('TOPLEFT', -5, 8)
        raceOverviewFrame.portrait:SetTexture(PER.MEDIA_PATH .. "icon-round.blp")

        local background = CreateFrame("Frame", nil, raceOverviewFrame, "InsetFrameTemplate4")
        background:SetSize(322, 330)
        background:SetPoint("BOTTOM", raceOverviewFrame, "BOTTOM", 0, 37)
        background.texture = background:CreateTexture(nil, "BACKGROUND")
        background.texture:SetAllPoints(background)
        background.texture:SetPoint("CENTER")
        background.texture:SetAtlas("character-panel-background", false)

        raceOverviewFrame.scrollFrame = CreateFrame("ScrollFrame", nil, raceOverviewFrame, "PercursusOverviewScrollFrameTemplate")
        raceOverviewFrame.scrollFrame:SetPoint("TOPLEFT", background, "TOPLEFT", 15, -15)
        raceOverviewFrame.scrollFrame:SetPoint("BOTTOMRIGHT", background, "BOTTOMRIGHT", -25, 15)

        raceOverviewFrame.scrollFrame.scrollView = CreateFrame("Frame")
        raceOverviewFrame.scrollFrame.scrollView:SetSize(1, 1)
        raceOverviewFrame.scrollFrame:SetScrollChild(raceOverviewFrame.scrollFrame.scrollView)

        raceOverviewFrame.openButton = CreateFrame("Button", nil, raceOverviewFrame, "UIPanelButtonTemplate")
        raceOverviewFrame.openButton:SetPoint("TOPRIGHT", background, "BOTTOMRIGHT", -5, -5)
        raceOverviewFrame.openButton:SetSize(130, 22)
        raceOverviewFrame.openButton:SetText(L["race.button.zone-overview"])

        raceOverviewFrame.openButton:SetScript("OnClick", function()
            if zoneOverviewFrame:IsShown() then
                zoneOverviewFrame:Hide()
            else
                zoneOverviewFrame:Show()
				zoneOverviewFrame.scrollFrame:SetVerticalScroll(0)
            end
        end)
    end

    do
        zoneOverviewFrame = CreateFrame("Frame", nil, raceOverviewFrame, "DefaultPanelTemplate")
        zoneOverviewFrame:SetPoint("TOPLEFT", raceOverviewFrame, "TOPRIGHT", 10, 0)
		zoneOverviewFrame:SetPoint("CENTER")
        zoneOverviewFrame:SetSize(343, 430)
        zoneOverviewFrame:SetTitle(L["race.title.zone-overview"])
        zoneOverviewFrame:Hide()

        local background = CreateFrame("Frame", nil, zoneOverviewFrame, "InsetFrameTemplate4")
        background:SetSize(322, 330)
        background:SetPoint("BOTTOM", zoneOverviewFrame, "BOTTOM", 2.5, 37)
        background.texture = background:CreateTexture(nil, "BACKGROUND")
        background.texture:SetAllPoints(background)
        background.texture:SetPoint("CENTER")
        background.texture:SetAtlas("character-panel-background", false)

        zoneOverviewFrame.scrollFrame = CreateFrame("ScrollFrame", nil, zoneOverviewFrame, "PercursusOverviewScrollFrameTemplate")
        zoneOverviewFrame.scrollFrame:SetPoint("TOPLEFT", background, "TOPLEFT", 15, -15)
        zoneOverviewFrame.scrollFrame:SetPoint("BOTTOMRIGHT", background, "BOTTOMRIGHT", -25, 15)

        zoneOverviewFrame.scrollFrame.scrollView = CreateFrame("Frame")
        zoneOverviewFrame.scrollFrame.scrollView:SetSize(1, 1)
        zoneOverviewFrame.scrollFrame:SetScrollChild(zoneOverviewFrame.scrollFrame.scrollView)

        zoneOverviewFrame.closeButton = CreateFrame("Button", nil, zoneOverviewFrame, "UIPanelButtonTemplate")
        zoneOverviewFrame.closeButton:SetPoint("TOPRIGHT", background, "BOTTOMRIGHT", -5, -5)
        zoneOverviewFrame.closeButton:SetSize(100, 22)
        zoneOverviewFrame.closeButton:SetText(L["race.button.close"])

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
	raceOverviewFrame.scrollFrame:SetVerticalScroll(0)
end

function RaceTimeOverview:HideRaceOverview()
    zoneOverviewFrame:Hide()
	raceOverviewFrame:Hide()
end

PER.raceTimeOverview = RaceTimeOverview
