local bounce_bullet     = require 'bullets/bounce_bullet'
local tri_bullet        = require 'bullets/tri_bullet'
local blast_bullet      = require 'bullets/blast_bullet'
local normal_bullet     = require 'bullets/normal_bullet'

local bullets = {}

bullets.current_speed_y = -200
bullets.width = 2
bullets.height = 10

bullets.current_level_bullets = {}

function bullets.new_bullet(position_x, position_y, angle, type)
    return { position_x = position_x,
             position_y = position_y,
             move_angle = angle,
             current_speed = type.current_speed_y,
             width = type.width,
             height = type.height,
             type = type  }
end

function bullets.fire( player, type )
    for bullet=1, type.bullets_in_shoot do
            local position_x = player.position_x + player.width / 2 + ((bullet % 2 == 0) and 1 or -1 ) * ((type.bullets_in_shoot % 2 ~= 0 and bullet == 1) and 0 or 1) * type.distance_between_bullets
            local position_y = player.position_y
            local angle = math.pi/2 +  ((bullet % 2 == 0) and 1 or -1 ) * ((type.bullets_in_shoot % 2 ~= 0 and bullet == 1) and 0 or 1) * (math.floor(bullet / 2 )) * type.bullets_angle
            local new_bullet = bullets.new_bullet( position_x, position_y, angle, type )
            table.insert(bullets.current_level_bullets, new_bullet)
    end
end

function bullets.destroy_bullet( bullet_i )
    bullets.current_level_bullets[bullet_i].type.destroy_bullet()
    bullets.current_level_bullets[bullet_i] = nil
end

function bullets.draw_bullet( bullet )
    bullet.type.draw_bullet(bullet)
end

function bullets.draw_bullet( bullet )
    love.graphics.rectangle( 'fill',
                             bullet.position_x,
                             bullet.position_y,
                             bullet.width,
                             bullet.height
                           )
end

function bullets.draw()
    for b_i, bullet in pairs(bullets.current_level_bullets) do
        bullets.draw_bullet( bullet )
        love.graphics.printf(bullet.move_angle/math.pi * 180,100+25*b_i,100+25*b_i,100,'right')
    end
end

function bullets.update_bullet( dt, bullet )
    bullet.type.update_bullet( dt, bullet )
end

function bullets.update( dt )
    for _, bullet in pairs(bullets.current_level_bullets) do
        bullets.update_bullet( dt, bullet )
    end
end

return bullets