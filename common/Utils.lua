local addonName, PER = ...

local L = PER.localization

local Utils = {}

-----------------------
--- Helper Funtions ---
-----------------------

---------------------
--- Main Funtions ---
---------------------

function Utils:PrintDebug(msg)
    if PER.data.options["debug-mode"] then
        local notfound = true

        for i = 1, NUM_CHAT_WINDOWS do
            local name, _, _, _, _, _, shown, locked, docked, uni = GetChatWindowInfo(i)

            if name == "Debug" and docked ~= nil then
                _G['ChatFrame' .. i]:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
                notfound = false
                break
            end
        end

        if notfound then
            DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
        end
	end
end

function Utils:PrintMessage(msg)
    DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addonName .. ": ") .. msg)
end

function Utils:InitializeDatabase()
    -- Options
    if (not Percursus_Options) then
        Percursus_Options = {}
    end

    PER.data = {}
    PER.data.options = Percursus_Options
end

PER.utils = Utils
