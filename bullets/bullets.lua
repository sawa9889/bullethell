local bounce_bullet     = require 'bullets/bounce_bullet'
local tri_bullet        = require 'bullets/tri_bullet'
local blast_bullet      = require 'bullets/blast_bullet'
local normal_bullet     = require 'bullets/normal_bullet'

local bullets = {}

bullets.current_speed_y = -200
bullets.width = 2
bullets.height = 10

bullets.current_level_bullets = {}

function bullets.destroy_bullet( bullet_i)
    bullets.current_level_bullets[bullet_i].type.destroy_bullet()
    bullets.current_level_bullets[bullet_i] = nil
end

function bullets.fire( player, type )
    type.fire (player, bullets.current_level_bullets)
end

function bullets.draw_bullet( bullet )
    bullet.type.draw_bullet(bullet)
end

function bullets.draw()
    for _, bullet in pairs(bullets.current_level_bullets) do
        bullets.draw_bullet( bullet )
    end
end

function bullets.update_bullet( dt, bullet )
    bullet.type.update_bullet( dt, bullet )
    -- bullet.position_y = bullet.position_y + bullets.current_speed_y * dt
    if bullet.position_y > love.graphics.getHeight() then bullets.destroy_bullet (bullet_i) end
end

function bullets.update( dt )
    for _, bullet in pairs(bullets.current_level_bullets) do
        bullets.update_bullet( dt, bullet )
    end
end

return bullets