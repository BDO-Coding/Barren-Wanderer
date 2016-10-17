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
	
	bg_music = love.audio.newSource("test.wav") -- sound stuff - needs to go in own class
	bg_music:play()
	bg_music:setLooping(true)

	love.mouse.setGrabbed(true)  --prevents mouse leaving game alt+f4 to quit

end
 
function love.update(dt)

	if ingame == true then
	    UPDATE_SCROLL(dt)
	    UPDATE_PLAYER(dt)
	    UPDATE_MONSTER(dt)
	    UPDATE_HOTBAR(dt)
	end

	UPDATE_MENU(dt)
	love.audio.setVolume(volume/100)
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


	love.graphics.setColor(0,0,0)
	if version_show == true then
		local major, minor, revision, codename = love.getVersion()
	    local str = string.format("Love Version %d.%d.%d - %s", major, minor, revision, codename)
	    love.graphics.print(str, 10, 20)
		love.graphics.print("Lua Version: " .._VERSION, 10, 30) --Lua Version
	end

	if mouseCoord_show == true then
		love.graphics.print("MouseX: "..love.mouse.getX(), 10, 40)
    	love.graphics.print("MouseY: "..love.mouse.getY(), 10, 50)
    end

	if fps_show == true then
    	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10) --FPS Counter	
    end
end