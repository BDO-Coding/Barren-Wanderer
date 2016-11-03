hotbar={}
require "player"

function hotbar.load()

	currentHotbarHand = 1
	hotbarXCoord = 500
	barLength = 4
	barHeight = 2
	leftX = 140
	rightX = 373

end

function hotbar.update(dt)

	healthLength = (health/maxHealth)*barLength
	staminaLength = (stamina/maxStamina)*barLength
	manaLength = (mana/maxMana)*barLength
	hungerLength = (hunger/maxHunger)*barLength

	if health <= 0 then healthLength = 0 end

	if stamina <= 0 then staminaLength = 0 end

	if mana <= 0 then manaLength = 0 end

	if hunger <= 0 then hungerLength = 0 end

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

	if alive == true then
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
		love.graphics.draw(images.guiBarInside, 70, 650, 0, healthLength, barHeight)
		love.graphics.setColor(10, 255, 10)
		love.graphics.draw(images.guiBarInside, 70, 680, 0, staminaLength, barHeight)
		love.graphics.setColor(147, 49, 245)
		love.graphics.draw(images.guiBarInside, 300, 650, 0, manaLength, barHeight)
		love.graphics.setColor(224, 157, 49)
		love.graphics.draw(images.guiBarInside, 300, 680, 0, hungerLength, barHeight)
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(images.guiBar, 70, 650, 0, barLength, barHeight)
		love.graphics.draw(images.guiBar, 70, 680, 0, barLength, barHeight)
		love.graphics.draw(images.guiBar, 300, 650, 0, barLength, barHeight)
		love.graphics.draw(images.guiBar, 300, 680, 0, barLength, barHeight)
		love.graphics.draw(images.health, 33.6, 650, 0, barHeight, barHeight-(barHeight)*0.1)
		love.graphics.draw(images.stamina, 33.6, 680, 0, barHeight, barHeight-(barHeight)*0.1)
		love.graphics.draw(images.mana, 263.6, 650, 0, barHeight, barHeight-(barHeight)*0.1)
		love.graphics.draw(images.hunger, 263.6, 680, 0, barHeight, barHeight-(barHeight)*0.1)
		love.graphics.print((math.floor(health)).."/"..maxHealth, leftX, 660)
		love.graphics.print((math.floor(stamina)).."/"..maxStamina, leftX, 690)
		love.graphics.print((math.floor(mana)).."/"..maxMana, rightX, 660)
		love.graphics.print((math.floor(hunger)).."/"..maxHunger, rightX, 690)
	end

end

function UPDATE_HOTBAR(dt)

	hotbar.update(dt)

end

function DRAW_HOTBAR()

	hotbar.draw()

end