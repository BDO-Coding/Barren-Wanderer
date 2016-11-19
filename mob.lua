mob={}
require "conversation"
require "player"

function mob.load()

	mob.amount = 100
	behaviorTimer = 0
	changeBehavior = true
	createMobs = true

	mobArray = {{}}
	mobArray[1] = {200--[[X position 1]], 200--[[Y position 2]], 1--[[Behaviour 3]], love.math.random(1, 3)--[[Temperament 4]], 1--[[Speed 5]], {1,"npc"}--[[Type Array 6]], images.chicken--[[Image 7]], {30, 0.1}--[[Health & Damage 8]], {}--[[Drops 9]], {3, 3, 0}--[[Size Array 10]], {"Gary", 1}--[[Name & Creation 11]], {1, 1, "left", true, false}--[[Destination Array 12]]}

	for i = 1, mob.amount do
		mobArray[#mobArray + 1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Behaviour 3]], love.math.random(1, 3)--[[Temperament 4]], 1--[[Speed 5]], {1,"mob"}--[[Type Array 6]], images.chicken--[[Image 7]], {30, 0.1}--[[Health & Damage 8]], {}--[[Drops 9]], {3, 3, 0}--[[Size Array 10]], {"Chicken", 1}--[[Name & Creation 11]], {1, 1, "left", true, false}--[[Destination Array 12]]}
	end

	--[[Temperament (4) 1 is passive
		Temperament (4) 2 is neutral
		Temperament (4) 3 is aggressive]]

end

function mob.update(dt)

	behaviorTimer = behaviorTimer + dt

	for i = 1, mob.amount do
		if mobArray[i][1] > (playerX*64)+510 and mobArray[i][1] < (playerX*64)+570 and mobArray[i][2] > (playerY*64)+280 and mobArray[i][2] < (playerY*64)+330 then
			mobArray[i][12][5] = true
			if mobArray[i][4] == 3 then
				health = health - mobArray[i][8][2]
				playerDamage = true
			end
		else
			mobArray[i][12][5] = false
			mobArray[i][8][1] = mobArray[i][8][1] + 0.01
			playerDamage = false
		end
		if mobArray[i][8][1] <= 0 then
			mob.createMob(i)
		end
		if mobArray[i][8][1] <= 10 then
			mobArray[i][3] = 5
		end
	end

end

function mob.createMobs()

	for i = 1, mob.amount do
		if mobArray[i][6][2] == "mob" then
			if mobArray[i][4] == 1 then
				mobArray[i][6][1] = 1--love.math.random(1, 2)
				mobArray[i][1] = love.math.random(600, 1000)
				mobArray[i][2] = love.math.random(400, 800)
			elseif mobArray[i][4] == 2 then
				mobArray[i][6][1] = love.math.random(1, 2)
				mobArray[i][1] = love.math.random(1010, 1500)
				mobArray[i][2] = love.math.random(810, 1300)
			elseif mobArray[i][4] == 3 then
				mobArray[i][6][1] = 2--love.math.random(1, 2)
				mobArray[i][1] = love.math.random(1510, 2000)
				mobArray[i][2] = love.math.random(1310, 1800)
			end											
			changeBehavior = false
			if mobArray[i][6][1] == 1 then
				mobArray[i][7] = images.chicken
				mobArray[i][8][1] = 30
				mobArray[i][8][2] = 0.01
				mobArray[i][11][1] = "Chicken"
			elseif mobArray[i][6][1] == 2 then
				mobArray[i][7] = images.parrot
				mobArray[i][8][1] = 30
				mobArray[i][8][2] = 0.02
				mobArray[i][11][1] = "Parrot"
			end
		end
	end

end

function mob.createMob(mobID)

	if mobArray[mobID][4] == 1 then
		mobArray[mobID][6][1] = 1--love.math.random(1, 2)
		mobArray[mobID][1] = love.math.random(600, 1000)
		mobArray[mobID][2] = love.math.random(400, 800)
	elseif mobArray[mobID][4] == 2 then
		mobArray[mobID][6][1] = love.math.random(1, 2)
		mobArray[mobID][1] = love.math.random(1010, 1500)
		mobArray[mobID][2] = love.math.random(810, 1300)
	elseif mobArray[mobID][4] == 3 then
		mobArray[mobID][6][1] = 2--love.math.random(1, 2)
		mobArray[mobID][1] = love.math.random(1510, 2000)
		mobArray[mobID][2] = love.math.random(1310, 1800)
	end
	if mobArray[mobID][6][1] == 1 then
		mobArray[mobID][7] = images.chicken
		mobArray[mobID][8][1] = 30
		mobArray[mobID][8][2] = 0.02
		mobArray[mobID][11][1] = "Chicken"
	elseif mobArray[mobID][6][1] == 2 then
		mobArray[mobID][7] = images.parrot
		mobArray[mobID][8][1] = 30
		mobArray[mobID][8][2] = 0.1
		mobArray[mobID][11][1] = "Parrot"
	end

end

function mob.behavior(dt)

	for i = 1, mob.amount do
		if mobArray[i][6][2] == "mob" then
			if (math.floor((mapX)*-64) + mobArray[i][1]) < 1200 and math.floor((mapY)*-64) + mobArray[i][2] > 0 and changeBehavior == true then
				mobArray[i][3] = love.math.random(1, 4)
			elseif mobArray[i][11][2] == 2 and changeBehavior == true then
				mobArray[i][3] = love.math.random(3, 4)
			end
			if changeBehavior == true then
				mobArray[i][11][2] = 3
				mobArray[i][12][4] = true
			end
			if mobArray[i][3] == 1 and mobArray[i][4] == 3 then --follow player
				mobArray[i][12][1] = (playerX*64)+540
				mobArray[i][12][2] = (playerY*64)+310
				if mobArray[i][12][1] > mobArray[i][1] then mobArray[i][1] = mobArray[i][1] + 1
					mobArray[i][12][3] = "right" end
				if mobArray[i][12][1] < mobArray[i][1] then mobArray[i][1] = mobArray[i][1] - 1
					mobArray[i][12][3] = "left" end
				if mobArray[i][12][2] > mobArray[i][2] then mobArray[i][2] = mobArray[i][2] + 1 end
				if mobArray[i][12][2] < mobArray[i][2] then mobArray[i][2] = mobArray[i][2] - 1 end
			elseif mobArray[i][3] == 2 then --move around a wall
			elseif mobArray[i][3] == 3 then --stay still
			elseif mobArray[i][3] == 4 then --move to a random destination
				if mobArray[i][12][4] == true then
					mobArray[i][12][1] = (mobArray[i][1])+love.math.random(-500, 500)
					mobArray[i][12][2] = (mobArray[i][2])+love.math.random(-500, 500)
					mobArray[i][12][4] = false
				end
				if mobArray[i][12][1] > mobArray[i][1] then mobArray[i][1] = mobArray[i][1] + 1
					mobArray[i][12][3] = "right" end
				if mobArray[i][12][1] < mobArray[i][1] then mobArray[i][1] = mobArray[i][1] - 1
					mobArray[i][12][3] = "left" end
				if mobArray[i][12][2] > mobArray[i][2] then mobArray[i][2] = mobArray[i][2] + 1 end
				if mobArray[i][12][2] < mobArray[i][2] then mobArray[i][2] = mobArray[i][2] - 1 end
			elseif mobArray[i][3] == 5 then --run away from player
				if mobArray[i][4] == 1 or mobArray[i][8][1] <= 10 then
					if mobArray[i][12][4] == true then
						mobArray[i][12][1] = (playerX*64)+love.math.random(-1000, 1000)
						mobArray[i][12][2] = (playerY*64)+love.math.random(-1000, 1000)
						mobArray[i][12][4] = false
					end
					if mobArray[i][12][1] > mobArray[i][1] then mobArray[i][1] = mobArray[i][1] + 1
						mobArray[i][12][3] = "right" end
					if mobArray[i][12][1] < mobArray[i][1] then mobArray[i][1] = mobArray[i][1] - 1
						mobArray[i][12][3] = "left" end
					if mobArray[i][12][2] > mobArray[i][2] then mobArray[i][2] = mobArray[i][2] + 1 end
					if mobArray[i][12][2] < mobArray[i][2] then mobArray[i][2] = mobArray[i][2] - 1 end
				end
			end
		end
	end

	if behaviorTimer > 5 and behaviorTimer < 5.01 then
		changeBehavior = true
	elseif behaviorTimer > 5.02 then
		behaviorTimer = 0
		changeBehavior = false
	end

end

function mob.NPC()

	for i = 1, mob.amount do
		if mobArray[i][12][5] == true then

		end
	end

end

function mob.draw()

	for i = 1, mob.amount do
		if mobArray[i][12][3] == "left" then
			mobArray[i][10][1] = 3
			mobArray[i][10][3] = 0
		elseif mobArray[i][12][3] == "right" then
			mobArray[i][10][1] = -3
			mobArray[i][10][3] = 100
		end

        if mobArray[i][12][5] == true and love.mouse.isDown(1) and inmenu == false and weaponType == "melee" then
            love.graphics.setColor(255, 0, 0)
            mobArray[i][8][1] = mobArray[i][8][1] - 0.1
            if mobArray[i][4] == 1 then
            	mobArray[i][3] = 5
            elseif mobArray[i][4] == 3 and mobArray[i][8][1] > 10 then
            	mobArray[i][1] = mobArray[i][1] + love.math.random(-5, 5)
            	mobArray[i][2] = mobArray[i][2] + love.math.random(-3, 3)
            	mobArray[i][3] = 1
            elseif mobArray[i][4] == 2 then
            	mobArray[i][4] = 3
            	mobArray[i][1] = mobArray[i][1] + love.math.random(-5, 5)
            	mobArray[i][2] = mobArray[i][2] + love.math.random(-3, 3)
            	mobArray[i][3] = 1
            end
        else
            love.graphics.setColor(255, 255, 255)
        end

		love.graphics.draw(mobArray[i][7], math.floor((mapX)*-64) + mobArray[i][1] + mobArray[i][10][3], math.floor((mapY)*-64) + mobArray[i][2], 0, mobArray[i][10][1], mobArray[i][10][2])

		if mobArray[i][6][2] == "npc" then
			love.graphics.setColor(30, 30, 30)
			love.graphics.print(mobArray[i][11][1], math.floor((mapX)*-64) + mobArray[i][1] + 35, math.floor((mapY)*-64) + mobArray[i][2] + 70)
		end

		love.graphics.setColor(255, 255, 255)
	end

end

function UPDATE_MOB(dt)

	if createMobs == true then
		mob.createMobs()
		createMobs = false
	end
	mob.NPC()
	mob.update(dt)
	mob.behavior(dt)

end

function DRAW_MOB()

	mob.draw()

end