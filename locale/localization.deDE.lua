local _, PER = ...

if GetLocale() ~= "deDE" then return end

local L = PER.localization

-- Generel

L["addon.version"] = "Version"

-- Addon specific

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

-- Options

L["info.description"] = "Beschreibung"
L["info.description.text"] = "Percursus ist ein Addon, das während eines Rennens einen Live-Timer anzeigt und einen detaillierten Zeitüberblick über alle absolvierten Rennen bietet.\n\nDieses Addon ist mit allen Renntypen wie Drachen-, Himmelsreiter-, Raketen- und Halsbrecherrennen (F.A.H.R.E.N.) kompatibel.\n\nSolltest Du einen Fehler finden oder Fragen zum Addon haben, so kannst Du über GitHub Kontakt aufnehmen. Über GitHub kannst Du mir auch bei der Übersetzung helfen. Vielen Dank."

L["info.help"] = "Hilfe"
L["info.help.text"] = "Bei Problemen nach einem Update oder wenn Du es möchtest, kannst Du hier die Einstellungen zurücksetzen."
L["info.help.reset-button.name"] = "Einstellungen zurücksetzen"
L["info.help.reset-button.desc"] = "Setzt die Einstellungen auf die Standardwerte zurück. Dies gilt für alle Charaktere."
L["info.help.github-button.name"] = "GitHub"
L["info.help.github-button.desc"] = "Öffnet ein Popup-Fenster mit einem Link nach GitHub."

L["info.about"] = "Über"
L["info.about.text"] = "|cffF2E699Spielversion:|r %s\n|cffF2E699Addonversion:|r %s\n\n|cffF2E699Autor:|r %s"

L["options"] = "Einstellungen"
L["options.general"] = "allgemeine Einstellungen"

L["options.race-tracker"] = "Race-Tracker"
L["options.race-tracker.name"] = "Race-Tracker aktivieren"
L["options.race-tracker.tooltip"] = "Aktiviert den Race-Tracker während eines Rennens."
L["options.race-tracker-mode.name"] = "Modus"
L["options.race-tracker-mode.tooltip"] = "Legt fest, wie die Zeit während eines Rennens angezeigt werden soll."
L["options.race-tracker-mode.value.0"] = "Timer"
L["options.race-tracker-mode.value.1"] = "Countdown - Medaillenzeit"
L["options.race-tracker-mode.value.2"] = "Countdown - persönliche Bestzeit"
L["options.race-tracker-background.name"] = "Hintergrund"
L["options.race-tracker-background.tooltip"] = "Legt fest, welcher Hintergrund für den Race-Tracker verwendet werden soll."
L["options.race-tracker-background.value.0"] = "Keiner"
L["options.race-tracker-background.value.1"] = "Percursus (Classic)"
L["options.race-tracker-background.value.2"] = "Allianz"
L["options.race-tracker-background.value.3"] = "Horde"
L["options.race-tracker-horizontal-shift.name"] = "Horizontale Verschiebung"
L["options.race-tracker-horizontal-shift.tooltip"] = "Gibt die relative horizontale Position des Race-Tracker zur Bildschirmmitte an."
L["options.race-tracker-vertical-shift.name"] = "Vertikale Verschiebung"
L["options.race-tracker-vertical-shift.tooltip"] = "Gibt die relative vertikale Position des Race-Tracker zur Bildschirmmitte an."
L["options.race-tracker-fadeout-delay.name"] = "Ausblendeverzögerung"
L["options.race-tracker-fadeout-delay.tooltip"] = "Bestimmt die Zeit nach einem Rennen, bis der Race-Tracker ausgeblendet wird."
L["options.race-tracker-speed-display.name"] = "Renngeschwindigkeit anzeigen"
L["options.race-tracker-speed-display.tooltip"] = "Legt fest, ob die Renngeschwindigkeit während des Rennens angezeigt werden soll. Diese Anzeige funktioniert nur bei Drachen- und Himmelsreiterrennen."
L["options.race-tracker-speed-display-horizontal-shift.name"] = "Horizontale Verschiebung"
L["options.race-tracker-speed-display-horizontal-shift.tooltip"] = "Gibt die relative horizontale Position der Renngeschwindigkeitsanzeige zur Bildschirmmitte an."
L["options.race-tracker-speed-display-vertical-shift.name"] = "Vertikale Verschiebung"
L["options.race-tracker-speed-display-vertical-shift.tooltip"] = "Gibt die relative vertikale Position der Renngeschwindigkeitsanzeige zur Bildschirmmitte an."

L["options.race-time-overview"] = "Rennzeitenübersicht"
L["options.race-time-overview.name"] = "Rennzeitenübersicht aktivieren"
L["options.race-time-overview.tooltip"] = "Aktiviert die Rennzeitenübersicht neben dem Questfenster."

L["options.other"] = "sonstige Einstellungen"
L["options.debug-mode.name"] = "Debugmodus"
L["options.debug-mode.tooltip"] = "Die Aktivierung des Debugmodus zeigt zusätzliche Informationen im Chat an."

-- Chat

L["chat.reset-options.success"] = "Einstellungen erfolgreich zurückgesetzt."

-- Dialog

L["dialog.copy-address.text"] = "Um den Link zu kopieren drücke STRG + C."
L["dialog.reset-options.text"] = "Sollen die Einstellungen wirklich zurückgesetzt werden?"
