crafting={}
require "images"

function crafting.load ()

	recipeIndex = {{}}
	recipeIndex[1] = {true--[[if its known]],false--[[if selected]],1--[[itemID (result)]],{1,2,1,2}} -- ID,Amount ID,Amount
	
	recipeIndex[2] = {true,false,2,1,4} -- last num is amount of elements in ingredient array
	recipeIndex[2][6] = {4,2,3,1}

	recipeIndex[3] = {true,false,3,1,2}
	recipeIndex[3][6] = {3,10}

	recipeIndex[4] = {true,false,4,1,2}
	recipeIndex[4][6] = {4,10}

	recipeIndex[5] = {true,false,5,1,4}
	recipeIndex[5][6] = {2,2,4,1}



	inCrafting = false
	wait = 0

	lineSpacing = 30

	keyPressed = false

		draw2 = false

	mouseX = 0
	mouseY = 0

	selectedRecipe = 2
	unselected = true

end

function crafting.draw()

		if draw2 == true then
		love.graphics.draw(images.mana,100,100)
	end

	if inCrafting == true then
		love.graphics.draw(images.crafting,300,50,0,1.25,1.25)
		love.graphics.print("Recipes:",397,110)
		love.graphics.print("Crafting:",670,110)

		if unselected == true then
			love.graphics.print("Select a recipe by clicking on it.",620,140)
		end

		lineNum = 1

		for i = 2, #recipeIndex do
			if recipeIndex[i][1] == true then
				if recipeIndex [i][2] == true then
					love.graphics.setColor(10,10,10)
				else
					love.graphics.setColor(255,255,255)
				end
				love.graphics.print(item.getItemName(recipeIndex[i][3]),380, 128+((lineNum-1)*lineSpacing))
				love.graphics.setColor(255,255,255)
				love.graphics.draw(item.getItemImage(recipeIndex[i][3]),350,128+((lineNum-1)*lineSpacing),0,0.75,0.75)
				lineNum = lineNum+1
			end
		end

		if unselected == false then
			ingredientNum = 1
			lineNum = 1
			if love.mouse.getX() > 660 and love.mouse.getX() < 700  and love.mouse.getY() > 570 and love.mouse.getY() < 590 then
				love.graphics.setColor(50,255,50)
			else
				love.graphics.setColor(255,255,255)
			end
			love.graphics.print("Craft",670,580)
			love.graphics.setColor(255,255,255)
			for i = 1, (recipeIndex[selectedRecipe][5])/2 do
				ingredientNum = (i*2)-1
				love.graphics.print(item.getItemName(recipeIndex[selectedRecipe][6][ingredientNum]).." x "..recipeIndex[selectedRecipe][6][ingredientNum+1],650,128+((lineNum-1)*lineSpacing))
				love.graphics.draw(item.getItemImage(recipeIndex[selectedRecipe][6][ingredientNum]),600,128+((lineNum-1)*lineSpacing),0,0.75,0.75)
				lineNum = lineNum+1
			end
		end

	end

end

function crafting.update(dt)

	--Checks if nothing is selected:
	unselected = true
	for i = 2, #recipeIndex do
		if recipeIndex[i][2] == true then
			unselected = false
		end
	end

	mouseX, mouseY = love.mouse.getX(),love.mouse.getY()

	if love.mouse.isDown(1) == true then
		if inCrafting == true and unselected == false then
			if love.mouse.getX() > 660 and love.mouse.getX() < 700  and love.mouse.getY() > 570 and love.mouse.getY() < 590 then
				item.grab(0,0,"specificGive",recipeIndex[selectedRecipe][3],1)
				hotbar.take(2,1)
				love.timer.sleep(0.1)
			end
		end
		lineNum = 0
		for i = 2, #recipeIndex do
			if recipeIndex[i][1] == true then
				if love.mouse.getX() > 360 and love.mouse.getX() < 500 then
					if love.mouse.getY() > 128 + (lineSpacing*lineNum) and love.mouse.getY() < (128+lineSpacing) + (lineSpacing*lineNum) then
						recipeIndex[i][2] = true
						unselected = false
						selectedRecipe = i
					else
						recipeIndex[i][2] = false
					end
				end
			lineNum = lineNum+1
		end
	end

end

	if keyPressed == true then
		if inCrafting == false then
			for i = 2,#recipeIndex do
				recipeIndex[i][2] = false
			    unselected = true
			end
		end
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