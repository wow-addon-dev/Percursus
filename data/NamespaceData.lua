local addonName, PER = ...

PER.settings = PER.settings or {}
PER.data = PER.data or {}
PER.state = PER.state or {}
PER.modules = PER.modules or {}

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return PER.settings.general and PER.settings.general["debug-mode"]
	end
})
