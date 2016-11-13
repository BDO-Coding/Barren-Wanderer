item={}
require"images"

function item.load()

	item.amount = 0

	itemArray = {{}}
	itemArray[1] = {1--[[ID]],1--[[amount]]}


	itemIndex = {{}}
	itemIndex[1] = {1--[[ID]],"stone"--[[Name]],1--[[weight]]}

end

function item.update(dt)

end

function item.draw()

end

function UPDATE_ITEM(dt)
	item.update(dt)
end

function DRAW_ITEM()
	item.draw()
end

function addItem(id,amount,x,y)
	item.amount = item.amount+amount
end