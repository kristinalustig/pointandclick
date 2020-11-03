RotPuz = {
  Rotations = {0, 1.5708, 3.1416, 4.7124},
  Spacing = 3
}
RotPuz.__index = RotPuz

setmetatable(RotPuz, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function RotPuz.new(gridWidth, src, puzX, puzY)
  pieceSize = src:getHeight()/gridWidth
  local self = setmetatable({
    src = src,
    gridWidth = gridWidth,
    pieceSize = pieceSize,
    offset = pieceSize/2,
    solved = false,
    pieces = {}
  }, RotPuz)
  for row = 1, self.gridWidth do
    self.pieces[row] = {}
    for col = 1, self.gridWidth do
      self.pieces[row][col] = {
        pquad = love.graphics.newQuad((row-1) * self.pieceSize, (col-1) * self.pieceSize, self.pieceSize, self.pieceSize, self.src:getDimensions()),
        x = ((row-1) * self.pieceSize) + ((row-1) * RotPuz.Spacing) + puzX,
        y = ((col-1) * self.pieceSize) + ((col-1) * RotPuz.Spacing) + puzY,
        rotation = self.Rotations[love.math.random(4)],
        isPresent = true,
        type = "piece",
        parent = self
      }
      table.insert(globalItemTable, self.pieces[row][col])
    end
  end
  return self
end

function RotPuz:drawPuz()
  for rownum, row in pairs(self.pieces) do
    for colnum, piece in pairs(self.pieces[rownum]) do
      love.graphics.draw(self.src, piece.pquad, piece.x, piece.y, piece.rotation, 1, 1, self.offset, self.offset)
    end
  end
end

function RotPuz:onClick(item, xmouse, ymouse)
  xmouse = xmouse + self.offset
  ymouse = ymouse + self.offset
  if (xmouse >= item.x and xmouse <= item.x + self.pieceSize) and (ymouse >= item.y and ymouse <= item.y + self.pieceSize) then
    item.rotation = item.rotation + 1.5708
    if item.rotation == 6.2832 then
      item.rotation = 0
    end
  end
end

function RotPuz:checkSolved()
  for rownum, row in pairs(self.pieces) do
    for colnum, piece in pairs(self.pieces[rownum]) do
      if piece.rotation ~= 0 then
        return false
      end
    end
  end
  return true
end
