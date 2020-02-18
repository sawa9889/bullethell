local player 	= require 'player'
local invaders  = require 'enemies'
local bullets   = require 'bullets'
local collisions= require 'collision'

function love.load() -- Запускается при запуске приложения
        invaders.construct_level()
end

function love.keyreleased( key ) -- кнопка отжата`
    if key == 'space' then
        bullets.fire( player )
    end
end

function love.draw() -- отрисовка каждый кадр?
    player.draw()
    invaders.draw()
    bullets.draw()
end

function love.update( dt ) -- Каждый кадр
    player.update( dt )
    invaders.update( dt )
    collisions.resolve_collisions( invaders, walls, bullets )
    bullets.update( dt )
end