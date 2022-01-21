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
	local inv = self.character and self.character:getInventory() or nil
	local currentEnabled = nil
	local firstEnabled = nil
	for _,colorBtn in ipairs(self.colorButtons) do
		colorBtn.enable = true
		colorBtn.borderColor.a = 0.4 -- not selected
		if colorBtn.enable then
			firstEnabled = firstEnabled or colorBtn
			if colorBtn.buttonInfo.colorInfo:equals(self.currentColor) then
				currentEnabled = colorBtn
				colorBtn.borderColor.a = 1.0
			end
			colorBtn.tooltip = nil
		else
			colorBtn.tooltip = colorBtn.buttonInfo.tooltip
		end
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
	local canWrite = self:canWrite()
	for _,symbolButton in ipairs(self.buttonList) do
		symbolButton.enable = canWrite
		if canWrite then
			symbolButton.tooltip = nil
		else
			symbolButton.tooltip = getText("Tooltip_Map_CantWrite")
		end
	end
	local canErase = self:canErase()
	self.addNoteBtn.enable = canWrite
	self.editNoteBtn.enable = canWrite and canErase
	self.moveBtn.enable = canWrite and canErase
	self.removeBtn.enable = canErase

	if canWrite then
		self.addNoteBtn.tooltip = nil
	else
		self.addNoteBtn.tooltip = getText("Tooltip_Map_CantWrite")
	end

	if canWrite and canErase then
		self.editNoteBtn.tooltip = nil
		self.moveBtn.tooltip = nil
	else
		self.editNoteBtn.tooltip = getText("Tooltip_Map_CantEdit")
		self.moveBtn.tooltip = getText("Tooltip_Map_CantEdit")
	end

	if canErase then
		self.removeBtn.tooltip = nil
	else
		self.removeBtn.tooltip = getText("Tooltip_Map_CantErase")
	end

	if self.currentTool == self.tools.AddSymbol and not canWrite then
		self:setCurrentTool(nil)
	end
	if self.currentTool == self.tools.AddNote and not canWrite then
		self:setCurrentTool(nil)
	end
	if self.currentTool == self.tools.EditNote and not (canWrite and canErase) then
		self:setCurrentTool(nil)
	end
	if self.currentTool == self.tools.MoveAnnotation and not (canWrite and canErase) then
		self:setCurrentTool(nil)
	end
	if self.currentTool == self.tools.RemoveAnnotation and not canErase then
		self:setCurrentTool(nil)
	end
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