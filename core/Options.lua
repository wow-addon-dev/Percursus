local addonName, PER = ...

local L = PER.Localization
local Utils = PER.modules.Utils

local AWL = ArcaneWizardLibrary

local Options = {}

-----------------------
--- Local Functions ---
-----------------------

local minimapButtonProxy = setmetatable({}, {
	__index = function(_, key)
		if key == "hide" then
			return not PER.settings.general["minimap-button"]["hide"]
		end
	end,
	__newindex = function(_, key, value)
		if key ~= "hide" then
			return
		end

		PER.settings.general["minimap-button"]["hide"] = not value

		if value then
			Utils.minimapButton:Show("Percursus")
		else
			Utils.minimapButton:Hide("Percursus")
		end
	end,
})

local function GetVal(setting) return setting:GetValue() end

------------------------
--- Public Functions ---
------------------------

function Options:Initialize()
	local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.general"]))

	-- Minimap Button
	AWL.Settings:AddCheckbox(category, {
		variableTable = minimapButtonProxy,
		settingKey    = addonName .. "_hide",
		variableName  = "hide",
		name          = L["options.general.minimap-button.name"],
		tooltip       = L["options.general.minimap-button.tooltip"],
		default       = true
	})

	-- Debug Mode
	AWL.Settings:AddCheckbox(category, {
		variableTable = PER.settings.general,
		settingKey    = addonName .. "_debug-mode",
		variableName  = "debug-mode",
		name          = L["options.general.debug-mode.name"],
		tooltip       = L["options.general.debug-mode.tooltip"],
		default       = false
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.race-tracker"]))

	-- Race Tracker: Active
	AWL.Settings:AddCheckbox(category, {
		variableTable = PER.settings.raceTracker,
		settingKey    = addonName .. "_race-tracker-active",
		variableName  = "active",
		name          = L["options.race-tracker.active.name"],
		tooltip       = L["options.race-tracker.active.tooltip"],
		default       = true
	})

	-- Mode
	AWL.Settings:AddDropdown(category, {
		variableTable = PER.settings.raceTracker,
		settingKey    = addonName .. "_mode",
		variableName  = "mode",
		name          = L["options.race-tracker.mode.name"],
		tooltip       = L["options.race-tracker.mode.tooltip"],
		default       = 0,
		options       = {
			{ value = 0, label = L["options.race-tracker.mode.value.0"] },
			{ value = 1, label = L["options.race-tracker.mode.value.1"] },
			{ value = 2, label = L["options.race-tracker.mode.value.2"] }
		}
	})

	-- Background Type
	AWL.Settings:AddDropdown(category, {
		variableTable = PER.settings.raceTracker,
		settingKey    = addonName .. "_background-type",
		variableName  = "background-type",
		name          = L["options.race-tracker.background-type.name"],
		tooltip       = L["options.race-tracker.background-type.tooltip"],
		default       = 0,
		options       = {
			{ value = 0, label = L["options.race-tracker.background-type.value.0"] },
			{ value = 1, label = L["options.race-tracker.background-type.value.1"] },
			{ value = 2, label = L["options.race-tracker.background-type.value.2"] },
			{ value = 3, label = L["options.race-tracker.background-type.value.3"] },
			{ value = 4, label = L["options.race-tracker.background-type.value.4"] },
			{ value = 7, label = L["options.race-tracker.background-type.value.7"] },
			{ value = 5, label = L["options.race-tracker.background-type.value.5"] },
			{ value = 6, label = L["options.race-tracker.background-type.value.6"] },
			{ value = 9, label = L["options.race-tracker.background-type.value.9"] },
			{ value = 8, label = L["options.race-tracker.background-type.value.8"] }
		}
	})

	-- Horizontal Shift
	AWL.Settings:AddSlider(category, {
		variableTable = PER.settings.raceTracker,
		settingKey    = addonName .. "_horizontal-shift",
		variableName  = "horizontal-shift",
		name          = L["options.race-tracker.horizontal-shift.name"],
		tooltip       = L["options.race-tracker.horizontal-shift.tooltip"],
		default       = 0, minValue = -500, maxValue = 500, step = 10,
		formatter     = function(value) return value end,
	})

	-- Vertical Shift
	AWL.Settings:AddSlider(category, {
		variableTable = PER.settings.raceTracker,
		settingKey    = addonName .. "_vertical-shift",
		variableName  = "vertical-shift",
		name          = L["options.race-tracker.vertical-shift.name"],
		tooltip       = L["options.race-tracker.vertical-shift.tooltip"],
		default       = 200, minValue = -400, maxValue = 400, step = 10,
		formatter     = function(value) return value end,
	})

	-- Hide Area Names
	AWL.Settings:AddCheckbox(category, {
		variableTable = PER.settings.raceTracker,
		settingKey    = addonName .. "_hide-area-names",
		variableName  = "hide-area-names",
		name          = L["options.race-tracker.hide-area-names.name"],
		tooltip       = L["options.race-tracker.hide-area-names.tooltip"],
		default       = false
	})

	-- Result Display
	AWL.Settings:AddCheckboxSliderCombo(category, layout, {
		variableTable      = PER.settings.raceTracker,
		checkboxSettingKey = addonName .. "_result-display",
		checkboxVarName    = "result-display",
		checkboxName       = L["options.race-tracker.result-display.name"],
		checkboxTooltip    = L["options.race-tracker.result-display.tooltip"],
		checkboxDefault    = false,

		sliderSettingKey   = addonName .. "_fadeout-delay",
		sliderVariableName = "fadeout-delay",
		sliderName         = L["options.race-tracker.fadeout-delay.name"],
		sliderTooltip      = L["options.race-tracker.fadeout-delay.tooltip"],
		sliderDefault      = 3, sliderMin = 1, sliderMax = 10, sliderStep = 1,
		sliderFormatter    = function(value) return value .. " " .. L["race.seconds-short"] end
	})

	-- Speed Display (Parent for the next two sliders)
	local initializerSpeed, settingSpeed = AWL.Settings:AddCheckbox(category, {
		variableTable = PER.settings.raceTracker,
		settingKey    = addonName .. "_speed-display",
		variableName  = "speed-display",
		name          = L["options.race-tracker.speed-display.name"],
		tooltip       = L["options.race-tracker.speed-display.tooltip"],
		default       = false
	})

	-- Speed Display: Horizontal Shift
	AWL.Settings:AddSlider(category, {
		variableTable   = PER.settings.raceTracker,
		settingKey      = addonName .. "_speed-display-horizontal-shift",
		variableName    = "speed-display-horizontal-shift",
		name            = L["options.race-tracker.speed-display-horizontal-shift.name"],
		tooltip         = L["options.race-tracker.speed-display-horizontal-shift.tooltip"],
		default         = 0, minValue = -500, maxValue = 500, step = 10,
		formatter    	= function(value) return value end,
		parentInit      = initializerSpeed,
		parentCondition = function() return GetVal(settingSpeed) end
	})

	-- Speed Display: Vertical Shift
	AWL.Settings:AddSlider(category, {
		variableTable   = PER.settings.raceTracker,
		settingKey      = addonName .. "_speed-display-vertical-shift",
		variableName    = "speed-display-vertical-shift",
		name            = L["options.race-tracker.speed-display-vertical-shift.name"],
		tooltip         = L["options.race-tracker.speed-display-vertical-shift.tooltip"],
		default         = -100, minValue = -400, maxValue = 400, step = 10,
		formatter    	= function(value) return value end,
		parentInit      = initializerSpeed,
		parentCondition = function() return GetVal(settingSpeed) end
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["options.race-time-overview"]))

	-- Race Time Overview: Active
	AWL.Settings:AddCheckbox(category, {
		variableTable = PER.settings.raceTimeOverview,
		settingKey    = addonName .. "_race-time-overview-active",
		variableName  = "active",
		name          = L["options.race-time-overview.active.name"],
		tooltip       = L["options.race-time-overview.active.tooltip"],
		default       = true
	})

	-- Profiles Section
	AWL.Settings:AddProfilesSection(layout, {
		useAccountProfile = Utils:IsAccountProfile(),
		onSwitchProfile = function()
			Utils:ToggleProfileMode()
			ReloadUI()
		end,
		onDeleteCharacterProfiles = function()
			Utils:ResetAllCharacterProfiles()
			ReloadUI()
		end
	})

	-- About Section
	AWL.Settings:AddAboutSection(layout, {
		addonVersion   = PER.ADDON_VERSION,
		addonBuildDate = PER.ADDON_BUILD_DATE,
		addonAuthor    = PER.ADDON_AUTHOR,
		curseforgeLink = PER.LINK_CURSEFORGE,
		githubLink     = PER.LINK_GITHUB
	})

	Settings.RegisterAddOnCategory(category)

	PER.MAIN_CATEGORY_ID = category:GetID()
end

PER.modules.Options = Options
