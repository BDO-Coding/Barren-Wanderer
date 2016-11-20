utensil={}
require "images"

function utensil.load ()

	currentWeapon = {}
	utensilIndex = {{}}
	utensilIndex[1] = {"Name","Type","right"--[[hand to use]], images.woodenSword--[[Image]], 0.1--[[Damage]]}
	utensilIndex[2] = {"Wooden Sword","melee","left",images.woodenSword, 0.1}

end

function utensil.update(dt)

	currentWeapon = utensilIndex[2]

end

function UPDATE_UTENSIL(dt)

	utensil.update(dt)

end