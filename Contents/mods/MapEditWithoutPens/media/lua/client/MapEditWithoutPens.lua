require "ISUI/ISButton"
require "ISUI/ISColorPicker"
require "ISUI/ISPanelJoypad"
require "ISUI/ISSpinBox"
require "ISUI/ISTickbox"
require "ISUI/Maps/ISMap"
require "ISUI/Maps/ISWorldMap"
require "ISUI/Maps/ISWorldMapSymbols"

local KaldoMapEdit = {}
KaldoMapEdit.originalCanWrite = ISMap.canWrite
-- ISMap.canWrite = function()
	-- KaldoMapEdit.originalCanWrite()
    -- return true
-- end

KaldoMapEdit.originalCanErase = ISMap.canErase
-- ISMap.canErase = function()
	-- KaldoMapEdit.originalCanErase()
    -- return true
-- end


-- local orig_canWrite = ISMap.canWrite
function ISMap:canWrite()
	KaldoMapEdit.originalCanWrite(self)
	return true
end

-- local orig_canErase = ISMap.canErase
function ISMap:canErase()
	KaldoMapEdit.originalCanErase(self)
	return true
end
