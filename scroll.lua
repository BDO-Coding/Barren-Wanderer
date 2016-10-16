scroll={}
require "player"

local map -- stores tiledata
 
local mapX, mapY -- view x,y in tiles. can be a fractional value like 3.25.
local mapWidth, mapHeight -- Width and Height in pixels
 
local tilesDisplayWidth, tilesDisplayHeight -- number of tiles to show
local zoomX, zoomY
 
local tilesetImage
local tileSize -- size of tiles in pixels
local tileQuads = {} -- parts of the tileset used for different tiles
local tilesetSprite
local biomeNum = 25600 --has to be a square number 57600
local setBiomeSize = 5
local biomeSize

function scroll.load()

    scroll.setupMap()
    scroll.setupMapView()
    scroll.setupTileset()
    

end

function scroll.biome()

    biomeArray = {}

    for x=1, 480 do
        biomeArray[x] = {}
        for y=1, 480 do
            biomeArray[x][y] = 3--love.math.random(0,13)
        end
    end

    biomeNum = mapWidth/setBiomeSize*mapWidth/setBiomeSize
    biomeSize = mapWidth/math.sqrt(biomeNum)
    for biomeX=1,math.sqrt(biomeNum) do
        for biomeY=1,math.sqrt(biomeNum) do
            xStart =biomeX*biomeSize - biomeSize +1
            yStart =biomeY*biomeSize - biomeSize +1
            xMax = biomeX*biomeSize
            yMax = biomeY*biomeSize
            biomeType = love.math.random(0,13)
            for x=xStart, xMax do
                for y=yStart, yMax do
                    biomeArray[x][y] = biomeType--love.math.random(0,13)
                end
            end
        end
    end

end

function scroll.setupMap()

    mapWidth = 480
    mapHeight = 480

    scroll.biome()

    map = {}

    for x=1, mapWidth do
       map[x] = {}
        for y=1, mapHeight do
           map[x][y] = biomeArray[x][y]
        end
    end

    --[[Random Gen
    for x=1,mapWidth do
        map[x] = {}
        for y=1,mapHeight do
           map[x][y] = love.math.random(0,13)
        end
    end
    --Pro Gen
    for x=1,mapWidth do
        for y=1,10 do
            map[x][y] = 0
        end
    end

        for x=1,10 do
        for y=1,mapHeight do

            map[x][y] = 0
        end
    end

        for x=1,mapWidth do
        for y=0,10 do
            map[x][y] = 0
        end
    end

        for x=mapWidth-10,mapWidth do
        for y=1,mapHeight do
            map[x][y] = 0

        end
    end]]

    --Name Signiture
    map[1][1] = 5
    map[1][2] = 5
    map[1][3] = 5
    map[2][1] = 5
    map[2][3] = 5
    map[3][2] = 5

    map[5][1] = 5
    map[5][2] = 5
    map[5][3] = 5
    map[6][2] = 5
    map[7][1] = 5
    map[7][2] = 5
    map[7][3] = 5

    map[1][6] = 5
    map[3][6] = 5
    map[3][8] = 5
    map[1][7] = 5
    map[1][8] = 5
    map[2][6] = 5
    map[2][8] = 5
    map[3][7] = 5

    map[5][6] = 5
    map[6][6] = 5
    map[7][6] = 5
    map[6][7] = 5
    map[6][8] = 5
    --Inserted
end
 
function scroll.setupMapView()

    mapX = 1
    mapY = 1
    tilesDisplayWidth = 26
    tilesDisplayHeight = 26

    zoomX = 2
    zoomY = 2 -----------------------------------------------------------------USEFUL

end
 
function scroll.setupTileset()

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

    scroll.updateTilesetBatch()

end
 
function scroll.updateTilesetBatch()

    tilesetBatch:clear()
    for x=0, tilesDisplayWidth-1 do
        for y=0, tilesDisplayHeight-1 do
            tilesetBatch:add(tileQuads[map[x+math.floor(mapX)][y+math.floor(mapY)]],
            x*tileSize, y*tileSize)
        end
    end
    tilesetBatch:flush()

end
 
-- central function for moving the map
function scroll.moveMap(dx, dy)

    oldMapX = mapX
    oldMapY = mapY
    mapX = math.max(math.min(mapX + dx, mapWidth - tilesDisplayWidth), 1)
    mapY = math.max(math.min(mapY + dy, mapHeight - tilesDisplayHeight), 1)
    -- only update if we actually moved
    if math.floor(mapX) ~= math.floor(oldMapX) or math.floor(mapY) ~= math.floor(oldMapY) then
        scroll.updateTilesetBatch()
    end

end

function scroll.update(dt)

    if inmenu == false and loadScreen == false then
        if love.keyboard.isDown("w") and love.keyboard.isDown("d") then

            scroll.moveMap(0, -playerSpeedDiagonal * tileSize)
            scroll.moveMap(playerSpeedDiagonal * tileSize, 0)
            
        elseif love.keyboard.isDown("w") and love.keyboard.isDown("a") then

            scroll.moveMap(0, -playerSpeedDiagonal * tileSize)
            scroll.moveMap(-playerSpeedDiagonal * tileSize, 0)

        elseif love.keyboard.isDown("s") and love.keyboard.isDown("d") then

            scroll.moveMap(0, playerSpeedDiagonal * tileSize)
            scroll.moveMap(playerSpeedDiagonal * tileSize, 0)

        elseif love.keyboard.isDown("s") and love.keyboard.isDown("a") then

            scroll.moveMap(0, playerSpeedDiagonal * tileSize)
            scroll.moveMap(-playerSpeedDiagonal * tileSize, 0)

        else
            if love.keyboard.isDown("w")  then
                scroll.moveMap(0, -playerSpeed * tileSize)
            end

            if love.keyboard.isDown("s")  then
                scroll.moveMap(0, playerSpeed * tileSize)
            end

            if love.keyboard.isDown("a")  then
                scroll.moveMap(-playerSpeed * tileSize, 0)
            end

            if love.keyboard.isDown("d")  then
                scroll.moveMap(playerSpeed * tileSize, 0)
            end
        end
    end

end

function scroll.draw()

    love.graphics.draw(tilesetBatch, math.floor(-zoomX*(mapX%1)*tileSize), math.floor(-zoomY*(mapY%1)*tileSize), 0, zoomX, zoomY)

end

function UPDATE_SCROLL(dt)

    scroll.update()

end

function DRAW_SCROLL()

    scroll.draw()

end