save={}
require "player"
require "scroll"

seed = 0

function save.load()

    save.clear()
    local file = io.open(worldName..".txt", "a")
    file:write("Seed:\n"..worldSeed.."\nName:\n"..worldName)
    file:close()
    save.read()

end

function save.update(dt)

end

function save.draw()

end

function save.clear()

    local file = io.open(worldName..".txt", "w")
    file:close()

end


function save.read()

    local count = 1
    local file = io.open(worldName..".txt", "r")
    seedNext = false
    io.input(file)

    while true do

        local line = io.read()

        if line == nil then
            break
        end
        
        count = count + 1

        if seedNext == true then
          	seed = line
          	seedNext = false
        end

        if line == "Seed:" then
            seedNext = true
        end
      
    end

end

function UPDATE_SAVE(dt)

	save.update(dt)

end

function DRAW_SAVE()

	save.draw()

end