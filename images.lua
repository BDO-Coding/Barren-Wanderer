images={}

function images.load()

	--Player
	images.playerDown = love.graphics.newImage("images/player/playerDown.png")
	images.playerDownHiRes = love.graphics.newImage("images/player/playerDownHiRes.png")
	images.playerSideHiRes = love.graphics.newImage("images/player/playerSideHiRes.png")
	images.playerUpHiRes = love.graphics.newImage("images/player/playerUpHiRes.png")
	images.playerDownAnimeA = love.graphics.newImage("images/player/playerDownAnimeA.png")
	images.playerDownAnimeD = love.graphics.newImage("images/player/playerDownAnimeD.png")
	images.playerUp = love.graphics.newImage("images/player/playerUp.png")
	images.playerUpAnimeA = love.graphics.newImage("images/player/playerUpAnimeA.png")
	images.playerUpAnimeD = love.graphics.newImage("images/player/playerUpAnimeD.png")
	images.playerSide = love.graphics.newImage("images/player/playerSide.png")

	--Weapons
	images.woodenSword = love.graphics.newImage("images/weapons/swords/woodenSword.png")

	--Icons
	images.health = love.graphics.newImage("images/icons/health.png")
	images.stamina = love.graphics.newImage("images/icons/stamina.png")
	images.mana = love.graphics.newImage("images/icons/mana.png")
	images.hunger = love.graphics.newImage("images/icons/hunger.png")

	--Title
	images.title = love.graphics.newImage("images/title.png")

	--Items
	images.stone = love.graphics.newImage("images/items/stone.png")
	images.stick = love.graphics.newImage("images/items/stick.png")
	images.log = love.graphics.newImage("images/items/log.png")
	images.mucus = love.graphics.newImage("images/items/mucus.png")
	images.copperBar = love.graphics.newImage("images/items/copperBar.png")

	--Mobs
	images.chicken = love.graphics.newImage("images/entities/mobs/chicken.png")
	images.parrot = love.graphics.newImage("images/entities/mobs/parrot.png")
	images.worm = love.graphics.newImage("images/entities/mobs/worm.png")
	images.evilworm = love.graphics.newImage("images/entities/mobs/evilWorm.png")

	--GUI
	images.crafting = love.graphics.newImage("images/GUI/craftingGUI.png")
	images.hotbar = love.graphics.newImage("images/GUI/hotbar.png")
	images.guiBar = love.graphics.newImage("images/GUI/bar.png")
	images.guiBarInside = love.graphics.newImage("images/GUI/barInside.png")
	images.handCursor = love.mouse.newCursor("images/GUI/cursor.png")

	--Other
	images.bag = love.graphics.newImage("images/entities/bag.png")

	--Particles
	images.healing = love.graphics.newImage("images/particles/healing.png")


	--SETS NEAREST NEIGHBOUR FILTERS!

	--Player
	images.playerDown:setFilter("nearest", "nearest")
	images.playerDownHiRes:setFilter("nearest", "nearest")
	images.playerSideHiRes:setFilter("nearest", "nearest")
	images.playerUpHiRes:setFilter("nearest", "nearest")
	images.playerDownAnimeA:setFilter("nearest", "nearest")
	images.playerDownAnimeD:setFilter("nearest", "nearest")
	images.playerUp:setFilter("nearest", "nearest")
	images.playerUpAnimeA:setFilter("nearest", "nearest")
	images.playerUpAnimeD:setFilter("nearest", "nearest")
	images.playerSide:setFilter("nearest", "nearest")

	--Weapons
	images.woodenSword:setFilter("nearest", "nearest")

	--Icons
	images.health:setFilter("nearest", "nearest")
	images.stamina:setFilter("nearest", "nearest")
	images.mana:setFilter("nearest", "nearest")
	images.hunger:setFilter("nearest", "nearest")

	--Title
	images.title:setFilter("nearest", "nearest")

	--Items
	images.stone:setFilter("nearest", "nearest")
	images.stick:setFilter("nearest", "nearest")
	images.log:setFilter("nearest", "nearest")
	images.mucus:setFilter("nearest", "nearest")
	images.copperBar:setFilter("nearest", "nearest")

	--Mobs
	images.chicken:setFilter("nearest", "nearest")
	images.parrot:setFilter("nearest", "nearest")
	images.worm:setFilter("nearest", "nearest")
	images.evilworm = love.graphics.newImage("images/entities/mobs/evilWorm.png")

	--GUI
	images.crafting = love.graphics.newImage("images/GUI/craftingGUI.png")
	images.hotbar = love.graphics.newImage("images/GUI/hotbar.png")
	images.guiBar = love.graphics.newImage("images/GUI/bar.png")
	images.guiBarInside = love.graphics.newImage("images/GUI/barInside.png")
	images.handCursor = love.mouse.newCursor("images/GUI/cursor.png")

	--Other
	images.bag = love.graphics.newImage("images/entities/bag.png")

	--Particles
	images.healing = love.graphics.newImage("images/particles/healing.png")

end

function UPDATE_IMAGES(dt)

	images.update()

end