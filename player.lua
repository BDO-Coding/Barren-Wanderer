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

    animeDelayW = 0.4
    animeDelayA = 0.4
    animeDelayS = 0.4
    animeDelayD = 0.4

    alternateW = true
    alternateA = true
    alternateS = true
    alternateD = true

end

function player.update(dt)

    if love.keyboard.isDown("a")then
	    animeDelayA = animeDelayA - dt
    elseif love.keyboard.isDown("d")then
        animeDelayD = animeDelayD - dt
    elseif love.keyboard.isDown("w")then
        animeDelayW = animeDelayW - dt
    elseif love.keyboard.isDown("s")then
        animeDelayS = animeDelayS - dt
    end


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

    if love.keyboard.isDown("s") and alternateS == true then
        playerImage = images.playerDownAnime
        playerSizeX = 2
        playerScreenX = 560
        if animeDelayS <= 0 then
            alternateS = false
            animeDelayS = 0.4
        end
    elseif love.keyboard.isDown("s") and alternateS == false then
        playerImage = images.playerDownAnime
        playerSizeX = -2
        playerScreenX = 625
        if animeDelayS <= 0 then
            alternateS = true
            animeDelayS = 0.4
        end
    end

    if love.keyboard.isDown("a") and alternateA == true then
        playerImage = images.playerDownAnime
        playerSizeX = -2
        playerScreenX = 620
        if animeDelayA <= 0 then
            alternateA = false
            animeDelayA = 0.4
        end
    elseif love.keyboard.isDown("a") and alternateA == false then
        playerImage = images.playerSide
        playerSizeX = -2
        playerScreenX = 620
        if animeDelayA <= 0 then
            alternateA = true
            animeDelayA = 0.4
        end
    end

    if love.keyboard.isDown("d") and alternateD == true then
        playerImage = images.playerDownAnime
        playerSizeX = 2
        playerScreenX = 560
        if animeDelayD <= 0 then
            alternateD = false
            animeDelayD = 0.4
        end
    elseif love.keyboard.isDown("d") and alternateD == false then
        playerImage = images.playerSide
        playerSizeX = 2
        playerScreenX = 560
        if animeDelayD <= 0 then
            alternateD = true
            animeDelayD = 0.4
        end
    end

    function love.keyreleased(releaseImage)
        if releaseImage == "a" or releaseImage == "s" or releaseImage == "d" then
            playerImage = images.playerDown
            playerSizeX = 2
            playerScreenX = 560
        end
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