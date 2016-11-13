item={}
require"images"

function item.load()

	item.amount = 0
	item.Stackamount = 1

	itemArray = {{}}
	itemArray[1] = {1--[[ID]],1--[[amount]],1,1--[[x,y coords]]}


	itemIndex = {{}}
	itemIndex[1--[[id]]] = {"stone"--[[Name]],1--[[weight]],images.stone--[[image]]}

end

function item.update(dt)

end

function item.draw()
	for i = 1, item.Stackamount do
		love.graphics.draw(itemIndex[itemArray[i][1]][3],(playerX*-64)+500,((playerY)*-64)+500, 0, 1, 1)
		i=i+1
	end
end

function UPDATE_ITEM(dt)
	item.update(dt)
end

function DRAW_ITEM()
	item.draw()
end

function addItem(id,amount,x,y)
	item.amount = item.amount+amount
	item.Stackamount = item.Stackamount + 1
	itemArray[Stackamount] = {id,amount,x,y}
end