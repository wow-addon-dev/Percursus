local _, PER = ...

PercursusRaceTrackerMixin = {}

function PercursusRaceTrackerMixin:SetTimerText(text)
	self.Timer:SetText(text)
end

function PercursusRaceTrackerMixin:SetInfoText(text)
	self.Info:SetText(text)
end

function PercursusRaceTrackerMixin:GetTimerText()
	return self.Timer:GetText()
end

function PercursusRaceTrackerMixin:GetInfoText()
	return self.Info:GetText()
end

function PercursusRaceTrackerMixin:SetBackground(style)
	self:SetSize(style.width, style.height)

	if style.type == "file" then
		self.Background:SetTexture(PER.MEDIA_PATH .. style.texture)
	elseif style.type == "atlas" then
		self.Background:SetAtlas(style.texture)
	end

	self.Timer:ClearAllPoints()
	self.Info:ClearAllPoints()

	self.Timer:SetPoint("CENTER", 0, style.offsetY.timer)
	self.Info:SetPoint("CENTER", 0, style.offsetY.info)

	self.Background:Show()
end

function PercursusRaceTrackerMixin:RemoveBackground()
	self:SetSize(256, 64)

	self.Timer:ClearAllPoints()
	self.Info:ClearAllPoints()

	self.Timer:SetPoint("CENTER", 0, 10)
	self.Info:SetPoint("CENTER", 0, -10)

	self.Background:Hide()
end

function PercursusRaceTrackerMixin:ShowFrame()
	self:Show()
end

function PercursusRaceTrackerMixin:HideFrame()
	self:Hide()
end

PercursusRaceTrackerSpeedDisplayMixin = {}

function PercursusRaceTrackerSpeedDisplayMixin:SetSpeedBar(speed)
	if speed == 0 then
		self.SpeedBar:SetSize(1, 18)
		self.SpeedBar:Hide()
	else
		self.SpeedBar:SetSize(speed, 18)
		self.SpeedBar:Show()
	end
end

function PercursusRaceTrackerSpeedDisplayMixin:ShowFrame()
	self:Show()
end

function PercursusRaceTrackerSpeedDisplayMixin:HideFrame()
	self:Hide()
end
