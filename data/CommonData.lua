local _, PER = ...

PER.DIFFICULTY_ORDER = {"NORMAL", "ADVANCED", "REVERSE", "CHALLENGE", "CHALLENGE_REVERSE", "STORM_GRYPHON"}

--------------------
--- Data sorting ---
--------------------

local raceDataTable = PER.RACE_DATA
PER.SORTED_RACE_DATA = {}
local sortedRaceDataTable = PER.SORTED_RACE_DATA

for raceID, dataWrapper in pairs(raceDataTable) do
    local order, zoneID, modes = unpack(dataWrapper)
    table.insert(sortedRaceDataTable, {raceID = raceID, order = order, zoneID = zoneID, modes = modes})
end

table.sort(sortedRaceDataTable, function(a, b) return a.order < b.order end)
