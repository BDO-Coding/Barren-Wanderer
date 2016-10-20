menu = {}

local utf8 = require("utf8")

local menuMap -- stores tiledata
local menuMapWidth, menuMapHeight -- width and height in tiles
 
local menuMapX, menuMapY -- view x,y in tiles. can be a fractional value like 3.25.
 
local tilesDisplayWidth, tilesDisplayHeight -- number of tiles to show
local zoomX, zoomY
 
local tilesetImage
local tileSize -- size of tiles in pixels
local tileQuads = {} -- parts of the tileset used for different tiles
local tilesetSprite

function menu.load()

    worldSeed = "0000"

    options = false
    credits = false
    newgame = false
    loading = false

    worldName = "World"
    worldNameType = false
    worldNameNum = 5
    worldSeedType = false
    worldSeedNum = 4

    worldLoadType = false
    worldLoadName = "World"
    worldLoadNum = 5

    loadScreen = false
    loadDelay = 10

    doLoadScreen = true

    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()

    menuPlayerImage = images.playerDown
    playerImageDelay = 4
    playerImageSizeX = 30
    playerImageSizeY = 30
    playerImageX = 500
    playerImageY = -100

    moveSpeed = 0.001
    moveTime = 0.001
    moveDelay = 20

    menu.setupMap()
    menu.setupMapView()
    menu.setupTileset()

    fps_show = false
    version_show = false
    volume = 50
    seed_show = false

    love.keyboard.setKeyRepeat(true)

end

function menu.draw()

    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()

    if ingame == false then

        love.graphics.draw(tilesetBatch, math.floor(-zoomX*(menuMapX%1)*tileSize), math.floor(-zoomY*(menuMapY%1)*tileSize), 0, zoomX, zoomY)

        love.graphics.setColor(0, 255, 255)
        love.graphics.rotate(5.84685)
        love.graphics.rectangle("fill", -40, 145, 335, 60, 10)
        love.graphics.rotate(-5.84685)
        love.graphics.setColor(255, 0, 0)
        love.graphics.print("Barren World", 30, 150, 5.84685, 4, 4)
         
    end

    if inmenu == true and options == false and newgame == false and ingame == false and credits == false and loading == false then

        if mouseX > 170 and mouseX < 390 and mouseY > 150 and mouseY < 210 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 150, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 150, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 250 and mouseY < 310 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 250, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 250, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 350 and mouseY < 410 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 350, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 350, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 450 and mouseY < 510 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 450, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 450, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 170, 150, 220, 60)
        love.graphics.rectangle("line", 170, 250, 220, 60)
        love.graphics.rectangle("line", 170, 350, 220, 60)
        love.graphics.rectangle("line", 170, 450, 220, 60)

        love.graphics.print("New Game", 218, 160, 0, 2, 3)
        love.graphics.print("Load Game", 214, 260, 0, 2, 3)
        love.graphics.print("Options", 232, 360, 0, 2, 3)
        love.graphics.print("Credits", 235, 460, 0, 2, 3)

        if playerImageDelay > 3 then
            menuPlayerImage = images.playerDownHiRes
            playerImageSizeX = 1
            playerImageSizeY = 1
            playerImageX = 600
            playerImageY = 20
        elseif playerImageDelay > 2 then
            menuPlayerImage = images.playerSideHiRes
            playerImageSizeX = 30
            playerImageSizeY = 30
            playerImageX = 400
            playerImageY = -100
        elseif playerImageDelay > 1 then
            menuPlayerImage = images.playerUpHiRes
            playerImageSizeX = 30
            playerImageSizeY = 30
            playerImageX = 400
            playerImageY = -100
        elseif playerImageDelay > 0 then
            menuPlayerImage = images.playerSideHiRes
            playerImageSizeX = -30
            playerImageSizeY = 30
            playerImageX = 1350
            playerImageY = -100
        elseif playerImageDelay > -1 then
            playerImageDelay = 4
        end

        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(menuPlayerImage, playerImageX, playerImageY, 0, playerImageSizeX, playerImageSizeY)

    end

    if inmenu == true and options == false and ingame == true then

        if mouseX > 500 and mouseX < 720 and mouseY > 150 and mouseY < 210 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 500, 150, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 500, 150, 220, 60)
        end

        if mouseX > 500 and mouseX < 720 and mouseY > 250 and mouseY < 310 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 500, 250, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 500, 250, 220, 60)
        end        

        if mouseX > 500 and mouseX < 720 and mouseY > 350 and mouseY < 410 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 500, 350, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 500, 350, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 500, 150, 220, 60)
        love.graphics.rectangle("line", 500, 250, 220, 60)
        love.graphics.rectangle("line", 500, 350, 220, 60)

        love.graphics.print("Resume", 562, 160, 0, 2, 3)
        love.graphics.print("Options", 562, 260, 0, 2, 3)
        love.graphics.print("Save", 580, 360, 0, 2, 3)

    end 

    if credits == true then
        love.graphics.setColor(0, 255, 255)
        love.graphics.rectangle("fill", 300, 100, 800, 390, 10)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Coded by: \n         Danny Harris, Benjamin Broadbent and Ori Taylor", 320, 120, 0, 2, 2)
        love.graphics.print("Art by: \n         Danny Harris, Benjamin Broadbent and Ori Taylor", 320, 200, 0, 2, 2)
        love.graphics.print("Sound by: \n         Nobody", 320, 280, 0, 2, 2)
        love.graphics.print("Programs used: \n         LÖVE for Lua\n         paint.net\n         Sublime Text", 320, 360, 0, 2, 2)

        if mouseX > 170 and mouseX < 390 and mouseY > 500 and mouseY < 560 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        end
    end

