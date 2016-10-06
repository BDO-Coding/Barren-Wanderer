scroll={}

require "player"

local map -- stores tiledata
local mapWidth, mapHeight -- width and height in tiles
 
local mapX, mapY -- view x,y in tiles. can be a fractional value like 3.25.
 
local tilesDisplayWidth, tilesDisplayHeight -- number of tiles to show
local zoomX, zoomY
 
local tilesetImage
local tileSize -- size of tiles in pixels
local tileQuads = {} -- parts of the tileset used for different tiles
local tilesetSprite

function scroll.load()

    scroll.setupMap()
    scroll.setupMapView()
    scroll.setupTileset()
    
end

function scroll.setupMap()

    mapWidth = 280
    mapHeight = 220-----------------------------------------------------------USEFUL

    map = {}
    for x=1,mapWidth do
        map[x] = {}
        for y=1,mapHeight do
            map[x][y] = love.math.random(0,3)
        end
    end

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

    -- grass
    tileQuads[0] = love.graphics.newQuad(0 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    -- kitchen floor tile
    tileQuads[1] = love.graphics.newQuad(1 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    -- parquet flooring
    tileQuads[2] = love.graphics.newQuad(2 * tileSize, 0 * tileSize, tileSize, tileSize,
    tilesetImage:getWidth(), tilesetImage:getHeight())
    -- middle of red carpet
    tileQuads[3] = love.graphics.newQuad(3 * tileSize, 0 * tileSize, tileSize, tileSize, -- 4 0, x - y in a 32-32 grid 
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

function scroll.draw()

    love.graphics.draw(tilesetBatch, math.floor(-zoomX*(mapX%1)*tileSize), math.floor(-zoomY*(mapY%1)*tileSize), 0, zoomX, zoomY)

end

function UPDATE_SCROLL(dt)

    scroll.update()

end

function DRAW_SCROLL()

    scroll.draw()

end