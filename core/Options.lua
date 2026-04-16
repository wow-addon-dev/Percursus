local addonName, PER = ...

local L = PER.localization
local Utils = PER.utils

local AWL = ArcaneWizardLibrary

local Options = {}

----------------------
--- Local Funtions ---
----------------------

local minimapButtonProxy = setmetatable({}, {
    __index = function(_, key)
        return not PER.options.general["minimap-button"]["hide"]
    end,
    __newindex = function(_, key, value)
        PER.options.general["minimap-button"]["hide"] = not value

        if value then
            Utils.minimapButton:Show("Percursus")
        else
            Utils.minimapButton:Hide("Percursus")
        end
    end,
})

---------------------
--- Main Funtions ---
---------------------

function Options:Initialize()
    local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)

	local variableTableGeneral = PER.options.general
	local variableTableRaceTracker = PER.options.raceTracker
	local variableTableRaceTimeOverview = PER.options.raceTimeOverview
	local variableTableOther = PER.options.other

	local ParentCheckboxRaceTrackerSpeed

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

	do
        local name = L["options.general.minimap-button.name"]
        local tooltip = L["options.general.minimap-button.tooltip"]
        local variable = "hide"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, minimapButtonProxy, Settings.VarType.Boolean, name, not defaultValue)

        Settings.CreateCheckbox(category, setting, tooltip)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.race-tracker"]))

    do
        local name = L["options.race-tracker.active.name"]
        local tooltip = L["options.race-tracker.active.tooltip"]
        local variable = "active"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableRaceTracker, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local name = L["options.race-tracker.mode.name"]
        local tooltip = L["options.race-tracker.mode.tooltip"]
        local variable = "mode"
        local defaultValue = 0

        local function GetOptions()
            local container = Settings.CreateControlTextContainer()
            container:Add(0, L["options.race-tracker.mode.value.0"])
            container:Add(1, L["options.race-tracker.mode.value.1"])
            container:Add(2, L["options.race-tracker.mode.value.2"])
            return container:GetData()
        end

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableRaceTracker, Settings.VarType.Number, name, defaultValue)
        Settings.CreateDropdown(category, setting, GetOptions, tooltip)
    end

    do
        local name = L["options.race-tracker.background-type.name"]
        local tooltip = L["options.race-tracker.background-type.tooltip"]
        local variable = "background-type"
        local defaultValue = 0

        local function GetOptions()
            local container = Settings.CreateControlTextContainer()
            container:Add(0, L["options.race-tracker.background-type.value.0"])
            container:Add(1, L["options.race-tracker.background-type.value.1"])
			container:Add(2, L["options.race-tracker.background-type.value.2"])
			container:Add(3, L["options.race-tracker.background-type.value.3"])
			container:Add(4, L["options.race-tracker.background-type.value.4"])
			container:Add(7, L["options.race-tracker.background-type.value.7"])
			container:Add(5, L["options.race-tracker.background-type.value.5"])
			container:Add(6, L["options.race-tracker.background-type.value.6"])
			container:Add(9, L["options.race-tracker.background-type.value.9"])
			container:Add(8, L["options.race-tracker.background-type.value.8"])
            return container:GetData()
        end

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableRaceTracker, Settings.VarType.Number, name, defaultValue)
        Settings.CreateDropdown(category, setting, GetOptions, tooltip)
    end

    do
        local name = L["options.race-tracker.horizontal-shift.name"]
        local tooltip = L["options.race-tracker.horizontal-shift.tooltip"]
        local variable = "horizontal-shift"
        local defaultValue = 0

        local minValue = -500
        local maxValue = 500
        local step = 10

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableRaceTracker, Settings.VarType.Number, name, defaultValue)

		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

        Settings.CreateSlider(category, setting, options, tooltip)
    end

    do
        local name = L["options.race-tracker.vertical-shift.name"]
        local tooltip = L["options.race-tracker.vertical-shift.tooltip"]
        local variable = "vertical-shift"
        local defaultValue = 200

        local minValue = -400
        local maxValue = 400
        local step = 10

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableRaceTracker, Settings.VarType.Number, name, defaultValue)

		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

        Settings.CreateSlider(category, setting, options, tooltip)
    end

    do
        local name = L["options.race-tracker.hide-area-names.name"]
        local tooltip = L["options.race-tracker.hide-area-names.tooltip"]
        local variable = "hide-area-names"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableRaceTracker, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	do
        local nameCheckbox = L["options.race-tracker.result-display.name"]
        local tooltipCheckbox = L["options.race-tracker.result-display.tooltip"]
        local variableCheckbox = "result-display"
        local defaultValueCheckbox = false

        local settingCheckbox = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableCheckbox, variableCheckbox, variableTableRaceTracker, Settings.VarType.Boolean, nameCheckbox, not defaultValueCheckbox)

        local nameSlider = L["options.race-tracker.fadeout-delay.name"]
        local tooltipSlider = L["options.race-tracker.fadeout-delay.tooltip"]
        local variableSlider = "fadeout-delay"
        local defaultValueSlider = 3

        local minValue = 1
        local maxValue = 10
        local step = 1

        local settingSlider = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variableSlider, variableSlider, variableTableRaceTracker, Settings.VarType.Number, nameSlider, defaultValueSlider)

		local optionsSlider = Settings.CreateSliderOptions(minValue, maxValue, step)
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value) return value .. " " .. L["seconds-short"] end)

        local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, nameCheckbox, tooltipCheckbox, settingSlider, optionsSlider, nameSlider, tooltipSlider)

        layout:AddInitializer(initializer)
    end

    do
        local name = L["options.race-tracker.speed-display.name"]
        local tooltip = L["options.race-tracker.speed-display.tooltip"]
        local variable = "speed-display"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableRaceTracker, Settings.VarType.Boolean, name, defaultValue)
        ParentCheckboxRaceTrackerSpeed = Settings.CreateCheckbox(category, setting, tooltip)
    end

    do
        local name = L["options.race-tracker.speed-display-horizontal-shift.name"]
        local tooltip = L["options.race-tracker.speed-display-horizontal-shift.tooltip"]
        local variable = "speed-display-horizontal-shift"
        local defaultValue = 0

        local minValue = -500
        local maxValue = 500
        local step = 10

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableRaceTracker, Settings.VarType.Number, name, defaultValue)

		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

        local slider = Settings.CreateSlider(category, setting, options, tooltip)
		slider:SetParentInitializer(ParentCheckboxRaceTrackerSpeed, function() return PER.options.raceTracker["speed-display"] end)
    end

    do
        local name = L["options.race-tracker.speed-display-vertical-shift.name"]
        local tooltip = L["options.race-tracker.speed-display-vertical-shift.tooltip"]
        local variable = "speed-display-vertical-shift"
        local defaultValue = -100

        local minValue = -400
        local maxValue = 400
        local step = 10

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableRaceTracker, Settings.VarType.Number, name, defaultValue)

		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
        options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)

        local slider = Settings.CreateSlider(category, setting, options, tooltip)
		slider:SetParentInitializer(ParentCheckboxRaceTrackerSpeed, function() return PER.options.raceTracker["speed-display"] end)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.race-time-overview"]))

    do
        local name = L["options.race-time-overview.active.name"]
        local tooltip = L["options.race-time-overview.active.tooltip"]
        local variable = "active"
        local defaultValue = true

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_race-time-overview_" .. variable, variable, variableTableRaceTimeOverview, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

    layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.other"]))

    do
        local name = L["options.other.debug-mode.name"]
        local tooltip = L["options.other.debug-mode.tooltip"]
        local variable = "debug-mode"
        local defaultValue = false

        local setting = Settings.RegisterAddOnSetting(category, addonName .. "_" .. variable, variable, variableTableOther, Settings.VarType.Boolean, name, defaultValue)
        Settings.CreateCheckbox(category, setting, tooltip)
    end

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.about"]))

	do
		local data = {
			leftText = L["options.about.game-version"],
			rightText = PER.GAME_VERSION .. " (" .. PER.GAME_FLAVOR .. ")",
		}

		local text = layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_OptionsMenuText", data))

		function text:GetExtent()
			return 14
		end
	end

	do
		local data = {
			leftText = L["options.about.addon-version"],
			rightText = PER.ADDON_VERSION .. " (" .. PER.ADDON_BUILD_DATE .. ")"
		}

		local text = layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_OptionsMenuText", data))

		function text:GetExtent()
			return 14
		end
	end

	do
		local data = {
			leftText = L["options.about.author"],
			rightText = PER.ADDON_AUTHOR
		}

		local text = layout:AddInitializer(Settings.CreateElementInitializer("ArcaneWizardLibrary_OptionsMenuText", data))
	end

	do
        local name = L["options.about.button-github.name"]
        local tooltip = L["options.about.button-github.tooltip"]
		local buttonText = L["options.about.button-github.button"]

        local function OnButtonClick()
            AWL.Dialog:ShowLinkDialog(PER.LINK_GITHUB)
        end

        local buttonInitializer = CreateSettingsButtonInitializer(name, buttonText, OnButtonClick, tooltip, true)
        layout:AddInitializer(buttonInitializer)
    end

    Settings.RegisterAddOnCategory(category)

	PER.MAIN_CATEGORY_ID = category:GetID()
end

PER.options = Options
