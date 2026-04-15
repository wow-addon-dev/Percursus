local addonName, PER = ...

PER.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
PER.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
PER.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")

PER.GAME_VERSION = GetBuildInfo()

PER.LINK_GITHUB = C_AddOns.GetAddOnMetadata(addonName, "X-Github")
PER.LINK_CURSEFORGE = C_AddOns.GetAddOnMetadata(addonName, "X-Curseforge")
PER.LINK_WAGO = C_AddOns.GetAddOnMetadata(addonName, "X-Wago")

PER.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\assets\\"

PER.GAME_TYPE_VANILLA = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
PER.GAME_TYPE_TBC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
---@diagnostic disable-next-line: undefined-global
PER.GAME_TYPE_MISTS = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)
PER.GAME_TYPE_MAINLINE = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

PER.GAME_FLAVOR = "unknown"

if PER.GAME_TYPE_VANILLA then
	PER.GAME_FLAVOR = "Classic"
elseif PER.GAME_TYPE_TBC then
	PER.GAME_FLAVOR = "Burning Crusade - Classic Anniversary Edition"
elseif PER.GAME_TYPE_MISTS then
	PER.GAME_FLAVOR = "Mist of Pandaria - Classic"
elseif PER.GAME_TYPE_MAINLINE then
	PER.GAME_FLAVOR = "Retail"
end

PER.COLOR_SILVER = "ffC0C0C0"
PER.COLOR_BRONZE = "ffCD7F32"
