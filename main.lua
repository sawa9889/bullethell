local player = require 'player'

function love.load() -- Запускается при запуске приложения
end

function love.keyreleased( key ) -- кнопка отжата
end

function love.draw() -- отрисовка каждый кадр?
        player.draw()
end

function love.update( dt ) -- Каждый кадр
        player.update( dt )
end