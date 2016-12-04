player={}
require "images"
require "utensil"
require "crafting"

function player.load()

	playerSpeed = 0.002 --0.002
	playerSpeedDiagonal = 0.001 -- 0.001
    playerSprint = 2
    playerDefaultSpeed = 0.002
    playerDefaultSpeedDiagonal = 0.001
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

    xScreenMinus = 0
    yScreenMinus = 0
    weaponXOffset = 43
    weaponYOffset = 10
    weaponRotation = 0
    weaponXSize = 2
    imageUp = false
    runWeaponUpdate = true

    maxStamina = 100
    stamina = 100
    staminaRegen = 0.05

    maxHealth = 100
    health = 100
    oldHealth = 100
    healthRegen = 0.01

    maxMana = 0
    mana = 0
    manaRegen = 0.05

    maxHunger = 100
    hunger = 100
    hungerRegen = 0.05

    alive = true
    inventoryMode = false

end

function player.update(dt)

    oldHealth = health

    if love.keyboard.isDown("i") then
        inventoryMode = true
        player.noEscapeKey = true
    end

    if love.keyboard.isDown("escape") then
        inventoryMode = false
    end

    if health < maxHealth and playerDamage == false and inmenu == false then
        health = health + healthRegen
    end

    if mana < maxMana then
        mana = mana + manaRegen
    end

    if love.mouse.isDown(1) and inmenu == false and currentWeapon[2] == "melee" and inCrafting == false and mobUnselected == true then
        weaponRotation = weaponRotation + 0.09817477
        weaponXOffset = 588
        weaponYOffset = 377
        weaponXSize = -2
        xScreenMinus = playerScreenX
        yScreenMinus = playerScreenY
        runWeaponUpdate = true
    elseif inmenu == false then
        weaponRotation = 0
        if runWeaponUpdate == true then
            xScreenMinus = 0
            yScreenMinus = 0
            weaponXSize = 2
            weaponXOffset = 42
            weaponYOffset = 10
            imageUp = false
            runWeaponUpdate = false
        end
    end

    if love.keyboard.isDown("a") then
	    animeDelayA = animeDelayA - dt
        if runWeaponUpdate == false then
            weaponXSize = -2
        end
        imageUp = false
    elseif love.keyboard.isDown("d")then
        animeDelayD = animeDelayD - dt
        if runWeaponUpdate == false then
            weaponXSize = 2
        end
        imageUp = false
    elseif love.keyboard.isDown("w")then
        animeDelayW = animeDelayW - dt
        if runWeaponUpdate == false then
            weaponXSize = -2
        end
        imageUp = true
    elseif love.keyboard.isDown("s")then
        animeDelayS = animeDelayS - dt
        if runWeaponUpdate == false then
            weaponXSize = 2
        end
        imageUp = false
    end

end

