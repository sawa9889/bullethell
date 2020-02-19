local utils = require 'utils'

local scout = {}

scout.squad_count = 6
scout.squads_in_wave = 2

scout.width = 40
scout.distance_between = 100
scout.height = 40
scout.distance_from_top = 200

scout.horizontal_distance = 20
scout.vertical_distance = 30

scout.current_speed_x = 50
scout.rotation = 0

scout.image = love.graphics.newImage('images/Scout.png')

scout.current_scout_squad = {}

function scout.new_enemy( position_x, position_y, speed )
    return { position_x     = position_x,
             position_y     = position_y,
             width          = scout.width,
             height         = scout.height,
             rotation       = scout.rotation,
             speed          = speed,
             image          = scout.image,
             type           = scout }
end

function scout.destroy( row, enemy, current_level_enemies )
    current_level_enemies[row][enemy] = nil
end

function scout.new_squad()
    local row = {}
    for wave=1, scout.squads_in_wave do
        for unit=1, scout.squad_count do
            local new_position_x = 500
            local speed = 0
            if wave % 2 == 0 then 
                new_position_x  = love.graphics.getWidth() + (scout.width + scout.distance_between)*unit
                speed = -scout.current_speed_x
            else
                new_position_x  = 0 - (scout.width + scout.distance_between)*unit
                speed = scout.current_speed_x
            end 
            local new_position_y = scout.distance_from_top -- love.graphics.getHeight() - 
            local new_scout = scout.new_enemy( new_position_x, new_position_y, speed )
            table.insert( row, new_scout )
        end
    end
    return row
end

function scout.draw( enemy )
    local scaleX, scaleY = utils.getImageScaleForNewDimensions( enemy.image, enemy.width, enemy.height )
    love.graphics.draw(enemy.image,
                       enemy.position_x,
                       enemy.position_y, 
                       enemy.rotation, 
                       scaleX, 
                       scaleY)
end

function scout.update( dt, enemy )
    if enemy.position_x > 0 and enemy.position_x < love.graphics.getWidth() then
        enemy.rotation   = enemy.rotation + (-enemy.speed / scout.distance_from_top) * dt
        enemy.position_x = enemy.position_x + ((enemy.speed > 0) and 1 or -1) * math.cos(enemy.rotation) -- scout.distance_from_top *
        enemy.position_y = enemy.position_y + ((enemy.speed > 0) and 1 or -1) * math.sin(enemy.rotation)
    else 
        enemy.position_x = enemy.position_x + ((enemy.speed > 0) and 1 or -1)
    end 
end

return scout