
function creature.load()

	creature.amount = 100

	creatureArray = {{}}
	creatureArray[1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Behaviour 3]], love.math.random(1, 3)--[[Temperament 4]], 1--[[Speed 5]], 1--[[Type 6]], images.chicken--[[Image 7]], 1--[[Health 8]], 1--[[Drops 9]], 3--[[Size 10]], true--[[One Creation 11]]}

	for i = 1, creature.amount do
		creatureArray[#creatureArray + 1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Behaviour 3]], love.math.random(1, 3)--[[Temperament 11]], 1--[[Speed 5]], 1--[[Type 6]], images.chicken--[[Image 7]], 1--[[Health 8]], 1--[[Drops 9]], 3--[[Size 10]], true--[[One Creation 11]]}
	end

	--[[Temperament (4) 1 is passive
		Temperament (4) 2 is neutral
		Temperament (4) 3 is aggressive]]

end

function creature.update(dt)

	for i = 1, creature.amount do
		if creatureArray[i][11] == true then
			if creatureArray[i][4] == 1 then
				creatureArray[i][6] = 1--love.math.random(1, 2)
				creatureArray[i][1] = love.math.random(600, 1000)
				creatureArray[i][2] = love.math.random(400, 800)
			elseif creatureArray[i][4] == 2 then
				creatureArray[i][6] = love.math.random(1, 2)
				creatureArray[i][1] = love.math.random(1010, 1500)
				creatureArray[i][2] = love.math.random(810, 1300)
			elseif creatureArray[i][4] == 3 then
				creatureArray[i][6] = 2--love.math.random(1, 2)
				creatureArray[i][1] = love.math.random(1510, 2000)
				creatureArray[i][2] = love.math.random(1310, 1800)
			end
			creatureArray[i][11] = false
		end

		if creatureArray[i][6] == 1 then
			creatureArray[i][7] = images.chicken
		elseif creatureArray[i][6] == 2 then
			creatureArray[i][7] = images.parrot
		end
	end

end

function creature.draw()

	for i = 1, creature.amount do
		love.graphics.draw(creatureArray[i][7], (playerX*-64) + creatureArray[i][1], (playerY*-64) + creatureArray[i][2], 0, creatureArray[i][10], creatureArray[i][10])
	end

end

function UPDATE_CREATURE(dt)

	creature.update(dt)

end

function DRAW_CREATURE()

	creature.draw()

end