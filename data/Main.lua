local addonName, SRT = ...

SRT.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
SRT.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
SRT.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")

SRT.GAME_VERSION = GetBuildInfo()
SRT.GAME_FLAVOR = C_AddOns.GetAddOnMetadata(addonName, "X-Flavor")

SRT.LINK_GITHUB = C_AddOns.GetAddOnMetadata(addonName, "X-Github")
SRT.LINK_CURSEFORGE = C_AddOns.GetAddOnMetadata(addonName, "X-Curseforge")

SRT.NORMAL_FONT_COLOR = "ffFFD200"      -- #1
SRT.WHITE_FONT_COLOR = "ffFFFFFF"       -- #2
SRT.ORANGE_FONT_COLOR = "ffFF8040"      -- 13
SRT.GOLD_FONT_COLOR = "ffF2E699"        -- #22
SRT.LINK_FONT_COLOR = "ff66BBFF"        -- #36

SRT.COLOR_SILVER = "ffC0C0C0"
SRT.COLOR_BRONZE = "ffCD7F32"

SRT.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\media\\"

SRT.DIFFICULTY_ORDER = {"NORMAL", "ADVANCED", "REVERSE", "CHALLENGE", "CHALLENGE_REVERSE", "STORM_GRYPHON"}

--------------------
--- Data sorting ---
--------------------

local raceDataTable = SRT.RACE_DATA
SRT.SORTED_RACE_DATA = {}
local sortedRaceDataTable = SRT.SORTED_RACE_DATA

for raceID, dataWrapper in pairs(raceDataTable) do
    local order, zoneID, modes = unpack(dataWrapper)
    table.insert(sortedRaceDataTable, {raceID = raceID, order = order, zoneID = zoneID, modes = modes})
end

table.sort(sortedRaceDataTable, function(a, b) return a.order < b.order end)
