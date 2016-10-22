player={}
require"images"

function player.load()

	playerSpeed = 0.2 --0.002
	playerSpeedDiagonal = 0.1 -- 0.001
	doOnce = true
	playerSizeX = 2
	playerSizeY = 2
	playerScreenX = 560
	playerScreenY = 350

    animeDelayW = 0.1
    animeDelayA = 0.1
    animeDelayS = 0.1
    animeDelayD = 0.1

    alternateW = true
    alternateA = true
    alternateS = true
    alternateD = true

    playerX = 1
    playerY = 1
    currentBiome = 1

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

    if inmenu == false then

        if love.keyboard.isDown("w") and alternateW == true then
            playerImage = images.playerUpAnimeA
            playerSizeX = 2
            playerScreenX = 560
            if animeDelayW <= 0 then
                alternateW = false
                animeDelayW = 0.4
            end
        elseif love.keyboard.isDown("w") and alternateW == false then
            playerImage = images.playerUpAnimeD
            playerSizeX = 2
            playerScreenX = 560
            if animeDelayW <= 0 then
                alternateW = true
                animeDelayW = 0.4
            end
        end

        if love.keyboard.isDown("s") and alternateS == true then
            playerImage = images.playerDownAnimeA
            playerSizeX = 2
            playerScreenX = 560
            if animeDelayS <= 0 then
                alternateS = false
                animeDelayS = 0.4
            end
        elseif love.keyboard.isDown("s") and alternateS == false then
            playerImage = images.playerDownAnimeD
            playerSizeX = 2
            playerScreenX = 560
            if animeDelayS <= 0 then
                alternateS = true
                animeDelayS = 0.4
            end
        end

        if love.keyboard.isDown("a") and alternateA == true then
            playerImage = images.playerDownAnimeD
            playerSizeX = -2
            playerScreenX = 625
            if animeDelayA <= 0 then
                alternateA = false
                animeDelayA = 0.4
            end
        elseif love.keyboard.isDown("a") and alternateA == false then
            playerImage = images.playerSide
            playerSizeX = -2
            playerScreenX = 625
            if animeDelayA <= 0 then
                alternateA = true
                animeDelayA = 0.4
            end
        end

        if love.keyboard.isDown("d") and alternateD == true then
            playerImage = images.playerDownAnimeD
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
    end

    if love.keyboard.isDown("lctrl") then
    	playerSpeed = 0.004
    	playerSpeedDiagonal = 0.003
    else
    	playerSpeed = 0.002
    	playerSpeedDiagonal = 0.001
    end

    function love.keyreleased(releaseImage)
        if releaseImage == "a" or releaseImage == "s" or releaseImage == "d" and inmenu == false then
            playerImage = images.playerDown
            playerSizeX = 2
            playerScreenX = 560
        elseif releaseImage == "w" and inmenu == false then
            playerImage = images.playerUp
            playerSizeX = 2
            playerScreenX = 560
        elseif releaseImage == "escape" then
        	inmenu = not inmenu
            options = false
        end
    end

	love.graphics.draw(playerImage, playerScreenX, playerScreenY, 0, playerSizeX, playerSizeY)

end

function UPDATE_PLAYER(dt)

	player.update(dt)

end

function DRAW_PLAYER()

	player.draw()

end