function player.draw()

    if oldHealth > health then
        playerDamage = true
    else
        playerDamage = false
    end

    if health <= 0 then
        love.graphics.setColor(255, 0, 0)
        love.graphics.print("Your dead", 400, 400, 0, 6, 6)
        inmenu = true
    end

	if doOnce == true then
		playerImage = images.playerDown
		doOnce = false
	end

    if inmenu == false then

        if love.keyboard.isDown("w") and alternateW == true then
        player.noEscapeKey = false
        inventoryMode = false
            playerImage = images.playerUpAnimeA
            playerSizeX = 2
            playerScreenX = 560
            if runWeaponUpdate == false then
                weaponXOffset = 25
            end
            if animeDelayW <= 0 then
                alternateW = false
                animeDelayW = 0.4
            end
        elseif love.keyboard.isDown("w") and alternateW == false then
            playerImage = images.playerUpAnimeD
            playerSizeX = 2
            playerScreenX = 560
            if runWeaponUpdate == false then
                weaponXOffset = 27
            end
            if animeDelayW <= 0 then
                alternateW = true
                animeDelayW = 0.4
            end
        end

        if love.keyboard.isDown("s") and alternateS == true then
            playerImage = images.playerDownAnimeA
            playerSizeX = 2
            playerScreenX = 560
            if runWeaponUpdate == false then
                weaponXOffset = 43
            end
            if animeDelayS <= 0 then
                alternateS = false
                animeDelayS = 0.4
            end
        elseif love.keyboard.isDown("s") and alternateS == false then
            playerImage = images.playerDownAnimeD
            playerSizeX = 2
            playerScreenX = 560
            if runWeaponUpdate == false then
                weaponXOffset = 41
            end
            if animeDelayS <= 0 then
                alternateS = true
                animeDelayS = 0.4
            end
        end

        if love.keyboard.isDown("a") and alternateA == true then
            playerImage = images.playerDownAnimeD
            playerSizeX = -2
            playerScreenX = 625
            if runWeaponUpdate == false then
                weaponXOffset = -42
            end
            if animeDelayA <= 0 then
                alternateA = false
                animeDelayA = 0.4
            end
        elseif love.keyboard.isDown("a") and alternateA == false then
            playerImage = images.playerSide
            playerSizeX = -2
            playerScreenX = 625
            if runWeaponUpdate == false then
                weaponXOffset = -38
            end
            if animeDelayA <= 0 then
                alternateA = true
                animeDelayA = 0.4
            end
        end

        if love.keyboard.isDown("d") and alternateD == true then
            playerImage = images.playerDownAnimeD
            playerSizeX = 2
            playerScreenX = 560
            if runWeaponUpdate == false then
                weaponXOffset = 42
            end
            if animeDelayD <= 0 then
                alternateD = false
                animeDelayD = 0.4
            end
        elseif love.keyboard.isDown("d") and alternateD == false then
            playerImage = images.playerSide
            playerSizeX = 2
            playerScreenX = 560
            if runWeaponUpdate == false then
                weaponXOffset = 38
            end
            if animeDelayD <= 0 then
                alternateD = true
                animeDelayD = 0.4
            end
        end
    end

    if love.keyboard.isDown("w") or love.keyboard.isDown("a") or love.keyboard.isDown("s") or love.keyboard.isDown("d") then
        if currentTile == 7 then
            playerSpeed = 0.0002
            playerSpeedDiagonal = 0.0001
        end
        if love.keyboard.isDown("lctrl") then
            if stamina >= 0.75 then
            	playerSpeed = playerDefaultSpeed*playerSprint
            	playerSpeedDiagonal = playerDefaultSpeedDiagonal*playerSprint
                stamina = stamina - 0.25
            else
                playerSpeed = playerDefaultSpeed
                playerSpeedDiagonal = playerDefaultSpeedDiagonal
            end
        else
            if stamina < maxStamina then
                stamina = stamina + staminaRegen
                playerSpeed = playerDefaultSpeed
                playerSpeedDiagonal = playerDefaultSpeedDiagonal
            end
        end
    end

    if love.keyboard.isDown("lctrl") then elseif stamina < maxStamina then
        stamina = stamina + staminaRegen
        playerSpeed = playerDefaultSpeed
        playerSpeedDiagonal = playerDefaultSpeedDiagonal
    end
    
    function love.keyreleased(releaseImage)
        if releaseImage == "a" or releaseImage == "s" or releaseImage == "d" and inmenu == false then
            playerImage = images.playerDown
            playerSizeX = 2
            playerScreenX = 560
            weaponXOffset = 42
            weaponXSize = 2
            imageUp = false
        elseif releaseImage == "w" and inmenu == false then
            playerImage = images.playerUp
            playerSizeX = 2
            playerScreenX = 560
            weaponXOffset = 24
            weaponXSize = -2
            imageUp = true
        elseif releaseImage == "escape" then
            if noEscapeKey ~= true then
        	if ingame == true then
        		inmenu = not inmenu
        	end
        end
        end
    end

    weaponXLoc = playerScreenX-xScreenMinus
    weaponYLoc = playerScreenY-yScreenMinus

    if playerDamage == true then
        love.graphics.setColor(255, 0, 0)
    else
        love.graphics.setColor(255, 255, 255)
    end

    if imageUp == true and not love.mouse.isDown(1) then
        love.graphics.draw(currentWeapon[4], playerScreenX+weaponXOffset, playerScreenY+weaponYOffset, weaponRotation, weaponXSize, playerSizeY)
        love.graphics.draw(playerImage, playerScreenX, playerScreenY, 0, playerSizeX, playerSizeY)
    else
        love.graphics.draw(playerImage, playerScreenX, playerScreenY, 0, playerSizeX, playerSizeY)
        love.graphics.draw(currentWeapon[4], weaponXLoc+weaponXOffset, weaponYLoc+weaponYOffset, weaponRotation, weaponXSize, playerSizeY)
    end

    love.graphics.setColor(255, 255, 255)

end

function UPDATE_PLAYER(dt)

	player.update(dt)

end

function DRAW_PLAYER()

	player.draw()

end