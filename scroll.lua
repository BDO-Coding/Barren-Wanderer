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
dimensionNum = 3

currentDimension = 3

function scroll.load()

    worldSeedInt = tonumber(seed)
    math.randomseed(worldSeedInt)--worldSeedInt)

    map = {}

    scroll.setupDimensions() -- Makes dimension array
    scroll.setupBiomes()    --Generateds biomes for main dimension types
    scroll.blendBiomes()       -- blends biomes together
    scroll.giveNoiseToBiomes()  --Coverts biome maps to textured tiles
    scroll.setupMapView() -- sets various view settings
    scroll.setupTileset()

end

function scroll.setupDimensions()

    dimensionArray = {{}}

    dimensionArray[1] = {"Overworld", true , true, true} -- Name, does biome blending, is main dimension type, does biome noise
    dimensionArray[1][5] = {7,1,2,3,4,5,6,7} --numOfBiomes, list of biome IDs
    dimensionArray[1][6] = {480,480,{1,2,3},{1,2,3},{1,2,3}} --biome h/w, preset map

    dimensionArray[2] = {"Underground", true , true, true}
    dimensionArray[2][5] = {3,7,8,10}
    dimensionArray[2][6] = {480,480,{1,2,3},{1,2,3},{1,2,3}}

    dimensionArray[3] = {"Oblivion", true , true, true}
    dimensionArray[3][5] = {3,8,9,10}
    dimensionArray[3][6] = {480,480,{1,2,3},{1,2,3},{1,2,3}}

    dimensionNum = #dimensionArray

end


function scroll.setupBiomes()

    biomeTypesArray = {{}}
    biomeTypesArray[1] = {"Ocean",1,1,0} -- biomeID, numTiles, tileID1...
    biomeTypesArray[2] = {"Grasslands",3,2,8,9,10}
    biomeTypesArray[3] = {"Desert",2,3,7,6}
    biomeTypesArray[4] = {"Beach",1,4,1}
    biomeTypesArray[5] = {"Forest",4,5,8,9,11,12}
    biomeTypesArray[6] = {"Jungle",2,6,14,13}
    biomeTypesArray[7] = {"Mountain",3,7,3,4,5}
    biomeTypesArray[8] = {"GhostForest",2,8,17,16}
    biomeTypesArray[9] = {"GlowingGrasslands",2,9,14,16}
    biomeTypesArray[10] = {"FireMountains",2,10,15,4}


    mapWidth = 480
    mapHeight = 480

    biomeArray = {}

    for d = 1, dimensionNum do
        biomeArray[d] = {}
        for x=1, dimensionArray[d][6][1] do
            biomeArray[d][x] = {}
            for y=1, dimensionArray[d][6][2] do
                biomeArray[d][x][y] = 0--math.random(0,13)
            end
        end
    end

    biomeNum = mapWidth/setBiomeSize*mapWidth/setBiomeSize
    biomeSize = mapWidth/math.sqrt(biomeNum)
    for d = 1, dimensionNum do
        if dimensionArray[d][3] == true then
            for biomeX=1,math.sqrt(biomeNum) do
                for biomeY=1,math.sqrt(biomeNum) do
                    xStart =biomeX*biomeSize - biomeSize + 1
                    yStart =biomeY*biomeSize - biomeSize + 1
                    xMax = biomeX*biomeSize
                    yMax = biomeY*biomeSize
                    biomeType = dimensionArray[d][5][math.random(2,(dimensionArray[d][5][1])+1)]
                        for x=xStart, xMax do
                            for y=yStart, yMax do
                                biomeArray[d][x][y] = biomeType
                            end
                        end
                end
            end
        else
            map[d] = {}
            for mapX = 1, dimensionArray[d][6][1] do
                map[d][mapX] = {}
                for mapY = 1, dimensionArray[d][6][2] do
                    map[d][mapX][mapY] = 1
                    map[d][mapX][mapX] = dimensionArray[d][6][(mapX)+2][mapY]
                end
            end
        end
    end
end


function scroll.blendBiomes()
    for d = 1, dimensionNum do
        if dimensionArray[d][2] == true then

     for a=2,mapWidth do
         for b=2,mapHeight do
            if a > terrainExtreemity + 3 then
            if a > mapWidth - (terrainExtreemity+3) then
                    if biomeArray[d][a][b+math.random(-terrainExtreemity,-1)] ~= biomeArray[d][a][b] then
                    biomeArray[d][a][b] = biomeArray[d][a][b+math.random(-terrainExtreemity,-1)]
                end
                if biomeArray[d][a+math.random(-terrainExtreemity,-1)][b] ~= biomeArray[d][a][b] then
                 biomeArray[d][a][b] = biomeArray[d][a+math.random(-terrainExtreemity,-1)][b]
                end
            else
                if biomeArray[d][a][b+math.random(-terrainExtreemity,terrainExtreemity)] ~= biomeArray[d][a][b] then
                    biomeArray[d][a][b] = biomeArray[d][a][b+math.random(-terrainExtreemity,terrainExtreemity)]
                end
                if biomeArray[d][a+math.random(-terrainExtreemity,terrainExtreemity)][b] ~= biomeArray[d][a][b] then
                 biomeArray[d][a][b] = biomeArray[d][a+math.random(-terrainExtreemity,terrainExtreemity)][b]
                end
            end
            else
                if biomeArray[d][a][b+math.random(1,terrainExtreemity)] ~= biomeArray[d][a][b] then
                    biomeArray[d][a][b] = biomeArray[d][a][b+math.random(1,terrainExtreemity)]
                end
                if biomeArray[d][a+math.random(1,terrainExtreemity)][b] ~= biomeArray[d][a][b] then
                 biomeArray[d][a][b] = biomeArray[d][a+math.random(1,terrainExtreemity)][b]
                end

            end
        end
    end
    end
