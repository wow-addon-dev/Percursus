local addonName, PER = ...

local L = PER.localization

---------------------
--- Main Funtions ---
---------------------

function Percursus_CompartmentOnEnter(self, button)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetOwner(button, "ANCHOR_LEFT")

	GameTooltip_SetTitle(GameTooltip, addonName)
	GameTooltip_AddNormalLine(GameTooltip, PER.ADDON_VERSION .. " (" .. PER.ADDON_BUILD_DATE .. ")")
	GameTooltip_AddBlankLineToTooltip(GameTooltip)
	GameTooltip_AddHighlightLine(GameTooltip, L["minimap-button.tooltip"])

	GameTooltip:Show()
end

function Percursus_CompartmentOnLeave()
    GameTooltip:Hide()
end

function Percursus_CompartmentOnClick(_, button)
    if button == "RightButton" then
        Settings.OpenToCategory(PER.MAIN_CATEGORY_ID)
    end
end
