save={}
require "player"
require "scroll"

seed = 0

function save.load()

	--[[save.clear()
	local file = io.open("world.txt", "a")
	file:write("Seed:\n1285\nhello\nmy\nname\nis\nDanny")
	file:close()
	save.read()]]

	world_num_to_load = 1
	save.read()



end

function save.update(dt)

end

function save.draw()

end

function save.clear()

local file = io.open("world.txt", "w")
	
	file:close()

end


function save.read()

	--[[local count = 1
	local file = io.open("world.txt", "r")
	seedNext = false
	io.input(file)

    while true do
      	local line = io.read()
      	if line == nil then break end
      	count = count + 1

      	if seedNext == true then
      		seed = line
      		seedNext = false
      	end

      	if line == "Seed:" then
      		seedNext = true
      	end
      
  	end]]

  	local num_of_lines = 0
	for _ in io.lines'world.txt' do
	  	num_of_lines = num_of_lines + 1
	end

	--print(num_of_lines)

  	world = love.filesystem.read("world.txt")

	seed_array = {}

	for line in love.filesystem.lines("world.txt") do
	  	table.insert(seed_array, line)
	end

	for i=1, 10, 1 do
		print(seed_array[i])
	end
end

function UPDATE_SAVE(dt)

	save.update(dt)


end

function DRAW_SAVE()

	save.draw()

end