local addonName, PER = ...

-- Library
local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

-- Localization
local L = PER.Localization

-- Current module
local Utils = PER.Modules.Utils

------------------------
--- Module Functions ---
------------------------

function Utils:PrintMessage(msg)
	Addon:PrintMessage(msg)
end

function Utils:IsAccountProfile()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	return Percursus_Options_v3.profileKeys[characterRealmKey]["use-account"]
end

function Utils:OpenSettingsOnLoading()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	if Percursus_Options_v3.profileKeys[characterRealmKey]["open-settings"] then
		Addon:OpenCategory()

		Percursus_Options_v3.profileKeys[characterRealmKey]["open-settings"] = false
	end
end

function Utils:ToggleProfileMode()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()
	local useAccountProfile = self:IsAccountProfile()

	Percursus_Options_v3.profileKeys[characterRealmKey]["use-account"] = not useAccountProfile
	Percursus_Options_v3.profileKeys[characterRealmKey]["open-settings"] = true
end

function Utils:ResetAllCharacterProfiles()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	Percursus_Options_v3.profiles = {}
	Percursus_Options_v3.profileKeys = {}

	Percursus_Options_v3.profileKeys[characterRealmKey] = {
		["use-account"] = true,
		["open-settings"] = true
	}
end

function Utils:InitializeDatabase()
	local characterRealmKey = AWL.Utils:GetCharacterRealmKey()

	local createdProfile = false
	local createdProfileKey = false

	local defaults = {
		["general"] = {
			["minimap-button"] = {
				["hide"] = false
			}
		},
		["race-time-overview"] = {},
		["race-tracker"] = {}
	}

	if not Percursus_Options_v3 then
		Percursus_Options_v3 = {
			["account"] = AWL.Utils:CopyTable(defaults),
			["profiles"] = {},
			["profileKeys"] = {}
		}
	end

	if not Percursus_Options_v3.profiles[characterRealmKey] then
		Percursus_Options_v3.profiles[characterRealmKey] = AWL.Utils:CopyTable(defaults)
		createdProfile = true
	end

	if not Percursus_Options_v3.profileKeys[characterRealmKey] then
		Percursus_Options_v3.profileKeys[characterRealmKey] = {
			["use-account"] = true,
			["open-settings"] = false
		}
		createdProfileKey = true
	end

	local useAccountProfile = Percursus_Options_v3.profileKeys[characterRealmKey]["use-account"]

	if useAccountProfile then
		PER.Settings.general = Percursus_Options_v3.account["general"]
		PER.Settings.raceTimeOverview = Percursus_Options_v3.account["race-time-overview"]
		PER.Settings.raceTracker = Percursus_Options_v3.account["race-tracker"]
	else
		PER.Settings.general = Percursus_Options_v3.profiles[characterRealmKey]["general"]
		PER.Settings.raceTimeOverview = Percursus_Options_v3.profiles[characterRealmKey]["race-time-overview"]
		PER.Settings.raceTracker = Percursus_Options_v3.profiles[characterRealmKey]["race-tracker"]
	end

	return {
		characterRealmKey = characterRealmKey,
		createdProfile = createdProfile,
		createdProfileKey = createdProfileKey,
		activeProfile = useAccountProfile and "account" or "character"
	}
end

function Utils:InitializeMinimapButton()
	self.minimapButton = Addon:RegisterMinimapButton({
		db = PER.Settings.general["minimap-button"],
		tooltip = L["minimap-button.tooltip"]
	})
end
