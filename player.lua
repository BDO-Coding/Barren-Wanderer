player={}
require"images"

function player.load()

	playerSpeed = 0.002
	playerSpeedDiagonal = 0.001
	doOnce = true
	playerSizeX = 2
	playerSizeY = 2
	playerScreenX = 560
	playerScreenY = 350

end

function player.update()

end

function player.draw()

	if doOnce == true then
		playerImage = images.playerDown
		doOnce = false
	end

	if love.keyboard.isDown("w") then
       	playerImage = images.playerUp
       	playerSizeX = 2
       	playerScreenX = 560
    end

    if love.keyboard.isDown("s") then
        playerImage = images.playerDown
        playerSizeX = 2
        playerScreenX = 560
    end

    if love.keyboard.isDown("a") then
    	playerImage = images.playerSide
    	playerSizeX = -2
    	playerScreenX = 620
    end

    if love.keyboard.isDown("d") then
    	playerImage = images.playerSide
    	playerSizeX = 2
    	playerScreenX = 560
    end

    if love.keyboard.isDown("lctrl") then
    	playerSpeed = 0.004
    	playerSpeedDiagonal = 0.003
    else
    	playerSpeed = 0.002
    	playerSpeedDiagonal = 0.001
    end

	love.graphics.draw(playerImage, playerScreenX, playerScreenY, 0, playerSizeX, playerSizeY)

end

function UPDATE_PLAYER()

	player.update()

end

function DRAW_PLAYER()

	player.draw()

end