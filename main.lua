require "scroll"
require "player"
require "images"
 
function love.load()

    scroll.load()
    player.load()
    images.load()

end
 
function love.update(dt)

    UPDATE_SCROLL(dt)
    UPDATE_PLAYER(dt)
    UPDATE_IMAGES(dt)

end
 
function love.draw()

    DRAW_SCROLL()
    DRAW_PLAYER()

    love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20) --FPS Counter
  
end