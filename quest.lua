quest={}
require "images"

function quest.load ()

	draw = false
	questIndex={{}}
	questIndex[1] = {"Name","collect"--[[objective type]],4--[[objective info]],1--[[objective info no.2]],10--[[coin reqard]],2--[[item reward ID]],1000--[[item amount]],{false, false}--[[if it has been earned/if the player has it]]}
	questIndex[2] = {"It Begins...","event",1,0,10,2,3,{false,true}}
	questIndex[3] = {"Gatherer","collect",3,1,3,4,2,{false,false}}
	questIndex[4] = {"Lumberjack","collect",4,10,20,4,100,{false,false}}
	questIndex[5] = {"Monster Slayer!","kill",1,0,30,4,100,{false,false}}

	eventIndex={{}}
	eventIndex[1] = {1--[[ID]],true--[[is this event happening?]],"player starts the game"}

	printWait = 0

	quest.getQuest(4)
	quest.getQuest(3)

end

function quest.draw()

	if draw == true then
		love.graphics.draw(images.mana,100,100)
	end
	if printWait > 0 then
	    love.graphics.setColor(255, 0, 0)
		love.graphics.print("You have achieved:  '"..questIndex[printID][1].."'", 400, 0,0,2,2)
	    love.graphics.setColor(255, 255, 255)
		love.graphics.print("You have recieved: "..questIndex[printID][5].." coins and "..questIndex[printID][7].." "..item.getItemName(questIndex[printID][6]).."s!",400, 50,0,1.5,1.5)
		printWait = printWait - 0.5
	end

end

function quest.getQuest(questID)

	questIndex[questID][8][2] = true

end

function quest.reward(questID)

	if questIndex[questID][8][1]==false and questIndex[questID][8][2]==true then
		item.grab(0,0,"specificGive",questIndex[questID][6],questIndex[questID][7])
		printWait = 200
		printID = questID
		questIndex[questID][8][2] = false
		questIndex[questID][8][1] = true
	end

end

function quest.checkForCompletedQuests()

	for i=2, #questIndex do
		if questIndex[i][2] == "collect" then
			if hotbar.search(questIndex[i][3],questIndex[i][4]) == true then
				quest.reward(i)
			end
		end
		if questIndex[i][2] == "event" then
			if eventIndex[questIndex[i][3]][2] == true then
				quest.reward(i)
			end
		end
		if questIndex[i][2] == "kill" then
			if eventIndex[questIndex[i][3]][2] == true then
				quest.reward(i)
			end
		end
	end

end

function UPDATE_QUEST(dt)

	quest.checkForCompletedQuests()
	--quest.reward(2)

end

function DRAW_QUEST()

	quest.draw()

end