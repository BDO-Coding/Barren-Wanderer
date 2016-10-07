images={}

function images.load()

	images.playerDown = love.graphics.newImage("images/player/playerDown.png")
	images.playerDownA = love.graphics.newImage("images/player/playerDownAnimation.png")
	images.playerUp = love.graphics.newImage("images/player/playerUp.png")
	images.playerSide = love.graphics.newImage("images/player/playerSide.png")

end

function images.update(dt)

end

function UPDATE_IMAGES(dt)

	images.update()

end