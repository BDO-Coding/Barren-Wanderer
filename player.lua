player={}

function player.load()

	playerSpeed = 0.002
	playerSpeedDiagonal = 0.001

end

function player.update()

end

function player.draw()

	playerDown = love.graphics.newImage("images/playerDown.png")
	love.graphics.draw(playerDown, 560, 350, 0, 2, 2)

end

function UPDATE_PLAYER()

	player.update()

end

function DRAW_PLAYER()

	player.draw()

end