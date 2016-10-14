menu = {}
require "scroll"
require "player"
require "images"
require "monster"

function menu.load()

    images.load()

    options = false

    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()

end

function menu.draw()

    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()

    if ingame == false then

        love.graphics.setBackgroundColor( 17, 240, 240)

        love.graphics.setColor(0, 0, 0)

        love.graphics.printf("Barren World", -480, 60, 100, "center", 0, 3, 3, -155)
        love.graphics.printf("Created by Danny Harris and Ori Taylor", -380, 600, 1020, "center")

    end

    if inmenu == true and options == false and ingame == false then

        if mouseX > 170 and mouseX < 390 and mouseY > 150 and mouseY < 210 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 150, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 150, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 250 and mouseY < 310 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 250, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 250, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 170, 150, 220, 60)
        love.graphics.rectangle("line", 170, 250, 220, 60)

        love.graphics.print("Play", 255, 160, 0, 2, 3)
        love.graphics.print("Options", 232, 260, 0, 2, 3)

    end

    if inmenu == true and options == false and ingame == true then

        if mouseX > 170 and mouseX < 390 and mouseY > 150 and mouseY < 210 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 150, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 150, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 250 and mouseY < 310 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 250, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 250, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 170, 150, 220, 60)
        love.graphics.rectangle("line", 170, 250, 220, 60)

        love.graphics.print("Play", 255, 160, 0, 2, 3)
        love.graphics.print("Options", 232, 260, 0, 2, 3)

    end

end

function menu.options()

    if inmenu == true and options == true then

        if mouseX > 170 and mouseX < 390 and mouseY > 500 and mouseY < 560 then
            love.graphics.setColor(30, 125, 49)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        else
            love.graphics.setColor(31, 191, 63)
            love.graphics.rectangle("fill", 170, 500, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 170, 500, 220, 60)

        love.graphics.print("Back", 249, 510, 0, 2, 3)

    end

end

function love.mousepressed(x, y, button, istouch)

    if inmenu == true then
        if button == 1 and x > 170 and x < 390 and y > 150 and y < 210 then

            inmenu = false
            ingame = true

            scroll.load()
            player.load()
            monster.load()

        end

        if button == 1 and x > 170 and x < 390 and y > 250 and y < 310 then

            options = true

        end

        if button == 1 and x > 170 and x < 390 and y > 500 and y < 560 and options == true then

            options = false

        end
    end

end

function UPDATE_MENU(dt)

    love.mousepressed()

end

function DRAW_MENU()

    menu.draw()
    menu.options()

end