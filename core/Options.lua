local addonName, PER = ...

local L = PER.localization
local Utils = PER.utils
local Dialog = PER.dialog

local Options = {}

---------------------
--- Main Funtions ---
---------------------

function Options:Initialize()
    local offsetY = -20
    local spacing = 30

    local backdrop = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Friendsframe\\UI-Toast-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
    }

    local canvasFrame = CreateFrame("Frame", nil, UIParent)

    local header = canvasFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightHuge")
    header:SetPoint("TOPLEFT", canvasFrame, 7, -22)
    header:SetText(addonName)

    local scrollFrame = CreateFrame("ScrollFrame", nil, canvasFrame, "QuestScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", canvasFrame, "TOPLEFT", 0, -54)
    scrollFrame:SetPoint("BOTTOMRIGHT", canvasFrame, "BOTTOMRIGHT", -29, 0)

    local scrollView = CreateFrame("Frame")
    scrollView:SetSize(1, 1)
    scrollFrame:SetScrollChild(scrollView)

    do
        local descriptionFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        descriptionFrame:ClearAllPoints()
        descriptionFrame:SetPoint("TOPLEFT", scrollView, "TOPLEFT", 10, offsetY)
        descriptionFrame:SetWidth(615)
        descriptionFrame:SetBackdrop(backdrop)
        descriptionFrame:SetBackdropColor(0,0,0,0.4)

        descriptionFrame.title = descriptionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        descriptionFrame.title:SetPoint("TOPLEFT", 8, 15)
        descriptionFrame.title:SetText(L["info.description"])

        local text = descriptionFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("TOPLEFT", descriptionFrame, "TOPLEFT", 15, -15)
        text:SetPoint("TOPRIGHT", descriptionFrame, "TOPRIGHT",  -15, -15)
        text:SetWidth(descriptionFrame:GetWidth() - 30)
        text:SetJustifyH("LEFT")
        text:SetSpacing(2)
        text:SetWordWrap(true)
        text:SetText(L["info.description.text"])

        local totalHeight = text:GetStringHeight() + 30
        descriptionFrame:SetHeight(totalHeight)

        offsetY = offsetY - descriptionFrame:GetHeight() - spacing
    end

    do
        local helpFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        helpFrame:ClearAllPoints()
        helpFrame:SetPoint("TOPLEFT", scrollView, "TOPLEFT", 10, offsetY)
        helpFrame:SetWidth(615)
        helpFrame:SetBackdrop(backdrop)
        helpFrame:SetBackdropColor(0, 0, 0, 0.4)

        helpFrame.title = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        helpFrame.title:SetPoint("TOPLEFT", 8, 15)
        helpFrame.title:SetText(L["info.help"])

        local text = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("TOPLEFT", helpFrame, "TOPLEFT", 15, -15)
        text:SetPoint("TOPRIGHT", helpFrame, "TOPRIGHT", -15, -15)
        text:SetWidth(helpFrame:GetWidth() - 30)
        text:SetJustifyH("LEFT")
        text:SetSpacing(2)
        text:SetWordWrap(true)
        text:SetText(L["info.help.text"])

        local divider = helpFrame:CreateTexture(nil, "BACKGROUND")
        divider:SetPoint("TOP", text, "BOTTOM", 0, -10)
        divider:SetSize(550, 6)
        divider:SetAtlas("thewarwithin-scenario-line-top-glowing")
        divider:SetDesaturated(true)
        divider:SetVertexColor(Utils:HexToRGB("ffB9B9B9"))

        local buttonReset = CreateFrame("Button", nil, helpFrame, "UIPanelButtonTemplate")
        buttonReset:SetPoint("TOP", divider, "BOTTOM", 0, -10)
        buttonReset:SetSize(200, 22)
        buttonReset:SetText(L["info.help.reset-button.name"])
        buttonReset:SetScript("OnClick", function(self)
            Dialog:ShowResetOptionsDialog()
        end)
        buttonReset:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:SetText(L["info.help.reset-button.name"], 1, 1, 1, true)
            GameTooltip:AddLine(L["info.help.reset-button.desc"], true)
            GameTooltip:Show()
        end)
        buttonReset:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        local totalHeight = text:GetStringHeight() + 48 + 30
        helpFrame:SetHeight(totalHeight)

        offsetY = offsetY - helpFrame:GetHeight() - spacing
    end

    do
        local aboutFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        aboutFrame:ClearAllPoints()
        aboutFrame:SetPoint("TOPLEFT", scrollView, "TOPLEFT", 10, offsetY)
        aboutFrame:SetWidth(615)
        aboutFrame:SetBackdrop(backdrop)
        aboutFrame:SetBackdropColor(0, 0, 0, 0.4)

        aboutFrame.title = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        aboutFrame.title:SetPoint("TOPLEFT", 8, 15)
        aboutFrame.title:SetText(L["info.about"])

        local text = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("TOPLEFT", aboutFrame, "TOPLEFT", 15, -15)
        text:SetPoint("TOPRIGHT", aboutFrame, "TOPRIGHT",  -15, -15)
        text:SetWidth(aboutFrame:GetWidth() - 30)
        text:SetJustifyH("LEFT")
        text:SetSpacing(2)
        text:SetWordWrap(true)
        text:SetText(L["info.about.text"]:format(PER.GAME_VERSION .. " (" .. PER.GAME_FLAVOR .. ")", PER.ADDON_VERSION .. " (" .. PER.ADDON_BUILD_DATE .. ")", PER.ADDON_AUTHOR))

        local divider = aboutFrame:CreateTexture(nil, "BACKGROUND")
        divider:SetPoint("TOP", text, "BOTTOM", 0, -10)
        divider:SetSize(550, 6)
        divider:SetAtlas("thewarwithin-scenario-line-top-glowing")
        divider:SetDesaturated(true)
        divider:SetVertexColor(Utils:HexToRGB("ffB9B9B9"))

        local buttonGithub = CreateFrame("Button", nil, aboutFrame, "UIPanelButtonTemplate")
        buttonGithub:SetPoint("TOP", divider, "BOTTOM", 0, -10)
        buttonGithub:SetSize(150, 22)
        buttonGithub:SetText(L["info.help.github-button.name"])
        buttonGithub:SetScript("OnClick", function(self)
            Dialog:ShowCopyAddressDialog(PER.LINK_GITHUB)
        end)
        buttonGithub:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
            GameTooltip:SetText(L["info.help.github-button.name"], 1, 1, 1, true)
            GameTooltip:AddLine(L["info.help.github-button.desc"], true)
            GameTooltip:Show()
        end)
        buttonGithub:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)

        local totalHeight = text:GetStringHeight() + 48 + 30
        aboutFrame:SetHeight(totalHeight)

        local lastLine = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        lastLine:SetPoint("TOPLEFT", aboutFrame, "BOTTOMLEFT", 0, -10)
    end

    local mainCategory = Settings.RegisterCanvasLayoutCategory(canvasFrame, addonName)
    mainCategory.ID = addonName

    local variableTable = PER.data.options
    local category, layout = Settings.RegisterVerticalLayoutSubcategory(mainCategory, L["options"])

	local ParentCheckboxRaceTrackerSpeed

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.race-tracker"]))

    do
        local name = L["options.race-tracker.name"]
        local tooltip = L["options.race-tracker.tooltip"]
        local variable = "race-tracker"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local name = L["options.race-tracker-mode.name"]
        local tooltip = L["options.race-tracker-mode.tooltip"]
        local variable = "race-tracker-mode"
        local defaultValue = 0

        local function GetOptions()
            local container = Settings.CreateControlTextContainer()
            container:Add(0, L["options.race-tracker-mode.value.0"])
            container:Add(1, L["options.race-tracker-mode.value.1"])
            container:Add(2, L["options.race-tracker-mode.value.2"])
            return container:GetData()
        end

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Number, name, defaultValue)
        Settings.CreateDropdown(category, setting, GetOptions, tooltip)
    end

    do
        local name = L["options.race-tracker-background.name"]
        local tooltip = L["options.race-tracker-background.tooltip"]
        local variable = "race-tracker-background"
        local defaultValue = 0

        local function GetOptions()
            local container = Settings.CreateControlTextContainer()
            container:Add(0, L["options.race-tracker-background.value.0"])
            container:Add(1, L["options.race-tracker-background.value.1"])
			container:Add(2, L["options.race-tracker-background.value.2"])
			container:Add(3, L["options.race-tracker-background.value.3"])
            return container:GetData()
        end

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Number, name, defaultValue)
        Settings.CreateDropdown(category, setting, GetOptions, tooltip)
    end

    do
        local name = L["options.race-tracker-horizontal-shift.name"]
        local tooltip = L["options.race-tracker-horizontal-shift.tooltip"]
        local variable = "race-tracker-horizontal-shift"
        local defaultValue = 0

        local minValue = -500
        local maxValue = 500
        local step = 10

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Number, name, defaultValue)

		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

        Settings.CreateSlider(category, setting, options, tooltip)
    end

    do
        local name = L["options.race-tracker-vertical-shift.name"]
        local tooltip = L["options.race-tracker-vertical-shift.tooltip"]
        local variable = "race-tracker-vertical-shift"
        local defaultValue = 200

        local minValue = -400
        local maxValue = 400
        local step = 10

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Number, name, defaultValue)

		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

        Settings.CreateSlider(category, setting, options, tooltip)
    end

    do
        local name = L["options.race-tracker-fadeout-delay.name"]
        local tooltip = L["options.race-tracker-fadeout-delay.tooltip"]
        local variable = "race-tracker-fadeout-delay"
        local defaultValue = 3

        local minValue = 1
        local maxValue = 10
        local step = 1

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Number, name, defaultValue)

		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. " " .. L["seconds-short"] end)

		Settings.CreateSlider(category, setting, options, tooltip)
    end

    do
        local name = L["options.race-tracker-speed-display.name"]
        local tooltip = L["options.race-tracker-speed-display.tooltip"]
        local variable = "race-tracker-speed-display"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        ParentCheckboxRaceTrackerSpeed = Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local name = L["options.race-tracker-speed-display-horizontal-shift.name"]
        local tooltip = L["options.race-tracker-speed-display-horizontal-shift.tooltip"]
        local variable = "race-tracker-speed-display-horizontal-shift"
        local defaultValue = 0

        local minValue = -500
        local maxValue = 500
        local step = 10

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Number, name, defaultValue)

		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

        local slider = Settings.CreateSlider(category, setting, options, tooltip)
		slider:SetParentInitializer(ParentCheckboxRaceTrackerSpeed, function() return PER.data.options["race-tracker-speed-display"] end)
    end

    do
        local name = L["options.race-tracker-speed-display-vertical-shift.name"]
        local tooltip = L["options.race-tracker-speed-display-vertical-shift.tooltip"]
        local variable = "race-tracker-speed-display-vertical-shift"
        local defaultValue = -100

        local minValue = -400
        local maxValue = 400
        local step = 10

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Number, name, defaultValue)

		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

        local slider = Settings.CreateSlider(category, setting, options, tooltip)
		slider:SetParentInitializer(ParentCheckboxRaceTrackerSpeed, function() return PER.data.options["race-tracker-speed-display"] end)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.race-time-overview"]))

    do
        local name = L["options.race-time-overview.name"]
        local tooltip = L["options.race-time-overview.tooltip"]
        local variable = "race-time-overview"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.other"]))

    do
        local name = L["options.debug-mode.name"]
        local tooltip = L["options.debug-mode.tooltip"]
        local variable = "debug-mode"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    Settings.RegisterAddOnCategory(mainCategory)
end

PER.options = Options
