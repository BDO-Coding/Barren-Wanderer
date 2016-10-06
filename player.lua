player={}

function player.load()

end

function player.update()

end

function player.draw()

	playerDown = love.graphics.newImage("images/playerDown.png")
	love.graphics.draw(playerDown, 570, 350, 0, 2, 2)

end

function UPDATE_PLAYER()

	player.update()

end

function DRAW_PLAYER()

	player.draw()

end