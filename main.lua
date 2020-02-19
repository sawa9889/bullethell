local player 			= require 'player'
local enemies  			= require 'enemies/enemies'
local bullets   		= require 'bullets/bullets'
local bounce_bullet   	= require 'bullets/bounce_bullet'
local normal_bullet   	= require 'bullets/bounce_bullet'
local tri_bullet   		= require 'bullets/tri_bullet'
local blast_bullet   	= require 'bullets/blast_bullet'
local collisions 		= require 'collision'

function love.load() -- Запускается при запуске приложения
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
    enemies.draw()
    bullets.draw()
end

function love.update( dt ) -- Каждый кадр
    player.update( dt )
    enemies.update( dt )
    collisions.resolve_collisions( enemies, bullets )
    bullets.update( dt )

end