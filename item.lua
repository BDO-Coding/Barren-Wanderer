item={}
require"images"
require"scroll"
require"hotbar"

function item.load()

	draw = false

	item.amount = 0
	item.Stackamount = 0
	item.indexAmount = 5
	contributeToStack = true
	sameStack = 0
	itemArray = {{}}
	--itemArray[1] = {1--[[ID]],1--[[amount]],1,1--[[x,y coords]]

	itemIndex = {{}}
	itemIndex[1--[[id]]] = {"Test"--[[Name]],2--[[weight]],images.mana--[[image]],false--[[does it spawn in world]]} -- This item isn't actualy used
	itemIndex[2] = {"Stick",1,images.stick,true}
	itemIndex[3] = {"Stone",2,images.stone,true}
	itemIndex[4] = {"Log",2,images.log,true}
	itemIndex[5] = {"Mucus",2,images.mucus,true}
	itemIndex[6] = {"Wooden Sword",2,images.woodenSword,false}

		item.indexAmount = 5

	for i = 1, 1000 do

		addItem(love.math.random(2,item.indexAmount),2,love.math.random(1,200),love.math.random(1,200))
	
	end

end

function item.update(dt)

end

function item.draw()

	if draw1 == true then
		love.graphics.draw(images.mana,100,600)
	end
	if item.Stackamount > 0 then
		for i = 1, item.Stackamount -1  do
			love.graphics.draw(itemIndex[itemArray[i][1]][3],math.floor((mapX)*-64)+(itemArray[i][3]*64)+594,math.floor((mapY)*-64)+(itemArray[i][4]*64)+396, 0, 1, 1)
		end
	end

end

function item.getItemImage(id)

	return itemIndex[id][3]

end

function item.getItemName(id)

	return itemIndex[id][1]

end

function item.grab(x,y,mode,specificItem,specificAmount)

	if mode == "specificGive" then
		contributeToStack = false
		for j = 1, slotAmount do
			if hotbarArray[j][3] == specificItem then
				contributeToStack = true
				sameStack = j
			end
		end
		if contributeToStack == false then
			hotbarArray[highestUsedSpot+1][3] = specificItem
			hotbarArray[highestUsedSpot+1][4] = specificAmount*2
			highestUsedSpot = highestUsedSpot + 1
		else
			hotbarArray[sameStack][4] = hotbarArray[sameStack][4] + specificAmount*2
		end
	else
		for i=1, item.Stackamount-1 do
			if round(itemArray[i][3],0) == x and round(itemArray[i][4],0) == y then
					contributeToStack = false
				for j = 1, slotAmount do
					if hotbarArray[j][3] == itemArray[i][1] then
						contributeToStack = true
						sameStack = j
					end
					j=j+1
				end
				if contributeToStack == false then
					hotbarArray[highestUsedSpot+1][3] = itemArray[i][1]
					hotbarArray[highestUsedSpot+1][4] = itemArray[i][2]
					highestUsedSpot = highestUsedSpot + 1
				else
					hotbarArray[sameStack][4] = hotbarArray[sameStack][4] + itemArray[i][2]
				end
				table.remove(itemArray,i)
				item.Stackamount = item.Stackamount-1
			end
		end
	end

end

function round(num, idp)

	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult

end

function addItem(id,amount,x,y)

	for i = 1, item.Stackamount do
		if itemArray[i][3] == x and itemArray[i][4] == y and itemArray[i][4] == true then
			x = x + 1
			y = y + 1
		end
	end
	item.amount = item.amount+amount
	item.Stackamount = item.Stackamount + 1
	itemArray[item.Stackamount] = {id,amount,x,y}

end

function item.throw(x,y,id)

	addItem(id,1,x,y)

end

function UPDATE_ITEM(dt)

	item.update(dt)

end

function DRAW_ITEM()

	item.draw()

end