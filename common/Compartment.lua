local addonName, PER = ...

local L = PER.Localization

local AWL = ArcaneWizardLibrary
local Addon = AWL:GetAddon(addonName)

local handlers = Addon:CreateCompartmentHandlers({
	tooltip = L["minimap-button.tooltip"]
})

------------------------
--- Public Functions ---
------------------------

function Percursus_CompartmentOnEnter(self, button)
	handlers.OnEnter(self, button)
end

function Percursus_CompartmentOnLeave()
	handlers.OnLeave()
end

function Percursus_CompartmentOnClick(self, button)
	handlers.OnClick(self, button)
end
