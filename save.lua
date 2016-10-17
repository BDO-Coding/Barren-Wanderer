save={}
require "player"
require "scroll"

function save.load()

save.openSeed(w)
file:write("This is the webpage for writing to files:\nhttp://www.ac-web.org/forums/showthread.php?71015-Tutorial-Writing-to-a-File-With-Lua")
file:close()
--save.clear()


end

function save.clear()

file = io.open("world.txt", "w")
file:close()

end

function save.openSeed(mode)

file = io.open("seed.txt",mode)

end

function save.update(dt)

end

function save.draw()

end

function UPDATE_SAVE(dt)

	save.update(dt)

end

function DRAW_SAVE()

	save.draw()

end