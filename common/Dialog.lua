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
    copyAddressDialog = CreateFrame("Frame", "Percursus_CopyAdressDialog", UIParent, "Percursus_CopyAdressDialogTemplate")
	resetOptionsDialog = CreateFrame("Frame", "Percursus_ResetOptionsDialog", UIParent, "Percursus_ResetOptionsDialogTemplate")
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
