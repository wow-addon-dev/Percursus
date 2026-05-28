local addonName, PER = ...

local L = PER.Localization

local AWL = ArcaneWizardLibrary

local Utils = {}

-----------------------
--- Local Functions ---
-----------------------

local function CopyTable(source)
	local target = {}

	for key, value in pairs(source) do
		if type(value) == "table" then
			target[key] = CopyTable(value)
		else
			target[key] = value
		end
	end

	return target
end

local function GetCharacterRealmKey()
	return AWL.Utils:GetCharacterRealmKey()
end

------------------------
--- Public Functions ---
------------------------

function Utils:PrintDebug(msg)
	local debugMode = PER.settings and PER.settings.general	and PER.settings.general["debug-mode"]

	if debugMode ~= false then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
	end
end

function Utils:PrintMessage(msg)
	DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
end

function Utils:IsAccountProfile()
	local characterRealmKey = GetCharacterRealmKey()

	return Percursus_Options_v3.profileKeys[characterRealmKey]["use-account"]
end

function Utils:OpenSettingsOnLoading()
	local characterRealmKey = GetCharacterRealmKey()

	if Percursus_Options_v3.profileKeys[characterRealmKey]["open-settings"] then
		Settings.OpenToCategory(PER.MAIN_CATEGORY_ID)

		Percursus_Options_v3.profileKeys[characterRealmKey]["open-settings"] = false
	end
end

function Utils:ToggleProfileMode()
	local characterRealmKey = GetCharacterRealmKey()
	local useAccountProfile = self:IsAccountProfile()

	Percursus_Options_v3.profileKeys[characterRealmKey]["use-account"] = not useAccountProfile
	Percursus_Options_v3.profileKeys[characterRealmKey]["open-settings"] = true
end

function Utils:ResetAllCharacterProfiles()
	local characterRealmKey = GetCharacterRealmKey()

	Percursus_Options_v3.profiles = {}
	Percursus_Options_v3.profileKeys = {}

	Percursus_Options_v3.profileKeys[characterRealmKey] = {
		["use-account"] = true,
		["open-settings"] = true
	}
end

function Utils:InitializeDatabase()
	local characterRealmKey = GetCharacterRealmKey()

	local hadDb = Percursus_Options_v3 ~= nil
	local createdDb = false
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
			["account"] = CopyTable(defaults),
			["profiles"] = {},
			["profileKeys"] = {}
		}
		createdDb = true
	end

	if not Percursus_Options_v3.profiles[characterRealmKey] then
		Percursus_Options_v3.profiles[characterRealmKey] = CopyTable(defaults)
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
		PER.settings.general = Percursus_Options_v3.account["general"]
		PER.settings.raceTimeOverview = Percursus_Options_v3.account["race-time-overview"]
		PER.settings.raceTracker = Percursus_Options_v3.account["race-tracker"]
	else
		PER.settings.general = Percursus_Options_v3.profiles[characterRealmKey]["general"]
		PER.settings.raceTimeOverview = Percursus_Options_v3.profiles[characterRealmKey]["race-time-overview"]
		PER.settings.raceTracker = Percursus_Options_v3.profiles[characterRealmKey]["race-tracker"]
	end

	self:PrintDebug(string.format(
		"InitializeDatabase: key=%s, hadDb=%s, createdDb=%s, createdProfile=%s, createdProfileKey=%s, activeProfile=%s",
		characterRealmKey, tostring(hadDb), tostring(createdDb), tostring(createdProfile), tostring(createdProfileKey), useAccountProfile and "account" or "character"
	))
end

function Utils:InitializeMinimapButton()
	local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Percursus", {
		type     = "launcher",
		text     = "Percursus",
		icon     = PER.MEDIA_PATH .. "icon-round.blp",
		OnClick  = function(self, button)
			if button == "RightButton" then
				if not InCombatLockdown() then
					Settings.OpenToCategory(PER.MAIN_CATEGORY_ID)
				else
					Utils:PrintDebug("In combat. The options menu cannot be opened.")
				end
			end
		end,
		OnTooltipShow = function(tooltip)
			GameTooltip_SetTitle(tooltip, addonName)
			GameTooltip_AddNormalLine(tooltip, PER.ADDON_VERSION .. " (" .. PER.ADDON_BUILD_DATE .. ")")
			GameTooltip_AddBlankLineToTooltip(tooltip)
			GameTooltip_AddHighlightLine(tooltip, L["minimap-button.tooltip"])
		end,
	})

	self.minimapButton = LibStub("LibDBIcon-1.0")
	self.minimapButton:Register("Percursus", LDB, PER.settings.general["minimap-button"])
end

PER.modules.Utils = Utils
