require ("rotpuz")
require ("scramblepuz")


function love.load()
  globalItemTable = {}

  --puzzle1img = love.graphics.newImage("realsolution3.png")
  puzzle2img = love.graphics.newImage("genericitem.png")

  --puzzle1 = RotPuz(2, puzzle1img, 100, 100)
  puzzle2 = ScramblePuz(4, puzzle2img, 300, 300)

end

function love.update()

end

function love.draw()
  --puzzle1:drawPuz()
  puzzle2:drawPuz()
  --love.graphics.print(tostring(puzzle1.solved), 50, 50)
  love.graphics.print(tostring(puzzle2.hasSelected), 540, 540)
  love.graphics.print(tostring(puzzle2.pieceSelected), 550, 560)
end

function love.mousepressed(x, y, button, istouch, presses)
  for i,item in pairs(globalItemTable) do
    if item.type == "piece" then
      found = item.parent:onClick(item, x, y)
      if found then break end
      --item.parent.solved = item.parent:checkSolved()
    end
  end
end
