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
	animeDelay = 1000
    aAlternate = true

end

function player.update(dt)

	animeDelay = animeDelay - dt

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

    if love.keyboard.isDown("a") and aAlternate == true then
        playerImage = images.playerDown
        playerSizeX = -2
        playerScreenX = 620
        for i = 0, 1000, 1 do
            animeDelay = animeDelay - 1
            print(i, aAlternate)
            if i < 1 then
                aAlternate = false
                animeDelay = 1000
                print("hi")
                break
            end
        end
    elseif love.keyboard.isDown("a") and aAlternate == false then
        playerImage = images.playerSide
        playerSizeX = -2
        playerScreenX = 620
        for i = 0, 1000, 1 do
            animeDelay = animeDelay - 1
        end
        if k == 0 then
            aAlternate = true
            animeDelay = 1000
        end
    end

    --[[function love.keypressed(aKey)
        if aKey == "a" and aAlternate == true then
            playerImage = images.playerSide
            playerSizeX = -2
            playerScreenX = 620
            aAlternate = false
        elseif aKey == "a" and aAlternate == false then
            playerImage = images.playerDown
            playerSizeX = -2
            playerScreenX = 620
            aAlternate = true
        end
    end]]

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

function UPDATE_PLAYER(dt)

	player.update(dt)

end

function DRAW_PLAYER()

	player.draw()

end