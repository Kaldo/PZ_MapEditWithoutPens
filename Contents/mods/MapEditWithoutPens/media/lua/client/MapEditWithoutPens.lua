require "ISUI/Maps/ISMap"
require "ISUI/Maps/ISWorldMapSymbols"
require "ISUI/Maps/ISTextBoxMap"

local KaldoMapEdit = {}

KaldoMapEdit.ISMap_CanWrite = ISMap.canWrite
function ISMap:canWrite()
	KaldoMapEdit.ISMap_CanWrite(self)
	return true
end

KaldoMapEdit.ISMap_CanErase = ISMap.canErase
function ISMap:canErase()
	KaldoMapEdit.ISMap_CanErase(self)
	return true
end

KaldoMapEdit.ISWorldMapSymbols_CanWrite = ISWorldMapSymbols.canWrite
function ISWorldMapSymbols:canWrite()
	KaldoMapEdit.ISWorldMapSymbols_CanWrite(self)
	return true
end

KaldoMapEdit.ISWorldMapSymbols_CanErase = ISWorldMapSymbols.canErase
function ISWorldMapSymbols:canErase()
	KaldoMapEdit.ISWorldMapSymbols_CanErase(self)
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


-- KaldoMapEdit.ISTextBoxMap_updateButtons = ISTextBoxMap.updateButtons
-- function ISTextBoxMap:updateButtons()
	-- KaldoMapEdit.ISTextBoxMap_updateButtons(self)
	
	-- for _,colorBtn in ipairs(self.colorButtons) do
        -- colorBtn.enable = true
    -- end
    
    -- self.yes:setEnable(true);
    -- self.yes.tooltip = nil;
    -- local text = self.entry:getText()
    -- if self.validateFunc and not self.validateFunc(self.validateTarget, text, self.validateArgs[1], self.validateArgs[2]) then
        -- self.yes:setEnable(false);
        -- self.yes.tooltip = self.validateTooltipText;
    -- end
    -- if self.maxChars and self.entry:getInternalText():len() > self.maxChars then
        -- self.yes:setEnable(false);
        -- self.yes.tooltip = getText("IGUI_TextBox_TooManyChar", self.maxChars);
    -- end
    -- if self.noEmpty and string.trim(self.entry:getInternalText()) == "" then
        -- self.yes:setEnable(false);
        -- self.yes.tooltip = getText("IGUI_TextBox_CantBeEmpty");
    -- end
-- end