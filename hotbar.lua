hotbar={}
require "player"

function hotbar.load()

	currentHotbarHand = 1
	hotbarXCoord = 500
	healthLength = 8

end

function hotbar.update(dt)

	function love.keypressed(numberKey)
		if ingame == true and loadScreen == false then
			if numberKey == "1" then
				currentHotbarHand = 1
			elseif numberKey == "2" then
				currentHotbarHand = 2
			elseif numberKey == "3" then
				currentHotbarHand = 3
			elseif numberKey == "4" then
				currentHotbarHand = 4
			elseif numberKey == "5" then
				currentHotbarHand = 5
			elseif numberKey == "6" then
				currentHotbarHand = 6
			elseif numberKey == "7" then
				currentHotbarHand = 7
			elseif numberKey == "8" then
				currentHotbarHand = 8
			elseif numberKey == "9" then
				currentHotbarHand = 9
			elseif numberKey == "0" then
				currentHotbarHand = 10
			end
		end
	end

end

function hotbar.draw()

	hotbarXCoord = 500
	healthLength = health/10

	if alive == true then
		if health >= 80 then healthLength = 8 end
		if health <= 0 then healthLength = 0 end

		for i = 1, 10 do
			if i == currentHotbarHand then
				love.graphics.setColor(50, 50, 50)
				love.graphics.draw(images.hotbar, hotbarXCoord, 650, 0, 2, 2)
				love.graphics.print(i, hotbarXCoord + 5, 655)
				hotbarXCoord = hotbarXCoord + 67
			else
				love.graphics.setColor(255, 255, 255)
				love.graphics.draw(images.hotbar, hotbarXCoord, 650, 0, 2, 2)
				love.graphics.print(i, hotbarXCoord + 5, 655)
				hotbarXCoord = hotbarXCoord + 67
			end
		end
		love.graphics.setColor(255, 0, 0)
		love.graphics.draw(images.guiBarInside, 100, 650, 0, healthLength, 2)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(images.guiBar, 100, 650, 0, 8, 2)
		love.graphics.draw(images.health, 60, 650, 0, 2, 1.8)
		love.graphics.print((math.floor(health)).."/"..maxHealth, 268, 660)
	end

end

function UPDATE_HOTBAR(dt)

	hotbar.update(dt)

end

function DRAW_HOTBAR()

	hotbar.draw()

end