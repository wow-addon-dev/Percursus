local addonName, PER = ...

local L = PER.localization

local Utils = {}

---------------------
--- Main Funtions ---
---------------------

function Utils:PrintDebug(msg)
    if PER.options.other["debug-mode"] then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
	end
end

function Utils:PrintMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
end

function Utils:InitializeDatabase()
    if (not Percursus_Options_v2) then
        Percursus_Options_v2 = {
			["general"] = {
				["minimap-button"] = {
					["hide"] = false
				}
			},
			["race-time-overview"] = {},
			["race-tracker"] = {},
			["other"] = {}
		}
    end

    PER.options = {}
	PER.options.general = Percursus_Options_v2["general"]
	PER.options.raceTracker = Percursus_Options_v2["race-tracker"]
	PER.options.raceTimeOverview = Percursus_Options_v2["race-time-overview"]
	PER.options.other = Percursus_Options_v2["other"]
end

function Utils:InitializeMinimapButton()
    local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Percursus", {
        type     = "launcher",
        text     = "Percursus",
        icon     = PER.MEDIA_PATH .. "icon-round.blp",
        OnClick  = function(self, button)
			if button == "RightButton" then
                Settings.OpenToCategory(PER.MAIN_CATEGORY_ID)
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
    self.minimapButton:Register("Percursus", LDB, PER.options.general["minimap-button"])
end


PER.utils = Utils
