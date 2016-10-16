require "menu"
require "scroll"
require "player"
require "images"
require "monster"
require "hotbar"
 
function love.load()

	ingame = false
	inmenu = true

	menu.load()
	images.load()

end
 
function love.update(dt)

	if ingame == true then
	    UPDATE_SCROLL(dt)
	    UPDATE_PLAYER(dt)
	    UPDATE_MONSTER(dt)
	    UPDATE_HOTBAR(dt)
	end

	UPDATE_MENU(dt)

end
 
function love.draw()

	love.graphics.setColor(255, 255, 255)

	if ingame == true then
	    DRAW_SCROLL()
	    DRAW_PLAYER()
	    DRAW_MONSTER()
	    DRAW_HOTBAR()
	end

	DRAW_MENU()

    love.graphics.print("FPS: "..love.timer.getFPS(), 10, 20) --FPS Counter
      love.graphics.print(_VERSION, 10, 120) --Lua Version
end