end

function menu.setupMap()

    menuMapWidth = 280
    menuMapHeight = 220

    menuMap = {}
    --Random Gen
    for x=1, menuMapWidth do
        menuMap[x] = {}
        for y=1, menuMapHeight do
           menuMap[x][y] = love.math.random(0,13)
        end
    end
    --Pro Gen
    for x=1, menuMapWidth do
        for y=1, menuMapHeight do
            if menuMap[x][y] == 2 then
                menuMap[x][y] = 2 
            end
        end
    end
end
 
function menu.setupMapView()

    menuMapX = 1
    menuMapY = 1
    tilesDisplayWidth = 26
    tilesDisplayHeight = 26

    zoomX = 2
    zoomY = 2 -----------------------------------------------------------------USEFUL

end

function menu.setupTileset()

    tilesetImage = love.graphics.newImage("images/tileset.png")
    tilesetImage:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
    tileSize = 32

    -- Ocean
    tileQuads[0] = love.graphics.newQuad(0 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    orar = 1

    --Sand
    tileQuads[1] = love.graphics.newQuad(1 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    --River
    tileQuads[2] = love.graphics.newQuad(2 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    -- Mountain2
    tileQuads[3] = love.graphics.newQuad(3 * tileSize, 0 * tileSize, tileSize, tileSize, -- 4 0, x - y in a 32-32 grid 
    tilesetImage:getWidth(), tilesetImage:getHeight())
    -- Mountain3
    tileQuads[4] = love.graphics.newQuad(4 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    --Mountain1
    tileQuads[5] = love.graphics.newQuad(5 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    --HotSand
    tileQuads[6] = love.graphics.newQuad(6 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    --Quicksand
    tileQuads[7] = love.graphics.newQuad(7 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    --Grass1
    tileQuads[8] = love.graphics.newQuad(8 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    --Grass2
    tileQuads[9] = love.graphics.newQuad(9 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    --Grass3
    tileQuads[10] = love.graphics.newQuad(10 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    --Tree1
    tileQuads[11] = love.graphics.newQuad(11 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    --Tree2
    tileQuads[12] = love.graphics.newQuad(12 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    --JungleTree
    tileQuads[13] = love.graphics.newQuad(13 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())        

    tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, tilesDisplayWidth * tilesDisplayHeight)

    menu.updateTilesetBatch()

end

function menu.updateTilesetBatch()

    tilesetBatch:clear()
    for x=0, tilesDisplayWidth-1 do
        for y=0, tilesDisplayHeight-1 do
            tilesetBatch:add(tileQuads[menuMap[x+math.floor(menuMapX)][y+math.floor(menuMapY)]],
            x*tileSize, y*tileSize)
        end
    end
    tilesetBatch:flush()

end

function menu.moveMap(dx, dy)

    menuOldMapX = menuMapX
    menuOldMapY = menuMapY
    menuMapX = math.max(math.min(menuMapX + dx, menuMapWidth - tilesDisplayWidth), 1)
    menuMapY = math.max(math.min(menuMapY + dy, menuMapHeight - tilesDisplayHeight), 1)
    -- only update if we actually moved
    if math.floor(menuMapX) ~= math.floor(menuOldMapX) or math.floor(menuMapY) ~= math.floor(menuOldMapY) then
        menu.updateTilesetBatch()
    end

end

function menu.update(dt)

    if doLoadScreen == true or loadScreen == true then
        if love.keyboard.isDown("x")then
            doLoadScreen = false
            loadDelay = 0.5
        end
    end

    if loadScreen == true then
        loadDelay = loadDelay - dt
    elseif ingame == false then
        moveDelay = moveDelay - moveTime
        playerImageDelay = playerImageDelay - dt

        if moveDelay > 15 then
            menu.moveMap(moveSpeed * tileSize, 0)
        elseif moveDelay > 10 then
            menu.moveMap(0, moveSpeed * tileSize)
        elseif moveDelay > 5 then
            menu.moveMap(-moveSpeed * tileSize, 0)
        elseif moveDelay > 0 then
            menu.moveMap(0, -moveSpeed * tileSize)
        elseif moveDelay < 0 then
            moveDelay = 20
        end
    end

end

function menu.newgame()

    if newgame == true then

        if mouseX > 170 and mouseX < 840 and mouseY > 200 and mouseY < 260 then -- World Name
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 200, 670, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 200, 670, 60)
        end

        if mouseX > 170 and mouseX < 840 and mouseY > 280 and mouseY < 340 then -- World Seed
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 280, 670, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 280, 670, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 360 and mouseY < 420 then -- Create World
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 360, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 360, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 500 and mouseY < 560 then -- Back
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        end

        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", 360, 205, 475, 50)
        love.graphics.rectangle("fill", 355, 285, 480, 50)

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 170, 200, 670, 60)
        love.graphics.rectangle("line", 170, 280, 670, 60)
        love.graphics.rectangle("line", 170, 360, 220, 60)

        if worldNameType == true then
            love.graphics.print("World Name-: "..worldName, 190, 210, 0, 2, 3)
        else
            love.graphics.print("World Name : "..worldName, 190, 210, 0, 2, 3)
        end

        if worldSeedType == true then
            love.graphics.print("World Seed-: "..worldSeed, 190, 290, 0, 2, 3)
        else
            love.graphics.print("World Seed : "..worldSeed, 190, 290, 0, 2, 3)
        end
        
        love.graphics.print("Create World", 200, 370, 0, 2, 3)

        if worldNameNum > 20 then
            local byteoffset = utf8.offset(worldName, -1)
     
            if byteoffset then
                worldName = string.sub(worldName, 1, byteoffset - 1)
            end
            worldNameNum = worldNameNum - 1
        end

        if worldSeedNum > 30 then
            local byteoffset = utf8.offset(worldSeed, -1)
     
            if byteoffset then
                worldSeed = string.sub(worldSeed, 1, byteoffset - 1)
            end
            worldSeedNum = worldSeedNum - 1
        end

    end

    function love.keypressed(backKey)

        if backKey == "backspace" and worldNameType == true and newgame == true then
            local byteoffset = utf8.offset(worldName, -1)
     
            if byteoffset then
                worldName = string.sub(worldName, 1, byteoffset - 1)
            end
            if worldNameNum > 0 then
                worldNameNum = worldNameNum - 1
            end
        elseif backKey == "backspace" and worldSeedType == true and newgame == true then
            local byteoffset = utf8.offset(worldSeed, -1)
     
            if byteoffset then
                worldSeed = string.sub(worldSeed, 1, byteoffset - 1)
            end
            if worldSeedNum > 0 then
                worldSeedNum = worldSeedNum - 1
            end
        end

    end

    function love.textinput(worldText)

        if worldNameType == true and newgame == true then
            worldName = worldName .. worldText
            worldNameNum = worldNameNum + 1
        end

        if worldText == "1" or worldText == "2" or worldText == "3" or worldText == "4" or worldText == "5" or worldText == "6" or worldText == "7" or worldText == "8" or worldText == "9" or worldText == "0" then
            if worldSeedType == true and newgame == true then
                worldSeed = worldSeed .. worldText
                worldSeedNum = worldSeedNum + 1
            end
        end

    end

end

function menu.options()

    if inmenu == true and options == true then

        if mouseX > 170 and mouseX < 390 and mouseY > 200 and mouseY < 260 then -- FPS on/off
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 200, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 200, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 280 and mouseY < 340 then -- version on/off
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 280, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 280, 220, 60)
        end

        if mouseX > 410 and mouseX < 630 and mouseY > 200 and mouseY < 260 then -- audio volume
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 410, 200, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 410, 200, 220, 60)
        end        

        if mouseX > 410 and mouseX < 630 and mouseY > 280 and mouseY < 340 then -- audio volume
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 410, 280, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 410, 280, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 500 and mouseY < 560 then -- Back
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)                         -- set colour to black for borders and text

        love.graphics.rectangle("line", 170, 200, 220, 60)      -- draw 'FPS on/off' border
        if fps_show == true then                                -- detect if fps is on or off 
            love.graphics.print("FPS:On", 239, 210, 0, 2, 3)    -- print fps:on
        elseif fps_show == false then
            love.graphics.print("FPS:Off", 239, 210, 0, 2, 3)   -- print fps:off
        end

        love.graphics.rectangle("line", 170, 280, 220, 60)      -- draw 'verison on/off' border
        if version_show == true then                            -- detect if fps is on or off
            love.graphics.print("Version:On", 217, 290, 0, 2, 3) -- print version:on
        elseif version_show == false then
            love.graphics.print("Version:Off", 217, 290, 0, 2, 3) -- print version:off
        end

        love.graphics.rectangle("line", 410, 200, 220, 60)      --draw 'Audio' border
        love.graphics.print("Audio: "..volume.."%", 455, 210, 0, 2, 3)    --print Audio

        love.graphics.rectangle("line", 410, 280, 220, 60)      -- draw 'Seed on/off' border
        if seed_show == true then                            -- detect if Seed are on or off
            love.graphics.print("Show Seed:On", 430, 290, 0, 2, 3) -- print Seed:on
        elseif seed_show == false then
            love.graphics.print("Show Seed:Off", 430, 290, 0, 2, 3) -- print Seed:off
        end   

    end

end

function menu.loadScreen()

    if loading == true then
        if mouseX > 170 and mouseX < 840 and mouseY > 200 and mouseY < 260 then -- World Name
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 200, 670, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 200, 670, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 280 and mouseY < 340 then -- Load Game
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 280, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 280, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 500 and mouseY < 560 then -- Back
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        end

        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", 360, 205, 475, 50)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 170, 200, 670, 60)
        love.graphics.rectangle("line", 170, 280, 220, 60)

        if worldLoadType == true then
            love.graphics.print("World Name-: "..worldLoadName, 190, 210, 0, 2, 3)
        else
            love.graphics.print("World Name : "..worldLoadName, 190, 210, 0, 2, 3)
        end

        love.graphics.print("Load World", 212, 290, 0, 2, 3)

        if worldLoadNum > 20 then
            local byteoffset = utf8.offset(worldLoadName, -1)
     
            if byteoffset then
                worldLoadName = string.sub(worldLoadName, 1, byteoffset - 1)
            end
            worldLoadNum = worldLoadNum - 1
        end
    end

    function love.keypressed(backKey)

        if backKey == "backspace" and worldLoadType == true and loading == true then
            local byteoffset = utf8.offset(worldLoadName, -1)
     
            if byteoffset then
                worldLoadName = string.sub(worldLoadName, 1, byteoffset - 1)
            end
            if worldLoadNum > 0 then
                worldLoadNum = worldLoadNum - 1
            end
        end

    end

    function love.textinput(worldLoadText)

        if worldLoadType == true and loading == true then
            worldLoadName = worldLoadName .. worldLoadText
            worldLoadNum = worldLoadNum + 1
        end

    end

    if loadScreen == true then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, 1200, 750)
        love.graphics.setColor(255, 255, 255)
        if loadDelay > 9 then
            love.graphics.print("Loading", 510, 320, 0, 3, 3)
        elseif loadDelay > 8 then
            love.graphics.print("Loading.", 510, 320, 0, 3, 3)
        elseif loadDelay > 7 then
            love.graphics.print("Loading..", 510, 320, 0, 3, 3)
        elseif loadDelay > 6 then
            love.graphics.print("Loading...", 510, 320, 0, 3, 3)
        elseif loadDelay > 5 then
            love.graphics.print("Loading", 510, 320, 0, 3, 3)
        elseif loadDelay > 4 then
            love.graphics.print("Loading.", 510, 320, 0, 3, 3)
        elseif loadDelay > 3 then
            love.graphics.print("Loading..", 510, 320, 0, 3, 3)
        elseif loadDelay > 2 then
            love.graphics.print("Loading...", 510, 320, 0, 3, 3)
        elseif loadDelay > 1 then
            love.graphics.print("Loading", 510, 320, 0, 3, 3)
        elseif loadDelay > 0 then
            loadScreen = false
            loadDelay = 10
        end
    end

    if inmenu == true then
        if credits == true or options == true or newgame == true or loading == true then
            love.graphics.setColor(0, 0, 0)
            love.graphics.rectangle("line", 170, 500, 220, 60)      --draw 'back' border
            love.graphics.print("Back", 249, 510, 0, 2, 3)          --print back
        end
    end

end

function love.mousepressed(x, y, button, istouch)

	if inmenu == true then

		if ingame == false then

            if button == 1 and x > 170 and x < 390 and y > 150 and y < 210 and options == false and credits == false and loading == false then
                newgame = true
                love.timer.sleep(0.1)
            end

			--[[if button == 1 and options == false and credits == false and load_game == true then

				if x > 250 and x < 470 and y > 150 and y < 210 then
					if seed_array[1] ~= nil then
						seed = seed_array[1]
					end
				elseif  x > 250 and x < 470 and y > 250 and y < 310 then
					if seed_array[2] ~= nil then
						seed = seed_array[2]
					end
				elseif  x > 250 and x < 470 and y > 350 and y < 410 then
					if seed_array[3] ~= nil then
						seed = seed_array[3]
					end
				elseif  x > 250 and x < 470 and y > 450 and y < 510 then
					if seed_array[4] ~= nil then
						seed = seed_array[4]
					end
				elseif  x > 250 and x < 470 and y > 550 and y < 610 then
					if seed_array[5] ~= nil then
						seed = seed_array[5]
					end
				elseif  x > 650 and x < 870 and y > 150 and y < 210 then
					if seed_array[6] ~= nil then
						seed = seed_array[6]
					end
				elseif  x > 650 and x < 870 and y > 250 and y < 310 then
					if seed_array[7] ~= nil then
						seed = seed_array[7]
					end
				elseif  x > 650 and x < 870 and y > 350 and y < 410 then
					if seed_array[8] ~= nil then
						seed = seed_array[8]
					end
				elseif  x > 650 and x < 870 and y > 450 and y < 510 then
					if seed_array[9] ~= nil then
						seed = seed_array[9]
					end
				elseif  x > 650 and x < 870 and y > 550 and y < 610 then
					if seed_array[10] ~= nil then
						seed = seed_array[10]
					end
				end

				if x > 250 and x < 870 and y > 670 and y < 730 then

					load_game = false

				end

			end]]

			if button == 1 and x > 170 and x < 390 and y > 250 and y < 310 and options == false and credits == false and loading == false then
				load_game = true
			end

            if button == 1 and mouseX > 170 and mouseX < 390 and mouseY > 250 and mouseY < 310 and options == false and newgame == false then
                loading = true
            end

			if button == 1 and x > 170 and x < 390 and y > 450 and y < 510 and options == false and newgame == false and loading == false then
                credits = true
            end

            if button == 1 and x > 170 and x < 390 and y > 350 and y < 410 and credits == false and newgame == false and loading == false then
                options = true
                love.timer.sleep(0.1)
            end

            if button == 1 and x > 170 and x < 390 and y > 360 and y < 420 and newgame == true then
                inmenu = false
                ingame = true

                if doLoadScreen == true then
                    loadScreen = true
                end

                loadFunctions = true
                newgame = false
            end

            if button == 1 and x > 170 and x < 390 and y > 280 and y < 340 and loading == true then
                inmenu = false
                ingame = true

                worldName = worldLoadName

                if doLoadScreen == true then
                    loadScreen = true
                end

                loadFunctions = true
                loading = false
            end

            if button == 1 and x > 170 and x < 390 and y > 500 and y < 560 then
                options = false
                credits = false
                newgame = false
                loading = false
                playerImageDelay = 4
                love.timer.sleep(0.1)
                worldSeedType = false
                worldNameType = false
                worldLoadType = false
            end

            if button == 1 and x > 170 and x < 840 and y > 200 and y < 260 and newgame == true then
                worldNameType = not worldNameType
                worldSeedType = false
            end

            if button == 1 and x > 170 and x < 840 and y > 280 and y < 340 and newgame == true then
                worldSeedType = not worldSeedType
                worldNameType = false
            end

            if button == 1 and x > 170 and x < 840 and y > 200 and y < 260 and loading == true then
                worldLoadType = not worldLoadType
            end

        elseif ingame == true then

            if button == 1 and x > 500 and x < 720 and y > 150 and y < 210 and options == false then    --pause menu resume
                inmenu = false
            end

            if button == 1 and x > 500 and x < 720 and y > 250 and y < 310 and options == false then    --pause menu options
                options = true
                love.timer.sleep(0.3)
            end          
            
            if button == 1 and x > 170 and x < 390 and y > 500 and y < 560 and options == true then     --back from options
                options = false
                love.timer.sleep(0.1)
            end

            if button == 1 and x > 500 and x < 720 and y > 350 and y < 410 then
                save.load()
                love.timer.sleep(0.1)
            end

        end

        if button == 1 and x > 410 and x < 630 and y > 280 and y < 500 and options == true then
            seed_show = not seed_show
        end

        if button == 1 and x > 170 and x < 390 and y > 280 and y < 340 and options == true then     --show version
            version_show = not version_show
        end

        if button == 1 and x > 170 and x < 390 and y > 200 and y < 260 and options == true then     --fps on/off
            fps_show = not fps_show
        end

        if button == 1 and x > 410 and x < 630 and y > 200 and y < 260 and options == true then

            if volume == 0 then
                volume = 25
            elseif volume == 25 then
                volume = 50
            elseif volume == 50 then
                volume = 75
            elseif volume == 75 then
                volume = 100
            elseif volume == 100 then
                volume = 0
            end

        end
        
    end

end

function UPDATE_MENU(dt)

    love.mousepressed()
    menu.update(dt)

end

function DRAW_MENU()

    menu.draw()
    menu.options()
    menu.newgame()
    menu.loadScreen()

end