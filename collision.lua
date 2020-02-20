local collisions = {}
-- local bullets   = require 'bullets/bullets'

function collisions.check_rectangles_overlap( a, b )
    local overlap = false
    if not( a.x + a.width < b.x or b.x + b.width < a.x or
            a.y + a.height < b.y or b.y + b.height < a.y ) then
        overlap = true
    end
    return overlap
end

function collisions.invaders_bullets_collision( enemies, bullets )
    local overlap
    
    for b_i, bullet in pairs( bullets.current_level_bullets) do
        local a = { x = bullet.position_x,
                    y = bullet.position_y,
                    width = bullet.width,
                    height = bullet.height }
        
        for i_i, enemy_row in pairs( enemies.current_level_enemies ) do
            for i_j, enemy in pairs( enemy_row ) do
                local b = { x = enemy.position_x,
                            y = enemy.position_y,
                            width = enemy.width,
                            height = enemy.height }
                overlap = collisions.check_rectangles_overlap( a, b )
                if overlap then
                    enemies.destroy_enemy( i_i, i_j )
                    bullets.destroy_bullet( b_i )
                end
            end
        end
        if bullet.position_y > love.graphics.getHeight() or bullet.position_y < 0 or bullet.position_x > love.graphics.getWidth() or bullet.position_x < 0 then bullets.destroy_bullet(b_i) end
    end
end


function collisions.resolve_collisions( enemies, bullets )
    collisions.invaders_bullets_collision( enemies, bullets )
end

return collisions