item={}
require"images"
require"scroll"

function item.load()

	item.amount = 0
	item.Stackamount = 0

	itemArray = {{}}
	--itemArray[1] = {1--[[ID]],1--[[amount]],1,1--[[x,y coords]]}


	itemIndex = {{}}
	itemIndex[1--[[id]]] = {"stone"--[[Name]],2--[[weight]],images.stone--[[image]]}
	itemIndex[2] = {"stick",1,images.stick}

for i = 1, 100 do
	addItem(love.math.random(1,2),2,i,i)
	i=i+1
end

end

function item.update(dt)

end

function item.draw()
	if item.Stackamount > 0 then
	for i = 1, item.Stackamount do
		love.graphics.draw(itemIndex[itemArray[i][1]][3],math.floor((mapX)*-64)+(itemArray[i][3]*64)+594,math.floor((mapY)*-64)+(itemArray[i][4]*64)+396, 0, 1, 1)
		i=i+1
	end
end
end

function item.grab(x,y)

for i=1,1 do
	if round(itemArray[i][3],0) == x and round(itemArray[i][4],0) == y then
	table.remove(itemArray,i)
	item.Stackamount = item.Stackamount-1
	end
	i = i +1

end

end

function UPDATE_ITEM(dt)
	item.update(dt)
end

function DRAW_ITEM()
	item.draw()
end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function addItem(id,amount,x,y)
	item.amount = item.amount+amount
	item.Stackamount = item.Stackamount + 1
	itemArray[item.Stackamount] = {id,amount,x,y}
end