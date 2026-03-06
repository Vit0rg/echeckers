-- StringReference
local stringReference = {}
stringReference.emptySquare = "<textformat leftmargin='30' rightmargin='30' leading='30'>"
stringReference.HREF_select = "<a href='event:select_%s_%s_%s_%s'>"
stringReference.squareFormat = "<font size='25'><B>"

stringReference.select = stringReference.emptySquare .. stringReference.HREF_select .. "\n"
stringReference.piece = stringReference.squareFormat .. stringReference.HREF_select .. "%s"
stringReference.castling = stringReference.emptySquare .. "<a href='event:kingpass_%s_%s_%s'>\n"