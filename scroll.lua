scroll={}
require "player"
require "menu"
require "save"

local map -- stores tiledata

mapX, mapY = 0,0-- view x,y in tiles. can be a fractional value like 3.25.
local oldMapX,oldMapY
local mapWidth, mapHeight -- Width and Height in pixels
 
local tilesDisplayWidth, tilesDisplayHeight -- number of tiles to show
local zoomX, zoomY
 

local setTerrainExtreemness = 1 -- Use this to edit how steep the terrain is ********************************************


local tilesetImage
local tileSize -- size of tiles in pixels
local tileQuads = {} -- parts of the tileset used for different tiles
local tilesetSprite
local biomeNum = 25600 --has to be a square number 57600
local setBiomeSize = 30
local biomeSize
local mapDrawn = false
local terrainExtreemity = setBiomeSize*setTerrainExtreemness
dimensionNum = 2

currentDimension = 1


function scroll.gotoDimension(num)
    if num < dimensionNum + 1 then
        currentDimension = num
    end
end

function round(num, idp)

    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult

end

function scroll.load()

    worldSeedInt= 300--= tonumber(seed)
    math.randomseed(worldSeedInt)

    scroll.setupBiomes()
    scroll.blendBiomes()
    scroll.giveNoiseToBiomes()
    scroll.setupMapView()
    scroll.setupTileset()

end

function scroll.blendBiomes()
    for d = 1, dimensionNum do
     for a=2,mapWidth do
         for b=2,mapHeight do
            if a > terrainExtreemity + 3 then
            if a > mapWidth - (terrainExtreemity+3) then
                    if biomeArray[d][a][b+love.math.random(-terrainExtreemity,-1)] ~= biomeArray[d][a][b] then
                    biomeArray[d][a][b] = biomeArray[d][a][b+love.math.random(-terrainExtreemity,-1)]
                end
                if biomeArray[d][a+love.math.random(-terrainExtreemity,-1)][b] ~= biomeArray[d][a][b] then
                 biomeArray[d][a][b] = biomeArray[d][a+love.math.random(-terrainExtreemity,-1)][b]
                end
            else
                if biomeArray[d][a][b+love.math.random(-terrainExtreemity,terrainExtreemity)] ~= biomeArray[d][a][b] then
                    biomeArray[d][a][b] = biomeArray[d][a][b+love.math.random(-terrainExtreemity,terrainExtreemity)]
                end
                if biomeArray[d][a+love.math.random(-terrainExtreemity,terrainExtreemity)][b] ~= biomeArray[d][a][b] then
                 biomeArray[d][a][b] = biomeArray[d][a+love.math.random(-terrainExtreemity,terrainExtreemity)][b]
                end
            end
            else
                if biomeArray[d][a][b+love.math.random(1,terrainExtreemity)] ~= biomeArray[d][a][b] then
                    biomeArray[d][a][b] = biomeArray[d][a][b+love.math.random(1,terrainExtreemity)]
                end
                if biomeArray[d][a+love.math.random(1,terrainExtreemity)][b] ~= biomeArray[d][a][b] then
                 biomeArray[d][a][b] = biomeArray[d][a+love.math.random(1,terrainExtreemity)][b]
                end

            end
        end
    end
end
end

function scroll.setupBiomes()

        mapWidth = 480
    mapHeight = 480

    biomeArray = {}

    for d = 1, dimensionNum do
        biomeArray[d] = {}
    for x=1, 480 do
        biomeArray[d][x] = {}
        for y=1, 480 do
            biomeArray[d][x][y] = 3--love.math.random(0,13)
        end
    end
end

    biomeNum = mapWidth/setBiomeSize*mapWidth/setBiomeSize
    biomeSize = mapWidth/math.sqrt(biomeNum)
    for d = 1, dimensionNum do
    for biomeX=1,math.sqrt(biomeNum) do
        for biomeY=1,math.sqrt(biomeNum) do
            xStart =biomeX*biomeSize - biomeSize + 1
            yStart =biomeY*biomeSize - biomeSize + 1
            xMax = biomeX*biomeSize
            yMax = biomeY*biomeSize
            biomeType = math.random(0,5)
            for x=xStart, xMax do
                for y=yStart, yMax do
                    biomeArray[d][x][y] = biomeType
                end
            end
        end
    end
end

end


