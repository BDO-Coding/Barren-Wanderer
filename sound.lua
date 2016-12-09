sound = {}

function importSound()

	bg_music = love.audio.newSource("elvishMusic.mp3")
end

function playSound()

	bg_music:play()
end

function otherSoundOperations()

	bg_music:setLooping(true)

end

function sound.load()

	sound.importSound()
	sound.playSound()
	sound.otherSoundOperations()

end

