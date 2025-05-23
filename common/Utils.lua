local addonName, PER = ...

local L = PER.localization

local Utils = {}

-----------------------
--- Helper Funtions ---
-----------------------

function Utils:HexToRGB(hex)
    hex = hex:gsub("^#","")
    hex = hex:gsub("^ff","")

    local r = tonumber(hex:sub(1,2), 16) / 255
    local g = tonumber(hex:sub(3,4), 16) / 255
    local b = tonumber(hex:sub(5,6), 16) / 255

    return r, g, b
end

function Utils:RGBToHex(r, g, b)
    r = math.min(math.max(r,0),1)
    g = math.min(math.max(g,0),1)
    b = math.min(math.max(b,0),1)

    return string.format("ff%02X%02X%02X", r * 255, g * 255, b * 255)
end

---------------------
--- Main Funtions ---
---------------------

function Utils:PrintDebug(msg)
    if PER.data.options["debug-mode"] then
        local notfound = true

        for i = 1, NUM_CHAT_WINDOWS do
            local name, _, _, _, _, _, shown, locked, docked, uni = GetChatWindowInfo(i)

            if name == "Debug" and docked ~= nil then
                _G['ChatFrame' .. i]:AddMessage(WrapTextInColorCode("Skyriding Race Tracker (Debug): ", PER.ORANGE_FONT_COLOR) .. msg)
                notfound = false
                break
            end
        end

        if notfound then
            DEFAULT_CHAT_FRAME:AddMessage(WrapTextInColorCode("Skyriding Race Tracker (Debug): ", PER.ORANGE_FONT_COLOR)  .. msg)
        end
	end
end

function Utils:PrintMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(WrapTextInColorCode(addonName .. ": ", PER.NORMAL_FONT_COLOR) .. msg)
end

function Utils:InitializeDatabase()
    -- Options
    if (not SkyridingRaceTracker_Options_v2) then
        SkyridingRaceTracker_Options_v2 = {}
    end

    PER.data = {}
    PER.data.options = SkyridingRaceTracker_Options_v2
end

PER.utils = Utils
