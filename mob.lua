mob={}

function mob.load()

	mob.amount = 100

	mobArray = {{}}
	mobArray[1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Behaviour 3]], love.math.random(1, 3)--[[Temperament 4]], 1--[[Speed 5]], 1--[[Type 6]], images.chicken--[[Image 7]], 1--[[Health 8]], 1--[[Drops 9]], 3--[[Size 10]], true--[[One Creation 11]]}

	for i = 1, mob.amount do
		mobArray[#mobArray + 1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Behaviour 3]], love.math.random(1, 3)--[[Temperament 11]], 1--[[Speed 5]], 1--[[Type 6]], images.chicken--[[Image 7]], 1--[[Health 8]], 1--[[Drops 9]], 3--[[Size 10]], true--[[One Creation 11]]}
	end

	--[[Temperament (4) 1 is passive
		Temperament (4) 2 is neutral
		Temperament (4) 3 is aggressive]]

end

function mob.update(dt)

	for i = 1, mob.amount do
		if mobArray[i][11] == true then
			if mobArray[i][4] == 1 then
				mobArray[i][6] = 1--love.math.random(1, 2)
				mobArray[i][1] = love.math.random(600, 1000)
				mobArray[i][2] = love.math.random(400, 800)
			elseif mobArray[i][4] == 2 then
				mobArray[i][6] = love.math.random(1, 2)
				mobArray[i][1] = love.math.random(1010, 1500)
				mobArray[i][2] = love.math.random(810, 1300)
			elseif mobArray[i][4] == 3 then
				mobArray[i][6] = 2--love.math.random(1, 2)
				mobArray[i][1] = love.math.random(1510, 2000)
				mobArray[i][2] = love.math.random(1310, 1800)
			end
			mobArray[i][11] = false
		end

		if mobArray[i][6] == 1 then
			mobArray[i][7] = images.chicken
		elseif mobArray[i][6] == 2 then
			mobArray[i][7] = images.parrot
		end
	end

end

function mob.draw()

	for i = 1, mob.amount do
		love.graphics.draw(mobArray[i][7], math.floor((mapX)*-64) + mobArray[i][1], math.floor((mapY)*-64) + mobArray[i][2], 0, mobArray[i][10], mobArray[i][10])
	end

end

function UPDATE_MOB(dt)

	mob.update(dt)

end

function DRAW_MOB()

	mob.draw()

end