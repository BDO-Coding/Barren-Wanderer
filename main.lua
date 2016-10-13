require "scroll"
require "player"
require "images"
require "monster"
 
function love.load()

    scroll.load()
    player.load()
    images.load()
    monster.load()

end
 
function love.update(dt)

    UPDATE_SCROLL(dt)
    UPDATE_PLAYER(dt)
    UPDATE_MONSTER(dt)

end
 
function love.draw()

    DRAW_SCROLL()
    DRAW_PLAYER()
    DRAW_MONSTER()

    love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20) --FPS Counter
  
end