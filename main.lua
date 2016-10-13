require "menu"
require "scroll"
require "player"
require "images"
require "monster"
 
function love.load()

	--Loading Classes
	inmenu = true

	menu.load()

end
 
function love.update(dt)

	if inmenu == false then
	    UPDATE_SCROLL(dt)
	    UPDATE_PLAYER(dt)
	    UPDATE_MONSTER(dt)
	end

	UPDATE_MENU()

end
 
function love.draw()

	if inmenu == false then
	    DRAW_SCROLL()
	    DRAW_PLAYER()
	    DRAW_MONSTER()
	end

	DRAW_MENU()

    love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20) --FPS Counter
  
end