local addonName, PER = ...

local L = PER.localization
local Utils = PER.utils
local Dialog = PER.dialog

local Options = {}

---------------------
--- Main Funtions ---
---------------------

function Options:Initialize()
    local backdrop = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Friendsframe\\UI-Toast-Border",
		tile = true, tileSize = 8, edgeSize = 8,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
    }

    local canvasFrame = CreateFrame("Frame", nil, UIParent)

    do
		local header = canvasFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightHuge")
		header:SetPoint("TOPLEFT", canvasFrame, 7, -22)
		header:SetText(addonName)

		local scrollFrame = CreateFrame("ScrollFrame", nil, canvasFrame, "QuestScrollFrameTemplate")
		scrollFrame:SetPoint("TOPLEFT", canvasFrame, "TOPLEFT", 0, -54)
		scrollFrame:SetPoint("BOTTOMRIGHT", canvasFrame, "BOTTOMRIGHT", -29, 0)

		local scrollView = CreateFrame("Frame")
		scrollView:SetSize(1, 1)
		scrollFrame:SetScrollChild(scrollView)

        local descriptionFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        descriptionFrame:SetPoint("TOPLEFT", scrollView, "TOPLEFT", 10, -20)
        descriptionFrame:SetWidth(615)
        descriptionFrame:SetBackdrop(backdrop)
        descriptionFrame:SetBackdropColor(0, 0, 0, 0.4)

        descriptionFrame.title = descriptionFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        descriptionFrame.title:SetPoint("TOPLEFT", 8, 15)
        descriptionFrame.title:SetText(L["info.description"])

        descriptionFrame.text = descriptionFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        descriptionFrame.text:SetPoint("TOPLEFT", descriptionFrame, "TOPLEFT", 15, -15)
        descriptionFrame.text:SetPoint("TOPRIGHT", descriptionFrame, "TOPRIGHT",  -15, -15)
        descriptionFrame.text:SetWidth(descriptionFrame:GetWidth() - 30)
        descriptionFrame.text:SetJustifyH("LEFT")
        descriptionFrame.text:SetSpacing(2)
        descriptionFrame.text:SetText(L["info.description.text"])

        descriptionFrame:SetHeight(descriptionFrame.text:GetStringHeight() + 30)

        local helpFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        helpFrame:SetPoint("TOPLEFT", descriptionFrame, "BOTTOMLEFT", 0, -30)
        helpFrame:SetWidth(615)
        helpFrame:SetBackdrop(backdrop)
        helpFrame:SetBackdropColor(0, 0, 0, 0.4)

        helpFrame.title = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        helpFrame.title:SetPoint("TOPLEFT", 8, 15)
        helpFrame.title:SetText(L["info.help"])

        helpFrame.text = helpFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        helpFrame.text:SetPoint("TOPLEFT", helpFrame, "TOPLEFT", 15, -15)
        helpFrame.text:SetPoint("TOPRIGHT", helpFrame, "TOPRIGHT", -15, -15)
        helpFrame.text:SetWidth(helpFrame:GetWidth() - 30)
        helpFrame.text:SetJustifyH("LEFT")
        helpFrame.text:SetSpacing(2)
        helpFrame.text:SetText(L["info.help.text"])

        helpFrame.divider = helpFrame:CreateTexture(nil, "BACKGROUND")
        helpFrame.divider:SetPoint("TOP", helpFrame.text, "BOTTOM", 0, -10)
        helpFrame.divider:SetSize(550, 6)
        helpFrame.divider:SetAtlas("RecipeList-Divider")
        helpFrame.divider:SetDesaturated(true)

        local buttonReset = CreateFrame("Button", nil, helpFrame, "UIPanelButtonTemplate")
        buttonReset:SetPoint("TOP", helpFrame.divider, "BOTTOM", 0, -10)
        buttonReset:SetSize(200, 22)
        buttonReset:SetText(L["info.help.reset-button.name"])
        buttonReset:SetScript("OnClick", function(self)
            Dialog:ShowResetOptionsDialog()
        end)
        buttonReset:SetScript("OnEnter", function(self)
			GameTooltip:ClearAllPoints()
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

			GameTooltip_SetTitle(GameTooltip, L["info.help.reset-button.name"])
			GameTooltip_AddNormalLine(GameTooltip, L["info.help.reset-button.desc"])

			GameTooltip:Show()
        end)
		buttonReset:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
        end)

        helpFrame:SetHeight(helpFrame.text:GetStringHeight() + 48 + 30)

        local aboutFrame = CreateFrame("Frame", nil, scrollView, "BackdropTemplate")
        aboutFrame:SetPoint("TOPLEFT", helpFrame, "BOTTOMLEFT", 0, -30)
        aboutFrame:SetWidth(615)
        aboutFrame:SetBackdrop(backdrop)
        aboutFrame:SetBackdropColor(0, 0, 0, 0.4)

        aboutFrame.title = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        aboutFrame.title:SetPoint("TOPLEFT", 8, 15)
        aboutFrame.title:SetText(L["info.about"])

        aboutFrame.text = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        aboutFrame.text :SetPoint("TOPLEFT", aboutFrame, "TOPLEFT", 15, -15)
        aboutFrame.text :SetPoint("TOPRIGHT", aboutFrame, "TOPRIGHT",  -15, -15)
        aboutFrame.text :SetWidth(aboutFrame:GetWidth() - 30)
        aboutFrame.text :SetJustifyH("LEFT")
        aboutFrame.text :SetSpacing(2)
        aboutFrame.text :SetText(L["info.about.text"]:format(PER.GAME_VERSION .. " (" .. PER.GAME_FLAVOR .. ")", PER.ADDON_VERSION .. " (" .. PER.ADDON_BUILD_DATE .. ")", PER.ADDON_AUTHOR))

        aboutFrame.divider = aboutFrame:CreateTexture(nil, "BACKGROUND")
        aboutFrame.divider:SetPoint("TOP", aboutFrame.text , "BOTTOM", 0, -10)
        aboutFrame.divider:SetSize(550, 6)
        aboutFrame.divider:SetAtlas("RecipeList-Divider")
        aboutFrame.divider:SetDesaturated(true)

        local buttonGithub = CreateFrame("Button", nil, aboutFrame, "UIPanelButtonTemplate")
        buttonGithub:SetPoint("TOP", aboutFrame.divider, "BOTTOM", 0, -10)
        buttonGithub:SetSize(150, 22)
        buttonGithub:SetText(L["info.help.github-button.name"])
        buttonGithub:SetScript("OnClick", function(self)
            Dialog:ShowCopyAddressDialog(PER.LINK_GITHUB)
        end)
        buttonGithub:SetScript("OnEnter", function(self)
			GameTooltip:ClearAllPoints()
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

			GameTooltip_SetTitle(GameTooltip, L["info.help.github-button.name"])
			GameTooltip_AddNormalLine(GameTooltip, L["info.help.github-button.desc"])

			GameTooltip:Show()
        end)
		buttonGithub:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
        end)

        aboutFrame:SetHeight(aboutFrame.text :GetStringHeight() + 48 + 30)

		local lastLine = aboutFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        lastLine:SetPoint("TOPLEFT", aboutFrame, "BOTTOMLEFT", 0, -10)
    end

    local mainCategory = Settings.RegisterCanvasLayoutCategory(canvasFrame, addonName)

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
        local name = L["options.race-tracker-background-type.name"]
        local tooltip = L["options.race-tracker-background-type.tooltip"]
        local variable = "race-tracker-background-type"
        local defaultValue = 0

        local function GetOptions()
            local container = Settings.CreateControlTextContainer()
            container:Add(0, L["options.race-tracker-background-type.value.0"])
            container:Add(1, L["options.race-tracker-background-type.value.1"])
			container:Add(2, L["options.race-tracker-background-type.value.2"])
			container:Add(3, L["options.race-tracker-background-type.value.3"])
			container:Add(4, L["options.race-tracker-background-type.value.4"])
			container:Add(7, L["options.race-tracker-background-type.value.7"])
			container:Add(5, L["options.race-tracker-background-type.value.5"])
			container:Add(6, L["options.race-tracker-background-type.value.6"])
			container:Add(9, L["options.race-tracker-background-type.value.9"])
			container:Add(8, L["options.race-tracker-background-type.value.8"])
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
        local name = L["options.race-tracker-hide-area-names.name"]
        local tooltip = L["options.race-tracker-hide-area-names.tooltip"]
        local variable = "race-tracker-hide-area-names"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTable, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	do
        local nameCheckbox = L["options.race-tracker-result-display.name"]
        local tooltipCheckbox = L["options.race-tracker-result-display.tooltip"]
        local variableCheckbox = "race-tracker-result-display"
        local defaultValueCheckbox = false

        local settingCheckbox = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableCheckbox, variableCheckbox, variableTable, Settings.VarType.Boolean, nameCheckbox, not defaultValueCheckbox)

        local nameSlider = L["options.race-tracker-fadeout-delay.name"]
        local tooltipSlider = L["options.race-tracker-fadeout-delay.tooltip"]
        local variableSlider = "race-tracker-fadeout-delay"
        local defaultValueSlider = 3

        local minValue = 1
        local maxValue = 10
        local step = 1

        local settingSlider = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableSlider, variableSlider, variableTable, Settings.VarType.Number, nameSlider, defaultValueSlider)

		local optionsSlider = Settings.CreateSliderOptions(minValue, maxValue, step)
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. " " .. L["seconds-short"] end)

        local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

        layout:AddInitializer(initializer)
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

	PER.MAIN_CATEGORY_ID = mainCategory:GetID()
end

PER.options = Options