end
end


function scroll.giveNoiseToBiomes()

    for d=1, dimensionNum do -- for every dimension
        if dimensionArray[d][4] == true then
            map[d] = {}
            for x=1, mapWidth do
                map[d][x] = {}
                for y=1, mapHeight do -- for every tile in that dimesion
                    map[d][x][y] = 0                          
                    for biomeToCheck = 1, #biomeTypesArray do -- for every possible biome that could be in this dimension
                        if biomeArray[d][x][y] == biomeToCheck then -- if the tile that is selected is a specific biome type
                            map[d][x][y] = biomeTypesArray[biomeToCheck][math.random(4,(biomeTypesArray[biomeToCheck][2])+3)]--[(math.random(1,#biomeTypesArray[biomeToCheck]))-2]
                        end
                    end
                end

            end
        end
    end

    --Name Signiture
    map[1][1][1] = 5 map[1][1][2] = 5 map[1][1][3] = 5   map[1][2][1] = 5  map[1][2][3] = 5  map[1][3][2] = 5 map[1][5][1] = 5 map[1][5][2] = 5 map[1][5][3] = 5 map[1][6][2] = 5 map[1][7][1] = 5  map[1][7][2] = 5  map[1][7][3] = 5   map[1][1][6] = 5   map[1][3][6] = 5   map[1][3][8] = 5 map[1][1][7] = 5  map[1][1][8] = 5   map[1][2][6] = 5 map[1][2][8] = 5 map[1][3][7] = 5   map[1][5][6] = 5   map[1][6][6] = 5   map[1][7][6] = 5 map[1][6][7] = 5  map[1][6][8] = 5 map[1][1][11] = 5   map[1][1][12] = 5   map[1][1][13] = 5   map[1][1][14] = 5   map[1][1][15] = 5   map[1][2][11] = 5  map[1][2][15] = 5  map[1][3][12] = 5  map[1][3][14] = 5  map[1][2][13] = 5 map[1][5][11] = 5 map[1][5][12] = 5  map[1][5][13] = 5 map[1][5][14] = 5 map[1][5][15] = 5 map[1][6][11] = 5 map[1][6][15] = 5 map[1][7][12] = 5 map[1][7][14] = 5 map[1][6][13] = 5

    mapDrawn = true
    
end


function scroll.gotoDimension(num)
    if num < dimensionNum + 1 then
        currentDimension = num
    end
end

function round(num, idp)

    local mult = 10^(idp or 0)
    return math.floor(num * mult + 0.5) / mult

end

 
function scroll.setupMapView()

    mapX = 240
    mapY = 240
    tilesDisplayWidth = 26
    tilesDisplayHeight = 26

    zoomX = 2
    zoomY = 2

end
 
function scroll.setupTileset()

    tileArray = {{}}

    tileArray[0] = {"Ocean"}
    tileArray[1] = {"Sand"}
    tileArray[2] = {"River"}
    tileArray[3] = {"Mountain2"}
    tileArray[4] = {"Mountain3"}
    tileArray[5] = {"Mountain1"}
    tileArray[6] = {"HotSand"}
    tileArray[7] = {"Quicksand"}
    tileArray[8] = {"Grass1"}
    tileArray[9] = {"Grass2"}
    tileArray[10] = {"Grass3"}
    tileArray[11] = {"Tree1"}
    tileArray[12] = {"Tree2"}
    tileArray[13] = {"JungleTree"}
    tileArray[14] = {"JungleGrass"}
    tileArray[15] = {"FireRock"}
    tileArray[16] = {"GlowingGrass"}
    tileArray[17] = {"GhostTree"}


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

    --Fire Rock
    tileQuads[15] = love.graphics.newQuad(4 * tileSize, 1 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())   

    --Glowing grass
    tileQuads[16] = love.graphics.newQuad(5 * tileSize, 1 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())   

    --Ghost Tree
    tileQuads[17] = love.graphics.newQuad(3 * tileSize, 1 * tileSize, tileSize, tileSize,
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

  --  if map[d][x][y] == 11 then
      --  map[d][x][y] = 10
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
        currentBiomeWord = biomeTypesArray[currentBiome][1]
        currentTileWord = tileArray[currentTile][1]
        currentDimensionWord = dimensionArray[currentDimension][1]

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