hotbar={}

function hotbar.load()

	currentHotbarHand = 1

end

function hotbar.update(dt)

	function love.keypressed(numberKey)
		if ingame == true and loadScreen == false then -----------AAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHH
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

end

function UPDATE_HOTBAR(dt)

	hotbar.update(dt)

end

function DRAW_HOTBAR()

	hotbar.draw()

end