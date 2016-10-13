menu = {}
require "scroll"
require "player"
require "images"
require "monster"

function menu.load()

    images.load()

end

function menu.draw()

    if inmenu == true then
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", 170, 150, 220, 60)

        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Play", 255, 160, 0, 2, 3)
     
        love.graphics.setColor(255, 255, 255)
        love.graphics.printf("Barren World", -480, 60, 100, "center", 0, 3, 3, -155)
        love.graphics.printf("Created by Danny Harris and Ori Taylor", -380, 600, 1020, "center")
    end

end

function love.mousepressed(x, y, button, istouch)

    if button == 1 and x > 170 and x < 390 and y > 150 and y < 210 and inmenu == true then
        inmenu = false

        scroll.load()
        player.load()
        monster.load()

        player.tutorialOn = false
    end

end

function UPDATE_MENU(dt)

    love.mousepressed()

end

function DRAW_MENU()

    menu.draw()

end