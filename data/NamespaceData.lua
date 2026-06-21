local addonName, PER = ...

PER.Settings = PER.Settings or {}
PER.Data = PER.Data or {}
PER.State = PER.State or {}
PER.Modules = PER.Modules or {}

PER.Modules.Options = PER.Modules.Options or {}
PER.Modules.RaceTimeOverview = PER.Modules.RaceTimeOverview or {}
PER.Modules.RaceTracker = PER.Modules.RaceTracker or {}
PER.Modules.Utils = PER.Modules.Utils or {}

local AWL = ArcaneWizardLibrary

AWL:NewAddon(addonName, {
	debugEnabled = function()
		return PER.Settings.general and PER.Settings.general["debug-mode"]
	end
})