function scroll.giveNoiseToBiomes()



    map = {}

    for d=1, dimensionNum do
    map[d] = {}
    for x=1, mapWidth do
      map[d][x] = {}
        for y=1, mapHeight do
            random = math.random(0,3)
            if biomeArray[d][x][y] == 0 then --Ocean 1
                map[d][x][y] = 0     
            elseif biomeArray[d][x][y] == 1 then -- Grass 1
                if random == 0 then 
                    map[d][x][y] = 8
                elseif random == 1 then
                    map[d][x][y] = 9
                else
                    map[d][x][y] = 10
                end
            elseif biomeArray[d][x][y] == 2 then --Deset 1
                if random == 0 then 
                    map[d][x][y] = 7
                else
                    map[d][x][y] = 6
                end
            elseif biomeArray[d][x][y] == 3 then --Beach 1
                map[d][x][y] = 1
            elseif biomeArray[d][x][y] == 4 then --Forest 1
                if random == 0 then 
                    map[d][x][y] = 8
                elseif random == 1 then
                    map[d][x][y] = 9
                elseif random == 2 then
                    map[d][x][y] = 11
                else
                    map[d][x][y] = 12
                end
            else
                if random == 0 then 
                    map[d][x][y] = 14 --Jungle 1
                else
                    map[d][x][y] = 13 --Jungle 2
                end
                
            end
            
        end

    end
    end

    --Name Signiture
    map[1][1][1] = 5 map[1][1][2] = 5 map[1][1][3] = 5   map[1][2][1] = 5  map[1][2][3] = 5  map[1][3][2] = 5 map[1][5][1] = 5 map[1][5][2] = 5 map[1][5][3] = 5 map[1][6][2] = 5 map[1][7][1] = 5  map[1][7][2] = 5  map[1][7][3] = 5   map[1][1][6] = 5   map[1][3][6] = 5   map[1][3][8] = 5 map[1][1][7] = 5  map[1][1][8] = 5   map[1][2][6] = 5 map[1][2][8] = 5 map[1][3][7] = 5   map[1][5][6] = 5   map[1][6][6] = 5   map[1][7][6] = 5 map[1][6][7] = 5  map[1][6][8] = 5 map[1][1][11] = 5   map[1][1][12] = 5   map[1][1][13] = 5   map[1][1][14] = 5   map[1][1][15] = 5   map[1][2][11] = 5  map[1][2][15] = 5  map[1][3][12] = 5  map[1][3][14] = 5  map[1][2][13] = 5 map[1][5][11] = 5 map[1][5][12] = 5  map[1][5][13] = 5 map[1][5][14] = 5 map[1][5][15] = 5 map[1][6][11] = 5 map[1][6][15] = 5 map[1][7][12] = 5 map[1][7][14] = 5 map[1][6][13] = 5

    mapDrawn = true
    
end
 
function scroll.setupMapView()

    mapX = 1
    mapY = 1
    tilesDisplayWidth = 26
    tilesDisplayHeight = 26

    zoomX = 2
    zoomY = 2

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
    --JungleGrass
    tileQuads[14] = love.graphics.newQuad(14 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())   

    tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, tilesDisplayWidth * tilesDisplayHeight)

    scroll.updateTilesetBatch()

end
 
function scroll.updateTilesetBatch()

    tilesetBatch:clear()
    for x=0, tilesDisplayWidth-1 do
        for y=0, tilesDisplayHeight-1 do
            tilesetBatch:add(tileQuads[map[currentDimension][x+math.floor(mapX)][y+math.floor(mapY)]],
            x*tileSize, y*tileSize)
        end
    end
    tilesetBatch:flush()

end
 
function scroll.moveMap(dx, dy) -- Central function for moving the map

    oldMapX = mapX
    oldMapY = mapY
    mapX = math.max(math.min(mapX + dx, mapWidth - tilesDisplayWidth), 1)
    mapY = math.max(math.min(mapY + dy, mapHeight - tilesDisplayHeight), 1)
    -- only update if we actually moved
    if math.floor(mapX) ~= math.floor(oldMapX) or math.floor(mapY) ~= math.floor(oldMapY) then
        scroll.updateTilesetBatch()
    end

end
function scroll.round(num, idp)

    local mult = 10^(idp or 0)
    return math.floor(1* mult + 0.5) / mult
    
end
function mine(x,y)

  --  if map[x][y] == 11 then
      --  map[x][y] = 10
    --else
    --end

end

function scroll.update(dt)
    --mine(playerX,playerY)
         mine(scroll.round(playerX,0), scroll.round(playerY,0))
down = love.mouse.isDown(1) 
 if down == true then
     mine(scroll.round(playerX), scroll.round(playerY))
 end

    playerX = mapX
    playerY = mapY

    if mapDrawn == true then
        currentBiome = biomeArray[currentDimension][(math.floor(playerX+0.5))+9][(math.floor(playerY+0.5))+5]
        currentTile = map[currentDimension][(math.floor(playerX+0.5))+9][(math.floor(playerY+0.5))+5]
    end


    if inmenu == false and loadScreen == false and alive == true then
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
                scroll.moveMap(0, - playerSpeed * tileSize)
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

    if alive == true then
        love.graphics.draw(tilesetBatch, math.floor(-zoomX*(mapX%1)*tileSize), math.floor(-zoomY*(mapY%1)*tileSize), 0, zoomX, zoomY)
    end

end

function UPDATE_SCROLL(dt)

    scroll.update(dt)
end

function DRAW_SCROLL()

    scroll.draw()

end