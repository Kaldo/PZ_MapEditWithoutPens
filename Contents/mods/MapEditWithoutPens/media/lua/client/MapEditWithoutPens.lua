require "ISUI/Maps/ISMap"
require "ISUI/Maps/ISWorldMapSymbols"

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

KaldoMapEdit.ISWorldMapSymbols_CanWrite2 = ISWorldMapSymbols.canWrite
function ISWorldMapSymbols:canWrite()
	KaldoMapEdit.ISWorldMapSymbols_CanWrite2(self)
	return true
end

KaldoMapEdit.ISWorldMapSymbols_CanErase2 = ISWorldMapSymbols.canErase
function ISWorldMapSymbols:canErase()
	KaldoMapEdit.ISWorldMapSymbols_CanErase2(self)
	return true
end