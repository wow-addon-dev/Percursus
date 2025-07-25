local _, PER = ...

PER.localization = setmetatable({},{__index=function(self,key)
        geterrorhandler()("Percursus (Debug): Missing entry for '" .. tostring(key) .. "'")
        return key
    end})

local L = PER.localization

-- Generel

L["addon.version"] = "Version"

-- Addon specific

L["time"] = "Time: %.1f Seconds"
L["gold-time"] = "|T616373:0|t Gold Time: %s sec"
L["silver-time"] = "|T616375:0|t Silver Time: %s sec"
L["bronze-time"] = "|T616372:0|t Bronze Time"
L["no-time"] = "No Medal Time Available"

L["gliding-speed"] = "Current Racing Speed: %s%%"

L["seconds-long"] = "Seconds"
L["seconds-short"] = "sec"

L["button.close"] = "Close"
L["button.zone-overview"] = "Zone Overview"

L["title.zone-overview"] = "Zone Overview"

L["race-normal"] = "Normal"
L["race-advanced"] = "Advanced"
L["race-reverse"] = "Reverse"
L["race-challenge"] = "Challenge"
L["race-challenge-reverse"] = "Reverse Challenge"
L["race-storm-gryphon"] = "Storm Gryphon"

L["personal-best-time"] = "Personal Best Time: %s sec"
L["personal-best-time-no-race"] = "No Race Completed So Far"
L["personal-best-time-not-available"] = "Personal Best Time Not Available"
L["personal-best-time-failed"] = "New Personal Best Time Failed"

-- Options

L["info.description"] = "Description"
L["info.description.text"] = "Percursus is an addon that displays a live timer during a race and provides a detailed time overview of all completed races.\n\nThis addon is compatible with all race types such as dragonriding, skyriding, skyrocketing and breakneck (D.R.I.V.E.).\n\nIf you find a bug or have questions about the addon, you can contact me via GitHub. You can also help me with the translation via GitHub. Thank you."

L["info.help"] = "Help"
L["info.help.text"] = "In case of problems after an update or if you want to, you can reset the options here."
L["info.help.reset-button.name"] = "Reset Options"
L["info.help.reset-button.desc"] = "Resets the options to the default values. This applies to all characters."
L["info.help.github-button.name"] = "GitHub"
L["info.help.github-button.desc"] = "Opens a popup window with a link to GitHub."

L["info.about"] = "About"
L["info.about.text"] = "|cnGOLD_FONT_COLOR:Game Version:|r %s\n|cnGOLD_FONT_COLOR:Addon Version:|r %s\n\n|cnGOLD_FONT_COLOR:Author:|r %s"

L["options"] = "Options"
L["options.general"] = "General Options"

L["options.race-tracker"] = "Race Tracker"
L["options.race-tracker.name"] = "Enable Race Tracker"
L["options.race-tracker.tooltip"] = "Enables the Race Tracker during a race."
L["options.race-tracker-mode.name"] = "Mode"
L["options.race-tracker-mode.tooltip"] = "Defines how the time is to be displayed during a race."
L["options.race-tracker-mode.value.0"] = "Timer"
L["options.race-tracker-mode.value.1"] = "Countdown - Medal Time"
L["options.race-tracker-mode.value.2"] = "Countdown - Personal Best Time"
L["options.race-tracker-background-type.name"] = "Background"
L["options.race-tracker-background-type.tooltip"] = "Determines which background is to be used for the Race Tracker."
L["options.race-tracker-background-type.value.0"] = "None"
L["options.race-tracker-background-type.value.1"] = "Percursus (Classic)"
L["options.race-tracker-background-type.value.2"] = "Alliance"
L["options.race-tracker-background-type.value.3"] = "Horde"
L["options.race-tracker-background-type.value.4"] = "Evergreen"
L["options.race-tracker-background-type.value.5"] = "Dragonflight"
L["options.race-tracker-background-type.value.6"] = "The War Within"
L["options.race-tracker-background-type.value.7"] = "Legion"
L["options.race-tracker-background-type.value.8"] = "N'Zoth"
L["options.race-tracker-horizontal-shift.name"] = "Horizontal Shift"
L["options.race-tracker-horizontal-shift.tooltip"] = "Indicates the relative horizontal position of the Race Tracker to the centre of the screen."
L["options.race-tracker-vertical-shift.name"] = "Vertical Shift"
L["options.race-tracker-vertical-shift.tooltip"] = "Indicates the relative vertical position of the Race Tracker to the centre of the screen."
L["options.race-tracker-result-display.name"] = "Show Race Result"
L["options.race-tracker-result-display.tooltip"] = "Determines whether the race tracker should continue to be displayed after the race and thus the race result is presented."
L["options.race-tracker-fadeout-delay.name"] = "Fade-out Delay"
L["options.race-tracker-fadeout-delay.tooltip"] = "Determines the time after a race until the Race Tracker is hidden."
L["options.race-tracker-hide-area-names.name"] = "Hide Area Names"
L["options.race-tracker-hide-area-names.tooltip"] = "Determines whether no area names should be displayed during the race."
L["options.race-tracker-speed-display.name"] = "Show Race Speed"
L["options.race-tracker-speed-display.tooltip"] = "Determines whether the race speed should be displayed during the race. This display only works for dragon and skyrider races."
L["options.race-tracker-speed-display-horizontal-shift.name"] = "Horizontal Shift"
L["options.race-tracker-speed-display-horizontal-shift.tooltip"] = "Indicates the relative horizontal position of the race speed display to the centre of the screen."
L["options.race-tracker-speed-display-vertical-shift.name"] = "Vertical Shift"
L["options.race-tracker-speed-display-vertical-shift.tooltip"] = "Indicates the relative vertical position of the race speed display to the centre of the screen."

L["options.race-time-overview"] = "Race Time Overview"
L["options.race-time-overview.name"] = "Enable Race Time Overview"
L["options.race-time-overview.tooltip"] = "Enables the Race Time Overview next to the quest window."

L["options.other"] = "Other Options"
L["options.debug-mode.name"] = "Debug Mode"
L["options.debug-mode.tooltip"] = "Enabling the debug mode displays additional information in the chat."

-- Chat

L["chat.reset-options.success"] = "Options successfully reseted."

-- Dialog

L["dialog.copy-address.text"] = "To copy the link press CTRL + C."
L["dialog.reset-options.text"] = "Do you really want to reset the options?\n|cnNORMAL_FONT_COLOR:Warning:|r The game interface will be automatically reloaded!"
