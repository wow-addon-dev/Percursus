local _, PER = ...

local L =  PER.localization

local Dialog = {}
local DialogLib = LibStub("WAD-LibShared-Dialogs", true)

---------------------
--- Main Funtions ---
---------------------

function Dialog:ShowCopyAddressDialog(address)
	DialogLib:ShowCopyAddressDialog(address, L["dialog.copy-address.text"])
end

function Dialog:ShowDeleteDataDialog()
    local function ResetLogic()
        ReloadUI()
    end

    DialogLib:ShowDeleteDataDialog(L["dialog.delete-data.text"], ResetLogic)
end

PER.dialog = Dialog
