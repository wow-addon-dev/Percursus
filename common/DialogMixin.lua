local _, PER = ...

local L = PER.localization

PercursusCopyAdressDialogMixin = {}

function PercursusCopyAdressDialogMixin:OnLoad()
    self.Text:SetText(L["dialog.copy-address.text"])
	self:SetHeight(self:GetTop() - self.CloseButton:GetBottom() + 20)

    tinsert(UISpecialFrames, self:GetName())
end

function PercursusCopyAdressDialogMixin:ShowDialog(address)
    self.EditBox:SetText(address)
	self.EditBox:HighlightText()
    self:Show()
end

PercursusResetOptionsDialogMixin = {}

function PercursusResetOptionsDialogMixin:OnLoad()
	self.Text:SetText(L["dialog.reset-options.text"])
	self:SetHeight(self:GetTop() - self.NoButton:GetBottom() + 20)

    tinsert(UISpecialFrames, self:GetName())
end

function PercursusResetOptionsDialogMixin:ShowDialog()
    self:Show()
end
