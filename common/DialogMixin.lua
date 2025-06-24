local _, PER = ...

local L = PER.localization

Percursus_CopyAdressDialogMixin = {}

function Percursus_CopyAdressDialogMixin:OnLoad()
    self.Text:SetText(L["dialog.copy-address.text"])
	self:SetHeight(self:GetTop() - self.CloseButton:GetBottom() + 20)

    tinsert(UISpecialFrames, self:GetName())
end

function Percursus_CopyAdressDialogMixin:ShowDialog(address)
    self.EditBox:SetText(address)
	self.EditBox:HighlightText()
    self:Show()
end

Percursus_ResetOptionsDialogMixin = {}

function Percursus_ResetOptionsDialogMixin:OnLoad()
	self.Text:SetText(L["dialog.reset-options.text"])
	self:SetHeight(self:GetTop() - self.NoButton:GetBottom() + 20)

    tinsert(UISpecialFrames, self:GetName())
end

function Percursus_ResetOptionsDialogMixin:ShowDialog()
    self:Show()
end
