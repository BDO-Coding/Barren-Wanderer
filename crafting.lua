crafting={}
require "images"

function crafting.load ()

	recipeIndex = {{}}
	recipeIndex[1] = {true--[[if its known]],false--[[if selected]],1--[[itemID (result)]],1--[[crafterID]],{{1,1,1},{1,1,1},{1,1,1}}}
	recipeIndex[2] = {true,false,2,1,{{1,1,1},{1,1,1},{1,1,1}}}
	recipeIndex[3] = {true,false,3,1,{{1,1,1},{1,1,1},{1,1,1}}}
	recipeIndex[4] = {true,false,4,1,{{1,1,1},{1,1,1},{1,1,1}}}

	inCrafting = false
	wait = 0

	lineSpacing = 15

	keyPressed = false

	draw2 = false

	mouseX = 0
	mouseY = 0

end

function crafting.draw()

		if draw2 == true then
		love.graphics.draw(images.mana,100,100)
	end

	if inCrafting == true then
		love.graphics.draw(images.crafting,300,50,0,1.25,1.25)

		lineNum = 1

		for i = 2, #recipeIndex do
			if recipeIndex[i][1] == true then
				if recipeIndex [i][2] == true then
					love.graphics.setColor(50,50,50)
				else
					love.graphics.setColor(255,255,255)
				end
				love.graphics.print(item.getItemName(recipeIndex[i][3]),360, 128+((lineNum-1)*lineSpacing))
				lineNum = lineNum+1
			end
		end
	end

end

function crafting.update(dt)

	mouseX, mouseY = love.mouse.getX(),love.mouse.getY()

	if love.mouse.isDown(1) == true then
		lineNum = 0
		for i = 2, #recipeIndex do
			if recipeIndex[i][1] == true then
				if love.mouse.getX() > 360 and love.mouse.getX() < 500 then
					if love.mouse.getY() > 128 + (lineSpacing*lineNum) and love.mouse.getY() < (128+lineSpacing) + (lineSpacing*lineNum) then
						recipeIndex[i][2] = true
					else
						recipeIndex[i][2] = false
					end
				end

			lineNum = lineNum+1

		end
	end
end

	if keyPressed == true then
		inCrafting = not inCrafting
		keyPressed = false
	end

	if wait > 0 then
		wait = wait - 1
	end

	if wait == 0 and love.keyboard.isDown("c") then
		wait = 20
		keyPressed = true
	end
end

function DRAW_CRAFTING()
	crafting.draw()
end

function UPDATE_CRAFTING(dt)
	crafting.update(dt)
end