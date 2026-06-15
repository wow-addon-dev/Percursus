local addonName, PER = ...

PER.Settings = PER.Settings or {}
PER.Data = PER.Data or {}
PER.State = PER.State or {}
PER.Modules = PER.Modules or {}

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return PER.Settings.general and PER.Settings.general["debug-mode"]
	end
})
