require "menu"
require "scroll"
require "player"
require "images"
require "monster"
require "hotbar"
require "save"
 
function love.load()

	ingame = false
	inmenu = true
	loadFunctions = false

	menu.load()
	images.load()
	
	bg_music = love.audio.newSource("test.wav") -- sound stuff - needs to go in own class
	bg_music:play()
	bg_music:setLooping(true)

end
 
function love.update(dt)

	if loadFunctions == true then

        save.load()
		scroll.load()
		player.load()
        monster.load()
        hotbar.load()

        loadFunctions = false

	end

	if ingame == true then
	    UPDATE_SCROLL(dt)
	    UPDATE_PLAYER(dt)
	    UPDATE_MONSTER(dt)
	    UPDATE_HOTBAR(dt)
	end
    UPDATE_SAVE(dt)
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

	love.graphics.setColor(255, 0, 0)

	if version_show == true then
		local major, minor, revision, codename = love.getVersion()
	    local str = string.format("Love Version %d.%d.%d - %s", major, minor, revision, codename)
	    love.graphics.print(str, 10, 20)
		love.graphics.print("Lua Version: " .._VERSION, 10, 30) --Lua Version
	end

	if doLoadScreen == false then
		love.graphics.print("MouseX: "..love.mouse.getX(), 10, 50)
    	love.graphics.print("MouseY: "..love.mouse.getY(), 10, 60)
    end

    if seed_show == true and ingame == true then
    	love.graphics.print("Seed: "..seed, 10, 40)
    elseif seed_show == true and ingame == false then
    	love.graphics.print("Seed: N/A", 10, 40)
    end

	if fps_show == true then
    	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10) --FPS Counter	
    end

    if ingame == true and doLoadScreen == false then
	    love.graphics.print("X: "..playerX, 10, 100)
	    love.graphics.print("Y: "..playerY, 10, 110)
	    love.graphics.print("Tile: "..currentTile, 10, 130)
	    love.graphics.print("Biome: "..currentBiome, 10, 120)
	end

end