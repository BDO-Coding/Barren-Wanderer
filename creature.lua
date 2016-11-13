creature={}

function creature.load()

	creature.amount = 100

	creatureArray = {{}}
	creatureArray[1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Random Move 3]], 1--[[Random Track 4]], 1--[[Speed 5]], 1--[[Type 6]], images.chicken--[[Image 7]], 1--[[Health 8]], 1--[[Drops 9]], 3--[[Size 10]], love.math.random(1, 3)--[[Temperament 11]], true--[[One Creation 12]]}

	for i = 1, creature.amount do
		creatureArray[#creatureArray + 1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Random Move 3]], 1--[[Random Track 4]], 1--[[Speed 5]], 1--[[Type 6]], images.chicken--[[Image 7]], 1--[[Health 8]], 1--[[Drops 9]], 3--[[Size 10]], love.math.random(1, 3)--[[Temperament 11]], true--[[One Creation 12]]}
	end

	--[[Temperament (11) 1 is peaceful
		Temperament (11) 2 is neutral
		Temperament (11) 3 is aggressive]]

end

function creature.update(dt)

	for i = 1, creature.amount do
		if creatureArray[i][12] == true then
			if creatureArray[i][11] == 1 then
				creatureArray[i][6] = love.math.random(1, 2)
				creatureArray[i][1] = 100
			elseif creatureArray[i][11] == 2 then
				creatureArray[i][6] = love.math.random(1, 2)
				creatureArray[i][1] = 200
			elseif creatureArray[i][11] == 3 then
				creatureArray[i][6] = love.math.random(1, 2)
				creatureArray[i][1] = 300
			end
			creatureArray[i][12] = false
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