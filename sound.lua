sound = {}

function sound.importSound()

	bg_music = love.audio.newSource("elvishMusic.mp3")
end

function sound.playSound()

	bg_music:play()
end

function sound.otherSoundOperations()

	bg_music:setLooping(true)

end

function sound.load()

	sound.importSound()
	sound.playSound()
	sound.otherSoundOperations()

end

