menu = {}
require "scroll"
require "player"
require "monster"

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

    options = false
    credits = false

    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()

    menuPlayerImage = images.playerDown
    playerImageDelay = 4
    playerImageSize = 30
    playerImageX = 500

    moveSpeed = 0.001
    moveTime = 0.001
    moveDelay = 20

    menu.setupMap()
    menu.setupMapView()
    menu.setupTileset()

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

    if inmenu == true and options == false and ingame == false and credits == false then

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
            menuPlayerImage = images.playerDown
            playerImageSize = 30
            playerImageX = 400
        elseif playerImageDelay > 2 then
            menuPlayerImage = images.playerSide
            playerImageSize = 30
            playerImageX = 400
        elseif playerImageDelay > 1 then
            menuPlayerImage = images.playerUp
            playerImageSize = 30
            playerImageX = 400
        elseif playerImageDelay > 0 then
            menuPlayerImage = images.playerSide
            playerImageSize = -30
            playerImageX = 1350
        elseif playerImageDelay > -1 then
            playerImageDelay = 4
        end

        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(menuPlayerImage, playerImageX, -100, 0, playerImageSize, 30)

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

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 500, 150, 220, 60)
        love.graphics.rectangle("line", 500, 250, 220, 60)

        love.graphics.print("Resume", 562, 160, 0, 2, 3)
        love.graphics.print("Options", 562, 260, 0, 2, 3)

    end

    if credits == true then
        love.graphics.setColor(0, 255, 255)
        love.graphics.rectangle("fill", 300, 100, 800, 390, 10)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Coded by: \n         Danny Harris and Ori Taylor", 320, 120, 0, 3, 3)
        love.graphics.print("Art by: \n         Danny Harris and Ori Taylor", 320, 200, 0, 3, 3)
        love.graphics.print("Programs used: \n         LÖVE for Lua\n         paint.net\n         Sublime Text", 320, 300, 0, 3, 3)

        if mouseX > 170 and mouseX < 390 and mouseY > 500 and mouseY < 560 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 170, 500, 220, 60)

        love.graphics.print("Back", 249, 510, 0, 2, 3)
    end

end

function menu.setupMap()

    menuMapWidth = 280
    menuMapHeight = 220-----------------------------------------------------------USEFUL

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
            --if menuMap[x][y]+1 == 2 then -- Is killing all sand
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

function menu.options()

    if inmenu == true and options == true then

        if mouseX > 170 and mouseX < 390 and mouseY > 500 and mouseY < 560 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 170, 500, 220, 60)

        love.graphics.print("Back", 249, 510, 0, 2, 3)

    end

end

function love.mousepressed(x, y, button, istouch)

    if inmenu == true then
        if ingame == false then
            if button == 1 and x > 170 and x < 390 and y > 150 and y < 210 and options == false and credits == false then
                inmenu = false
                ingame = true

                scroll.load()
                player.load()
                monster.load()
                
            end
            if button == 1 and x > 170 and x < 390 and y > 350 and y < 410 and options == false and credits == false then
                options = true
            end

            if button == 1 and x > 170 and x < 390 and y > 500 and y < 560 then
                options = false
                credits = false
            end

            if button == 1 and x > 170 and x < 390 and y > 450 and y < 510 and options == false then
                credits = true
            end
        else
            if button == 1 and x > 500 and x < 720 and y > 150 and y < 210 then
                inmenu = false
            end

            if button == 1 and x > 500 and x < 720 and y > 250 and y < 310 then
                options = true
            end

            if button == 1 and x > 170 and x < 390 and y > 500 and y < 560 and options == true then
                options = false
            end
        end
        
    end

end

function UPDATE_MENU(dt)

    love.mousepressed()

    if ingame == false then
        menu.update(dt)
    end

end

function DRAW_MENU()

    menu.draw()
    menu.options()

end