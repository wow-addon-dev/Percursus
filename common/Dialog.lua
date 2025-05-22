local _, SRT = ...

local L =  SRT.localization
local Utils = SRT.utils

local Dialog = {}

--------------
--- Frames ---
--------------

local copyAddressDialog
local resetOptionsDialog

---------------------
--- Main Funtions ---
---------------------

function Dialog:InitializeDialog()
    copyAddressDialog = CreateFrame("Frame", "SRT_CopyAddressDialog", UIParent, "TranslucentFrameTemplate")
    copyAddressDialog:SetSize(400, 10)
    copyAddressDialog:SetPoint("CENTER", 0, 200)

    copyAddressDialog:SetFrameStrata("DIALOG")
    copyAddressDialog:SetFrameLevel(1000)
    copyAddressDialog:SetClampedToScreen(true)

    tinsert(UISpecialFrames, copyAddressDialog:GetName())
    copyAddressDialog:Hide()

    local text = copyAddressDialog:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("TOPLEFT", copyAddressDialog, "TOPLEFT", 20, -20)
    text:SetPoint("TOPRIGHT", copyAddressDialog, "TOPRIGHT",  -20, -20)
    text:SetJustifyH("CENTER")
    text:SetWordWrap(true)
    text:SetText(L["dialog.copy-address.text"])

    local editBox = CreateFrame("EditBox", nil, copyAddressDialog, "InputBoxTemplate")
    editBox:SetPoint("TOP", text, "BOTTOM", 0, -10)
    editBox:SetSize(340, 20)
    editBox:SetAutoFocus(false)
    editBox:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)
    copyAddressDialog.editBox = editBox

    local buttonClose = CreateFrame("Button", nil, copyAddressDialog, "UIPanelButtonTemplate")
    buttonClose:SetSize(100, 22)
    buttonClose:SetPoint("TOP", editBox, "BOTTOM", 0, -10)
    buttonClose:SetText(CLOSE)
    buttonClose:SetScript("OnClick", function()
        copyAddressDialog:Hide()
    end)

    copyAddressDialog:SetHeight(copyAddressDialog:GetTop() - buttonClose:GetBottom() + 20)

    resetOptionsDialog = CreateFrame("Frame", "SRT_ResetOptionsDialog", UIParent, "TranslucentFrameTemplate")
    resetOptionsDialog:SetSize(350, 10)
    resetOptionsDialog:SetPoint("CENTER", 0, 200)

    resetOptionsDialog:SetFrameStrata("DIALOG")
    resetOptionsDialog:SetFrameLevel(1000)
    resetOptionsDialog:SetClampedToScreen(true)

    tinsert(UISpecialFrames, resetOptionsDialog:GetName())

    resetOptionsDialog:Hide()

    local text = resetOptionsDialog:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    text:SetPoint("TOPLEFT", resetOptionsDialog, "TOPLEFT", 20, -20)
    text:SetPoint("TOPRIGHT", resetOptionsDialog, "TOPRIGHT",  -20, -20)
    text:SetWordWrap(true)
    text:SetJustifyH("CENTER")
    text:SetText(L["dialog.reset-options.text"])

    local buttonYes = CreateFrame("Button", nil, resetOptionsDialog, "UIPanelButtonTemplate")
    buttonYes:SetPoint("TOP", text, "BOTTOM", -75, -10)
    buttonYes:SetSize(100, 22)
    buttonYes:SetText(YES)
    buttonYes:SetScript("OnClick", function()
        local options = SRT.data.options
        options["race-tracker"] = true
        options["race-tracker-mode"] = 0
        options["race-tracker-gliding-speed"] = false
        options["race-tracker-background"] = true
        options["race-tracker-background-type"] = 0
        options["race-tracker-horizontal-shift"] = 0
        options["race-tracker-vertical-shift"] = 200
        options["race-tracker-fadeout-delay"] = 3
        options["race-time-overview"] = true
        options["debug-mode"] = false

        Utils:PrintMessage(L["chat.reset-options.success"])
        resetOptionsDialog:Hide()
    end)

    local buttonNo = CreateFrame("Button", nil, resetOptionsDialog, "UIPanelButtonTemplate")
    buttonNo:SetPoint("TOP", text, "BOTTOM", 75, -10)
    buttonNo:SetSize(100, 22)
    buttonNo:SetText(CANCEL)
    buttonNo:SetScript("OnClick", function()
        resetOptionsDialog:Hide()
    end)

    resetOptionsDialog:SetHeight(resetOptionsDialog:GetTop() - buttonNo:GetBottom() + 20)
end

function Dialog:ShowCopyAddressDialog(address)
    if (not copyAddressDialog:IsShown()) and (not resetOptionsDialog:IsShown()) then
        copyAddressDialog.editBox:SetText(address)
        copyAddressDialog.editBox:HighlightText()
        copyAddressDialog:Show()
    end
end

function Dialog:ShowResetOptionsDialog()
    if (not copyAddressDialog:IsShown()) and (not resetOptionsDialog:IsShown()) then
        resetOptionsDialog:Show()
    end
end

SRT.dialog = Dialog