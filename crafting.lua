crafting={}
require "images"

function crafting.load ()

	recipeIndex = {{}}
	recipeIndex[1] = {true--[[if its known]],1--[[itemID (result)]],1--[[crafterID]],{{1,1,1},{1,1,1},{1,1,1}}}

	inCrafting = true
	wait = 0

	keyPressed = false

end

function crafting.draw()

	if inCrafting == true then
		love.graphics.draw(images.mana,100,100)
		love.graphics.draw(images.crafting,300,50,0,1.25,1.25)


		for 

	end

end

function crafting.update(dt)

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