utensil={}
require "images"

function utensil.load ()

	utensilIndex = {{}}
	utensilIndex[1] = {"Name","Type",false--[[uses right hand]],true--[[uses left hand]]}

end

function utensil.draw()

end

function utensil.update(dt)

end

function DRAW_UTENSIL()

	utensil.draw()

end

function UPDATE_UTENSIL(dt)

	utensil.update(dt)

end