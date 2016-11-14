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

	--Hotbar & Other GUI
	images.hotbar = love.graphics.newImage("images/player/hotbar.png")
	images.health = love.graphics.newImage("images/player/health.png")
	images.stamina = love.graphics.newImage("images/player/stamina.png")
	images.mana = love.graphics.newImage("images/player/mana.png")
	images.hunger = love.graphics.newImage("images/player/hunger.png")
	images.guiBar = love.graphics.newImage("images/player/bar.png")
	images.guiBarInside = love.graphics.newImage("images/player/barInside.png")

	--Title
	images.title = love.graphics.newImage("images/title.png")

	--Items
	images.stone = love.graphics.newImage("images/entities/items/stone.png")
	images.stick = love.graphics.newImage("images/entities/items/stick.png")

	--Monsters

	--Animals
	images.chicken = love.graphics.newImage("images/entities/animals/chicken.png")
	images.parrot = love.graphics.newImage("images/entities/animals/parrot.png")

end

function UPDATE_IMAGES(dt)

	images.update()

end