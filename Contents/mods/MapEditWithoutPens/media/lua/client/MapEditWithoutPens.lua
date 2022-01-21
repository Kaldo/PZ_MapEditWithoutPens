require "ISUI/Maps/ISMap"
require "ISUI/Maps/ISWorldMapSymbols"
require "ISUI/Maps/ISTextBoxMap"

local KaldoMapEdit = {}

function ISMap:canWrite()
	return true
end

function ISMap:canErase()
	return true
end

function ISWorldMapSymbols:canWrite()
	return true
end

function ISWorldMapSymbols:canErase()
	return true
end

KaldoMapEdit.ISWorldMapSymbols_checkInventory = ISWorldMapSymbols.checkInventory
function ISWorldMapSymbols:checkInventory()
	KaldoMapEdit.ISWorldMapSymbols_checkInventory(self)

	local currentEnabled = nil
	local firstEnabled = nil
	for _,colorBtn in ipairs(self.colorButtons) do
		colorBtn.enable = true
		colorBtn.borderColor.a = 0.4 -- not selected
		firstEnabled = firstEnabled or colorBtn
		if colorBtn.buttonInfo.colorInfo:equals(self.currentColor) then
			currentEnabled = colorBtn
			colorBtn.borderColor.a = 1.0
		end
		colorBtn.tooltip = nil
	end
	if not currentEnabled then
		if firstEnabled ~= nil then
			firstEnabled.borderColor.a = 1.0 -- selected
			self.currentColor = firstEnabled.buttonInfo.colorInfo
		else
			self.currentColor = self.blackColor
		end
	end
	
	self:updateSymbolColors()
	for _,symbolButton in ipairs(self.buttonList) do
		symbolButton.enable = true
		symbolButton.tooltip = nil
	end
	
	
	self.addNoteBtn.enable = true
	self.editNoteBtn.enable = true
	self.moveBtn.enable = true
	self.removeBtn.enable = true

	self.addNoteBtn.tooltip = nil
	self.editNoteBtn.tooltip = nil
	self.moveBtn.tooltip = nil
	self.removeBtn.tooltip = nil
end


KaldoMapEdit.ISTextBoxMap_updateButtons = ISTextBoxMap.updateButtons
function ISTextBoxMap:updateButtons()
	KaldoMapEdit.ISTextBoxMap_updateButtons(self)
    
	local currentEnabled = nil
	local firstEnabled = nil
	for _,colorBtn in ipairs(self.colorButtons) do
		colorBtn.enable = true
		colorBtn.borderColor.a = 0.4 -- not selected
		firstEnabled = firstEnabled or colorBtn
		if colorBtn.buttonInfo.colorInfo:equals(self.currentColor) then
			currentEnabled = colorBtn
			colorBtn.borderColor.a = 1.0
		end
		colorBtn.tooltip = nil
	end
	if not currentEnabled then
		if firstEnabled ~= nil then
			firstEnabled.borderColor.a = 1.0 -- selected
			self.currentColor = firstEnabled.buttonInfo.colorInfo
		else
			self.currentColor = self.blackColor
		end
	end

    self.yes:setEnable(true);
    self.yes.tooltip = nil;
end