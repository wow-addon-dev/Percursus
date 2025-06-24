local addonName, PER = ...

PER.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
PER.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
PER.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")

PER.GAME_VERSION = GetBuildInfo()
PER.GAME_FLAVOR = C_AddOns.GetAddOnMetadata(addonName, "X-Flavor")

PER.LINK_GITHUB = C_AddOns.GetAddOnMetadata(addonName, "X-Github")
PER.LINK_CURSEFORGE = C_AddOns.GetAddOnMetadata(addonName, "X-Curseforge")
PER.LINK_WAGO = C_AddOns.GetAddOnMetadata(addonName, "X-Wago")

PER.COLOR_SILVER = "ffC0C0C0"
PER.COLOR_BRONZE = "ffCD7F32"

PER.MEDIA_PATH = "Interface\\AddOns\\" .. addonName .. "\\media\\"
