mob={}
require "images"
require "conversation"
require "player"
require "item"

function mob.load()

	mob.amount = 10000
	behaviorTimer = 5
	changeBehavior = true
	createMobs = true
	EPressed = false
	waitBag = 0
	selectNum = 0
	mobUnselected = true

	mobArray = {{}}
	mobArray[1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Behaviour 3]], love.math.random(1, 3)--[[Temperament 4]], 1--[[Speed 5]], {1,"mob"}--[[Type Array 6]], images.chicken--[[Image 7]], {30, 0.1}--[[Health & Damage 8]], {2}--[[Drops 9]], {3, 3, 0}--[[Size Array 10]], {"Chicken", 1}--[[Name & Creation 11]], {1, 1, "left", true, false}--[[Destination Array 12]], 1--[[Accuracy 13]]}

	for i = 1, mob.amount do
		mobArray[#mobArray + 1] = {1--[[X position 1]], 100--[[Y position 2]], 1--[[Behaviour 3]], love.math.random(1, 3)--[[Temperament 4]], 1--[[Speed 5]], {1,"mob"}--[[Type Array 6]], images.chicken--[[Image 7]], {30, 0.1}--[[Health & Damage 8]], {2}--[[Drops 9]], {3, 3, 0}--[[Size Array 10]], {"Chicken", 1}--[[Name & Creation 11]], {1, 1, "left", true, false}--[[Destination Array 12]], 1--[[Accuracy 13]]}
	end

	dropArray = {{}}--[[1 = Drops & Selected, 2 = Timer, 4 = X & Y, 5 = inBag]]
	dropsActive = {}

	--[[Temperament (4) 1 is passive
		Temperament (4) 2 is neutral
		Temperament (4) 3 is aggressive]]

end

function mob.contains(array, value)

	if array[value] == value then 
		return true
	end
    return false

end

function mob.update(dt)

	behaviorTimer = behaviorTimer + dt

	for i = 1, mob.amount do
		if mobArray[i][1] > (playerX*64)+510 and mobArray[i][1] < (playerX*64)+570 and mobArray[i][2] > (playerY*64)+280 and mobArray[i][2] < (playerY*64)+330 then
			mobArray[i][12][5] = true
			if mobArray[i][4] == 3 then
				health = health - mobArray[i][8][2]
			end
		else
			mobArray[i][12][5] = false
			mobArray[i][8][1] = mobArray[i][8][1] + 0.01
		end
		if mob.contains(dropsActive, i) == true then
			dropArray[i][2] = dropArray[i][2] - dt
			if dropArray[i][2] <= 0 then
				dropsActive[i] = 0
			end
		end
		if mobArray[i][8][1] <= 0 then
			dropArray[i] = {{{}}, 20, {mobArray[i][1] + 35, mobArray[i][2] + 50}, false}
			for j = 1, #mobArray[i][9] do
				dropArray[i][1][j] = {mobArray[i][9][j], false}
			end
			dropsActive[i] = i
			mob.createMob(i)
		end
		if mobArray[i][8][1] <= mobArray[i][8][1]/5 then
			mobArray[i][3] = 5
		end
	end

end

function mob.createMobs()

	for i = 1, mob.amount do
		if mobArray[i][6][2] == "mob" then
			if mobArray[i][4] == 1 then
				mobArray[i][6][1] = love.math.random(1, 2)
				mobArray[i][1] = love.math.random(600, 50000)
				mobArray[i][2] = love.math.random(400, 50000)
			elseif mobArray[i][4] == 2 then
				mobArray[i][6][1] = love.math.random(3, 3)
				mobArray[i][1] = love.math.random(600, 50000)
				mobArray[i][2] = love.math.random(400, 50000)
			elseif mobArray[i][4] == 3 then
				mobArray[i][6][1] = love.math.random(4, 4)
				mobArray[i][1] = love.math.random(600, 100000)
				mobArray[i][2] = love.math.random(400, 100000)
			end
			if mobArray[i][6][1] == 1 then
				mobArray[i][7] = images.chicken
				mobArray[i][8][1] = 5
				mobArray[i][8][2] = 0.01
				mobArray[i][11][1] = "Chicken"
				mobArray[i][13] = 3
			elseif mobArray[i][6][1] == 2 then
				mobArray[i][7] = images.worm
				mobArray[i][8][1] = 2
				mobArray[i][8][2] = 0
				mobArray[i][11][1] = "Worm"
				mobArray[i][13] = 3
			elseif mobArray[i][6][1] == 3 then
				mobArray[i][7] = images.parrot
				mobArray[i][8][1] = 10
				mobArray[i][8][2] = 0.02
				mobArray[i][11][1] = "Parrot"
				mobArray[i][13] = 4
			elseif mobArray[i][6][1] == 4 then
				mobArray[i][7] = images.evilworm
				mobArray[i][8][1] = 3
				mobArray[i][8][2] = 0.05
				mobArray[i][11][1] = "Evil Worm"
				mobArray[i][13] = 6
			end
		end
	end

end

function mob.createMob(i)

	if mobArray[i][4] == 1 then
		mobArray[i][6][1] = love.math.random(1, 2)
		mobArray[i][1] = love.math.random(600, 50000)
		mobArray[i][2] = love.math.random(400, 50000)
	elseif mobArray[i][4] == 2 then
		mobArray[i][6][1] = love.math.random(3, 3)
		mobArray[i][1] = love.math.random(600, 50000)
		mobArray[i][2] = love.math.random(400, 50000)
	elseif mobArray[i][4] == 3 then
		mobArray[i][6][1] = love.math.random(4, 4)
		mobArray[i][1] = love.math.random(600, 100000)
		mobArray[i][2] = love.math.random(400, 100000)
	end
	if mobArray[i][6][1] == 1 then
		mobArray[i][7] = images.chicken
		mobArray[i][8][1] = 5
		mobArray[i][8][2] = 0.01
		mobArray[i][11][1] = "Chicken"
		mobArray[i][13] = 3
		mobArray[i][9][1] = 5
	elseif mobArray[i][6][1] == 2 then
		mobArray[i][7] = images.worm
		mobArray[i][8][1] = 2
		mobArray[i][8][2] = 0
		mobArray[i][11][1] = "Worm"
		mobArray[i][13] = 3
	elseif mobArray[i][6][1] == 3 then
		mobArray[i][7] = images.parrot
		mobArray[i][8][1] = 10
		mobArray[i][8][2] = 0.02
		mobArray[i][11][1] = "Parrot"
		mobArray[i][13] = 4
	elseif mobArray[i][6][1] == 4 then
		mobArray[i][7] = images.evilworm
		mobArray[i][8][1] = 3
		mobArray[i][8][2] = 0.05
		mobArray[i][11][1] = "Evil Worm"
		mobArray[i][13] = 6
	end

end

function mob.drops()

	for i = 1, mob.amount do
		if mob.contains(dropsActive, i) == true then
			love.graphics.setColor(255, 255, 255)
			love.graphics.draw(images.bag, math.floor((mapX)*-64) + dropArray[i][3][1], math.floor((mapY)*-64) + dropArray[i][3][2])
			if playerScreenX > math.floor((mapX)*-64) + dropArray[i][3][1] - 30 and playerScreenX < math.floor((mapX)*-64) + dropArray[i][3][1] + 30 and playerScreenY > math.floor((mapY)*-64) + dropArray[i][3][2] - 30 and playerScreenY < math.floor((mapY)*-64) + dropArray[i][3][2] + 30 then 
				if love.keyboard.isDown("e") and waitBag == 0 then
					EPressed = true
					waitBag = 40
				else
					love.graphics.setColor(30, 30, 30)
					love.graphics.print("Press 'e' to open", math.floor((mapX)*-64) + dropArray[i][3][1] - 23, math.floor((mapY)*-64) + dropArray[i][3][2] + 30)
				end
				love.graphics.setColor(255,255,255)
				if EPressed == true then
					dropArray[i][5] = not dropArray[i][5]
					EPressed = false
				end
				if waitBag > 0 then
					waitBag = waitBag - 1
				end
				if dropArray[i][5] == true then
					love.graphics.draw(images.crafting,350,50,0,1,1)
					love.graphics.print("Drops:",437,110)
					love.graphics.print("Stats:",648,110)
					inCrafting = false
					if mobUnselected == true then
						love.graphics.print("Select an item by clicking on it.",572,140)
					end
					for j = 1, #dropArray[i][1] do
						if love.mouse.getX() > 385 and love.mouse.getX() < 525 then
							if love.mouse.getY() > 110 + (10*j) and love.mouse.getY() < 140 + (10*j) and love.mouse.isDown(1) then
								dropArray[i][1][j][2] = true
								mobUnselected = false
							elseif love.mouse.getY() < 110 + (10*j) or love.mouse.getY() > 140 + (10*j) then
								if love.mouse.isDown(1) then
									dropArray[i][1][j][2] = false
									mobUnselected = true
								end
							end
						end
						if dropArray[i][1][j][2] == true then
							love.graphics.setColor(30,255,30)
						else
							love.graphics.setColor(255,255,255)
						end
						love.graphics.print(item.getItemName(dropArray[i][1][j][1]),450, 128+((j-1)*10))
						love.graphics.setColor(255,255,255)
						love.graphics.draw(item.getItemImage(dropArray[i][1][j][1]),420,128+((j-1)*10),0,0.75,0.75)
					end
				end
			elseif dropArray[i][5] == true then
				dropArray[i][5] = false
			end
			if playerScreenX > math.floor((mapX)*-64) + dropArray[i][3][1] - 30 and playerScreenX < math.floor((mapX)*-64) + dropArray[i][3][1] + 30 and playerScreenY > math.floor((mapY)*-64) + dropArray[i][3][2] - 30 and playerScreenY < math.floor((mapY)*-64) + dropArray[i][3][2] + 30 then else
				mobUnselected = true
				for j = 1, #dropArray[i][1] do
					dropArray[i][1][j][2] = false
				end
			end
			--[[for j = 1, #dropArray[i][1] do
				if dropArray[i][1][j][2] == true then
					selectNum = 0
				else
					selectNum = selectNum + 1
				end
			end
			if selectNum == #dropArray[i][1] then
				mobUnselected = true
			end]]
		end
	end

end

function mob.behavior(dt)

	for i = 1, mob.amount do
		if mobArray[i][6][2] == "mob" then
			if (math.floor((mapX)*-64) + mobArray[i][1]) < 1200 and math.floor((mapY)*-64) + mobArray[i][2] > -100 and (math.floor((mapX)*-64) + mobArray[i][1]) > -100 and math.floor((mapY)*-64) + mobArray[i][2] < 750 and changeBehavior == true then
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
					mobArray[i][2] = mobArray[i][2] + love.math.random(-mobArray[i][13], mobArray[i][13])
					mobArray[i][12][3] = "right" end
				if mobArray[i][12][1] < mobArray[i][1] then mobArray[i][1] = mobArray[i][1] - 1
					mobArray[i][2] = mobArray[i][2] + love.math.random(-mobArray[i][13], mobArray[i][13])
					mobArray[i][12][3] = "left" end
				if mobArray[i][12][2] > mobArray[i][2] then mobArray[i][2] = mobArray[i][2] + 1
					mobArray[i][1] = mobArray[i][1] + love.math.random(-mobArray[i][13], mobArray[i][13])
				end
				if mobArray[i][12][2] < mobArray[i][2] then mobArray[i][2] = mobArray[i][2] - 1
					mobArray[i][1] = mobArray[i][1] + love.math.random(-mobArray[i][13], mobArray[i][13])
				end
			elseif mobArray[i][3] == 2 then --move around a wall
			elseif mobArray[i][3] == 3 then --stay still
			elseif mobArray[i][3] == 4 then --move to a random destination
				if mobArray[i][12][4] == true then
					mobArray[i][12][1] = (mobArray[i][1])+love.math.random(-500, 500)
					mobArray[i][12][2] = (mobArray[i][2])+love.math.random(-500, 500)
					mobArray[i][12][4] = false
				end
				if mobArray[i][12][1] > mobArray[i][1] then mobArray[i][1] = mobArray[i][1] + 1
					mobArray[i][2] = mobArray[i][2] + love.math.random(-mobArray[i][13], mobArray[i][13])
					mobArray[i][12][3] = "right" end
				if mobArray[i][12][1] < mobArray[i][1] then mobArray[i][1] = mobArray[i][1] - 1
					mobArray[i][2] = mobArray[i][2] + love.math.random(-mobArray[i][13], mobArray[i][13])
					mobArray[i][12][3] = "left" end
				if mobArray[i][12][2] > mobArray[i][2] then mobArray[i][2] = mobArray[i][2] + 1
					mobArray[i][1] = mobArray[i][1] + love.math.random(-mobArray[i][13], mobArray[i][13])
				end
				if mobArray[i][12][2] < mobArray[i][2] then mobArray[i][2] = mobArray[i][2] - 1
					mobArray[i][1] = mobArray[i][1] + love.math.random(-mobArray[i][13], mobArray[i][13])
				end
			elseif mobArray[i][3] == 5 then --run away from player
				if mobArray[i][4] == 1 or mobArray[i][8][1] <= 10 then
					if mobArray[i][12][4] == true then
						mobArray[i][12][1] = (playerX*64)+love.math.random(-1000, 1000)
						mobArray[i][12][2] = (playerY*64)+love.math.random(-1000, 1000)
						mobArray[i][12][4] = false
					end
					if mobArray[i][12][1] > mobArray[i][1] then mobArray[i][1] = mobArray[i][1] + 1
						mobArray[i][2] = mobArray[i][2] + love.math.random(-mobArray[i][13], mobArray[i][13])
						mobArray[i][12][3] = "right" end
					if mobArray[i][12][1] < mobArray[i][1] then mobArray[i][1] = mobArray[i][1] - 1
						mobArray[i][2] = mobArray[i][2] + love.math.random(-mobArray[i][13], mobArray[i][13])
						mobArray[i][12][3] = "left" end
					if mobArray[i][12][2] > mobArray[i][2] then mobArray[i][2] = mobArray[i][2] + 1
						mobArray[i][1] = mobArray[i][1] + love.math.random(-mobArray[i][13], mobArray[i][13])
					end
					if mobArray[i][12][2] < mobArray[i][2] then mobArray[i][2] = mobArray[i][2] - 1
						mobArray[i][1] = mobArray[i][1] + love.math.random(-mobArray[i][13], mobArray[i][13])
					end
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

        if mobArray[i][12][5] == true and love.mouse.isDown(1) and inmenu == false and currentWeapon[2] == "melee" and inCrafting == false and mobUnselected == true then
            love.graphics.setColor(255, 0, 0)
            mobArray[i][8][1] = mobArray[i][8][1] - currentWeapon[5]
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

        if (math.floor((mapX)*-64) + mobArray[i][1]) < 1200 and math.floor((mapY)*-64) + mobArray[i][2] > -100 and (math.floor((mapX)*-64) + mobArray[i][1]) > -100 and math.floor((mapY)*-64) + mobArray[i][2] < 750 then
			love.graphics.draw(mobArray[i][7], math.floor((mapX)*-64) + mobArray[i][1] + mobArray[i][10][3], math.floor((mapY)*-64) + mobArray[i][2], 0, mobArray[i][10][1], mobArray[i][10][2])
		end

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
	if inmenu == false then
		mob.NPC()
		mob.update(dt)
		mob.behavior(dt)
	end

end

function DRAW_MOB()

	mob.draw()
	if inmenu == false then
		mob.drops()
	end

end