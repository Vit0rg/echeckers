local setBoard = function()
	return
	{
		'[p1_build_1]', '[p1_build_2]', '[p1_build_3]',
		'[p1_field_1]', '[p1_field_2]', '[p1_field_3]',
		'###########', 'Phase indicator','###########',
		'[p2_field_1]', '[p2_field_2]', '[p2_field_3]',
		'[p2_build_1]', '[p2_build_2]', '[p2_build_3]',
	}
end
--[[
	Board => 
	01, 03 => p1 builds
	02, 06 => p1 fields
	07, 09 => Phase indicator
	10, 12 = p2 fields
	13,15 => p2 builds
]]


local board = setBoard()
local colors = {
	background = 0x505050,
	whiteSquare = '0x151515',
	whitePiece = 'f0f0f0',
	blackSquare = '0x2f2f2f',
	blackPiece = '3F008C',
	specialMove = 0xB300EF,
	emptyMove = 0x2ECF73,
	captureMove = 0xAF2A2A,
	lastMove = 0xFFCF5F,
	selectedPiece = '<PT>',
}