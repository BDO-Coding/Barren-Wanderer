monster={}

function monster.load()

	monster.amount = love.math.random(2, 10)

	monsterArray = {{}}
	monsterArray[1] = {1--[[X position 1]], 1--[[Y position 2]], 1--[[Random Move 3]], 1--[[Random Track 4]], 1--[[Speed 5]], 1--[[Type 6]], images.playerDown--[[Image 7]], 1--[[Health 8]], 1--[[Drops 9]], 1--[[Size 10]]}

	for i = 1, monster.amount do
		monsterArray[#monsterArray + 1] = {1--[[X position 1]], 1--[[Y position 2]], 1--[[Random Move 3]], 1--[[Random Track 4]], 1--[[Speed 5]], 1--[[Type 6]], images.playerDown--[[Image 7]], 1--[[Health 8]], 1--[[Drops 9]], 1--[[Size 10]]}
	end

end

function monster.update(dt)

end

function monster.draw()

end

function UPDATE_MONSTER(dt)

	monster.update(dt)

end

function DRAW_MONSTER()

	monster.draw()

end