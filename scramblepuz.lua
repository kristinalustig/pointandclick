ScramblePuz = {
  Spacing = 3
}
ScramblePuz.__index = ScramblePuz

setmetatable(ScramblePuz, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function ScramblePuz.new (gridWidth, src, puzX, puzY)
  pieceSize = src:getHeight()/gridWidth
  scrambler = {}
  local self = setmetatable({
    src = src,
    gridWidth = gridWidth,
    solved = false,
    pieceSize = pieceSize,
    pieces = {},
    hasSelected = false,
    pieceSelected
  }, ScramblePuz)
  for row = 1, self.gridWidth do
    self.pieces[row] = {}
    for col = 1, self.gridWidth do
      self.pieces[row][col] = {
        pquad = love.graphics.newQuad((row-1) * self.pieceSize, (col-1) * self.pieceSize, self.pieceSize, self.pieceSize, self.src:getDimensions()),
        trueX = ((row-1) * self.pieceSize) + ((row-1) * ScramblePuz.Spacing) + puzX,
        trueY = ((col-1) * self.pieceSize) + ((col-1) * ScramblePuz.Spacing) + puzY,
        startX = 10,
        startY = 10,
        isPresent = true,
        type = "piece",
        parent = self
      }
      table.insert(globalItemTable, self.pieces[row][col])
      scrambler[#scrambler+1] = {x = self.pieces[row][col].trueX, y = self.pieces[row][col].trueY}
    end
  end
  for rownum, row in ipairs(self.pieces) do
    for col, piece in ipairs(self.pieces[rownum]) do
      takePos = love.math.random(1, #scrambler)
      piece.startX = scrambler[takePos].x
      piece.startY = scrambler[takePos].y
      table.remove(scrambler, takePos)
    end
  end
  return self
end

function ScramblePuz:drawPuz()
  for rownum, row in pairs(self.pieces) do
    for col, piece in pairs(self.pieces[rownum]) do
      love.graphics.draw(self.src, piece.pquad, piece.startX, piece.startY)
    end
  end
end

function ScramblePuz:onClick(item, xmouse, ymouse)
  if (xmouse >= item.startX and xmouse <= item.startX + self.pieceSize) and (ymouse >= item.startY and ymouse <= item.startY + self.pieceSize) then
    if not self.hasSelected then
      self.pieceSelected = item
      self.hasSelected = true
    else
      local tempXsel = self.pieceSelected.startX
      local tempYsel = self.pieceSelected.startY
      local tempX = item.startX
      local tempY = item.startY
      self.pieceSelected.startX = tempX
      self.pieceSelected.startY = tempY
      item.startX = tempXsel
      item.startY = tempYsel
      self.hasSelected = false
      self.pieceSelected = nil
    end
    return true
  end
  return false
end

function ScramblePuz:checkSolved()
  for rownum, row in pairs(self.pieces) do
    for col, piece in pairs(self.pieces[rownum]) do
    end
  end
end
