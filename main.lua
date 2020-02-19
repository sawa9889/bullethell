local player 			= require 'player'
local invaders  		= require 'enemies'
local bullets   		= require 'bullets/bullets'
local bounce_bullet   	= require 'bullets/bounce_bullet'
local normal_bullet   	= require 'bullets/bounce_bullet'
local tri_bullet   		= require 'bullets/tri_bullet'
local blast_bullet   	= require 'bullets/blast_bullet'
local collisions 		= require 'collision'

key_pressed = 'x'
function love.load() -- Запускается при запуске приложения
        invaders.construct_level()
end

function love.keyreleased( key ) -- кнопка отжата`
    if key == 'space' then
    	mode = normal_bullet
    elseif key == "z" then
    	mode = blast_bullet
    elseif key == 'x' then
    	mode = tri_bullet
    elseif key == 'c' then
    	mode = bounce_bullet
    end
    if mode then bullets.fire( player, mode ) end 
    mode = nil
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