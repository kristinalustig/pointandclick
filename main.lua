require ("rotpuz")
require ("scramblepuz")
moonshine = require ("moonshine")

function love.load()
  globalItemTable = {}
  effectsTable = {}

  puzzle1img = love.graphics.newImage("realsolution3.png")
  puzzle2img = love.graphics.newImage("genericitem.png")

  effect = moonshine(moonshine.effects.glow)

  puzzle1 = RotPuz(2, puzzle1img, 100, 100)
  puzzle2 = ScramblePuz(2, puzzle2img, 400, 300)

end

function love.update(dt)
end

function love.draw()
  puzzle1:drawPuz()
  puzzle2:drawPuz()
  love.graphics.print(tostring(puzzle1.solved), 50, 50)
  love.graphics.print(tostring(puzzle2.solved), 540, 540)
end

function love.mousepressed(x, y, button, istouch, presses)
  for i,item in pairs(globalItemTable) do
    if item.type == "piece" then
      found = item.parent:onClick(item, x, y)
      item.parent.solved = item.parent:checkSolved()
      if found then break end
    end
  end
end
