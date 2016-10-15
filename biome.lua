biome={}

function biome.load()


    biomeArray = {}

    for x=1, 228 do
       biomeArray[x] = {}
        for y=1, 220 do
           biomeArray[x][y] = 1
        end
    end

end

function biome.update(dt)

end

function biome.draw()

end

function UPDATE_BIOME(dt)

	monster.update(dt)

end

function DRAW_BIOME()

	monster.draw()

end