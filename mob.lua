mob={}

function mob.load()

	mob.amount = 100
	behaviorTimer = 0
	changeBehavior = true

	mobArray = {{}}
	mobArray[1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Behaviour 3]], love.math.random(1, 3)--[[Temperament 4]], 1--[[Speed 5]], 1--[[Type 6]], images.chicken--[[Image 7]], 1--[[Health 8]], 1--[[Drops 9]], 3--[[Size 10]], 1--[[One Creation 11]]}

	for i = 1, mob.amount do
		mobArray[#mobArray + 1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Behaviour 3]], love.math.random(1, 3)--[[Temperament 4]], 1--[[Speed 5]], 1--[[Type 6]], images.chicken--[[Image 7]], 1--[[Health 8]], 1--[[Drops 9]], 3--[[Size 10]], 1--[[One Creation 11]]}
	end

	--[[Temperament (4) 1 is passive
		Temperament (4) 2 is neutral
		Temperament (4) 3 is aggressive]]

end

function mob.update(dt)

	behaviorTimer = behaviorTimer + dt

	for i = 1, mob.amount do
		if mobArray[i][11] == 1 then
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
			changeBehavior = false
			mobArray[i][11] = 0
		end

		if mobArray[i][6] == 1 then
			mobArray[i][7] = images.chicken
		elseif mobArray[i][6] == 2 then
			mobArray[i][7] = images.parrot
		end
	end

end

function mob.behavior(dt)

	for i = 1, mob.amount do
		if (math.floor((mapX)*-64) + mobArray[i][1]) < 1200 and math.floor((mapY)*-64) + mobArray[i][2] > 0 and changeBehavior == true then
			mobArray[i][3] = love.math.random(1, 4)
			mobArray[i][11] = 3
		elseif mobArray[i][11] == 2 and changeBehavior == true then
			mobArray[i][3] = love.math.random(3, 5)
			mobArray[i][11] = 3
		end
		if mobArray[i][3] == 1 and mobArray[i][4] == 3 then --inPlayerView, follow player
		elseif mobArray[i][3] == 2 then --inPlayerView, move around a wall
		elseif mobArray[i][3] == 3 then --both, stay still, blend slightly
		elseif mobArray[i][3] == 4 then --both, move to a random destination
		elseif mobArray[i][3] == 5 then --notInPlayerView, move towards player view

		end
	end

	if behaviorTimer > 5 and behaviorTimer < 5.01 then
		changeBehavior = true
	elseif behaviorTimer > 5.02 then
		behaviorTimer = 0
		changeBehavior = false
	end

end

function mob.draw()

	for i = 1, mob.amount do
		if mobArray[i][3] == 3 then
			love.graphics.setColor(50, 255, 50)
		end
		love.graphics.draw(mobArray[i][7], math.floor((mapX)*-64) + mobArray[i][1], math.floor((mapY)*-64) + mobArray[i][2], 0, mobArray[i][10], mobArray[i][10])
		love.graphics.setColor(255, 255, 255, 255)
	end

end

function UPDATE_MOB(dt)

	mob.update(dt)
	mob.behavior(dt)

end

function DRAW_MOB()

	mob.draw()

end