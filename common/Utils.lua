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
        DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addonName .. " (Debug): ")  .. msg)
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
