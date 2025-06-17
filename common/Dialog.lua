local _, PER = ...

local L =  PER.localization

local Dialog = {}

--------------
--- Frames ---
--------------

local copyAddressDialog
local resetOptionsDialog

---------------------
--- Main Funtions ---
---------------------

function Dialog:Initialize()
    copyAddressDialog = CreateFrame("Frame", "PercursusCopyAdressDialog", UIParent, "PercursusCopyAdressDialogTemplate")
	resetOptionsDialog = CreateFrame("Frame", "PercursusResetOptionsDialog", UIParent, "PercursusResetOptionsDialogTemplate")
end

function Dialog:ShowCopyAddressDialog(address)
    if (not copyAddressDialog:IsShown()) and (not resetOptionsDialog:IsShown()) then
        copyAddressDialog:ShowDialog(address)
    end
end

function Dialog:ShowResetOptionsDialog()
    if (not copyAddressDialog:IsShown()) and (not resetOptionsDialog:IsShown()) then
        resetOptionsDialog:ShowDialog()
    end
end

PER.dialog = Dialog
