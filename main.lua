require "menu"
require "scroll"
require "player"
require "images"
require "monster"
 
function love.load()

	ingame = false
	inmenu = true

	biomeArray = {}

	menu.load()

end
 
function love.update(dt)

	if ingame == true then
	    UPDATE_SCROLL(dt)
	    UPDATE_PLAYER(dt)
	    UPDATE_MONSTER(dt)
	end

	UPDATE_MENU(dt)

end
 
function love.draw()

	love.graphics.setColor(255, 255, 255)

	if ingame == true then
	    DRAW_SCROLL()
	    DRAW_PLAYER()
	    DRAW_MONSTER()
	end

	DRAW_MENU()

    love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20) --FPS Counter
  
end