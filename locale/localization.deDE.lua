local _, PER = ...

if GetLocale() ~= "deDE" then return end

local L = PER.localization

-- Options

L["options.general"] = "Allgemeine Einstellungen"
L["options.general.minimap-button.name"] = "Minimap Button"
L["options.general.minimap-button.tooltip"] = "Bei Aktivierung wird der Minimap Button angezeigt."

L["options.race-time-overview"] = "Rennzeitenübersicht"
L["options.race-time-overview.active.name"] = "Rennzeitenübersicht aktivieren"
L["options.race-time-overview.active.tooltip"] = "Aktiviert die Rennzeitenübersicht neben dem Questfenster."

L["options.race-tracker"] = "Race-Tracker"
L["options.race-tracker.active.name"] = "Race-Tracker aktivieren"
L["options.race-tracker.active.tooltip"] = "Aktiviert den Race-Tracker während eines Rennens."
L["options.race-tracker.mode.name"] = "Modus"
L["options.race-tracker.mode.tooltip"] = "Legt fest, wie die Zeit während eines Rennens angezeigt werden soll."
L["options.race-tracker.mode.value.0"] = "Timer"
L["options.race-tracker.mode.value.1"] = "Countdown - Medaillenzeit"
L["options.race-tracker.mode.value.2"] = "Countdown - persönliche Bestzeit"
L["options.race-tracker.background-type.name"] = "Hintergrund"
L["options.race-tracker.background-type.tooltip"] = "Legt fest, welcher Hintergrund für den Race-Tracker verwendet werden soll."
L["options.race-tracker.background-type.value.0"] = "Keiner"
L["options.race-tracker.background-type.value.1"] = "Percursus (Classic)"
L["options.race-tracker.background-type.value.2"] = "Allianz"
L["options.race-tracker.background-type.value.3"] = "Horde"
L["options.race-tracker.background-type.value.4"] = "Evergreen"
L["options.race-tracker.background-type.value.5"] = "Dragonflight"
L["options.race-tracker.background-type.value.6"] = "The War Within"
L["options.race-tracker.background-type.value.7"] = "Legion"
L["options.race-tracker.background-type.value.8"] = "N'Zoth"
L["options.race-tracker.background-type.value.9"] = "Midnight"
L["options.race-tracker.horizontal-shift.name"] = "Horizontale Verschiebung"
L["options.race-tracker.horizontal-shift.tooltip"] = "Gibt die relative horizontale Position des Race-Tracker zur Bildschirmmitte an."
L["options.race-tracker.vertical-shift.name"] = "Vertikale Verschiebung"
L["options.race-tracker.vertical-shift.tooltip"] = "Gibt die relative vertikale Position des Race-Tracker zur Bildschirmmitte an."
L["options.race-tracker.result-display.name"] = "Rennergebniss anzeigen"
L["options.race-tracker.result-display.tooltip"] = "Legt fest, ob nach dem Rennen der Race Tracker weiter angezeigt werden soll und damit das Rennergebniss präsentiert wird."
L["options.race-tracker.fadeout-delay.name"] = "Ausblendeverzögerung"
L["options.race-tracker.fadeout-delay.tooltip"] = "Bestimmt die Zeit nach einem Rennen, bis der Race-Tracker ausgeblendet wird."
L["options.race-tracker.hide-area-names.name"] = "Gebietsnamen ausblenden"
L["options.race-tracker.hide-area-names.tooltip"] = "Legt fest, ob während des Rennens keine Gebietsnamen angezeigt werden sollen."
L["options.race-tracker.speed-display.name"] = "Renngeschwindigkeit anzeigen"
L["options.race-tracker.speed-display.tooltip"] = "Legt fest, ob die Renngeschwindigkeit während des Rennens angezeigt werden soll. Diese Anzeige funktioniert nur bei Drachen- und Himmelsreiterrennen."
L["options.race-tracker.speed-display-horizontal-shift.name"] = "Horizontale Verschiebung"
L["options.race-tracker.speed-display-horizontal-shift.tooltip"] = "Gibt die relative horizontale Position der Renngeschwindigkeitsanzeige zur Bildschirmmitte an."
L["options.race-tracker.speed-display-vertical-shift.name"] = "Vertikale Verschiebung"
L["options.race-tracker.speed-display-vertical-shift.tooltip"] = "Gibt die relative vertikale Position der Renngeschwindigkeitsanzeige zur Bildschirmmitte an."

L["options.other"] = "Sonstige Einstellungen"
L["options.other.debug-mode.name"] = "Debugmodus"
L["options.other.debug-mode.tooltip"] = "Die Aktivierung des Debugmodus zeigt zusätzliche Informationen im Chat an."

L["options.about"] = "Über"
L["options.about.game-version"] = "Spielversion"
L["options.about.addon-version"] = "Addonversion"
L["options.about.lib-version"] = "Bibliotheksversion"
L["options.about.author"] = "Autor"

L["options.about.button-github.name"] = "Feedback & Hilfe"
L["options.about.button-github.tooltip"] = "Öffnet ein Popup-Fenster mit einem Link nach GitHub."
L["options.about.button-github.button"] = "GitHub"

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Rechtsklick|r zum Öffnen der Einstellungen."

-- Chat

-- Race Tracker

-- Race Time Overview

L["time"] = "Zeit: %.1f Sekunden"
L["gold-time"] = "|T616373:0|t Goldzeit: %s Sek."
L["silver-time"] = "|T616375:0|t Silberzeit: %s Sek."
L["bronze-time"] = "|T616372:0|t Bronzezeit"
L["no-time"] = "keine Medaillenzeit abrufbar"

L["gliding-speed"] = "aktuelle Renngeschwindigkeit: %s%%"

L["seconds-long"] = "Sekunden"
L["seconds-short"] = "Sek."

L["button.close"] = "Schließen"
L["button.zone-overview"] = "Zonenübersicht"

L["title.zone-overview"] = "Zonenübersicht"

L["race-normal"] = "Normal"
L["race-advanced"] = "Fortgeschritten"
L["race-reverse"] = "Umgekehrt"
L["race-challenge"] = "Herausforderung"
L["race-challenge-reverse"] = "Umgekehrte Herausforderung"
L["race-storm-gryphon"] = "Sturmgreif"

L["personal-best-time"] = "persönliche Bestzeit: %s Sek."
L["personal-best-time-no-race"] = "kein Rennen bisher absolviert"
L["personal-best-time-not-available"] = "persönliche Bestzeit nicht abrufbar"
L["personal-best-time-failed"] = "neue persönliche Bestzeit verfehlt"
