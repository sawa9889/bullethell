local collisions = {}
local bullets   = require 'bullets/bullets'

function collisions.check_rectangles_overlap( a, b )
    local overlap = false
    if not( a.x + a.width < b.x or b.x + b.width < a.x or
            a.y + a.height < b.y or b.y + b.height < a.y ) then
        overlap = true
    end
    return overlap
end

function collisions.invaders_bullets_collision( invaders, bullets )
    local overlap
    
    for b_i, bullet in pairs( bullets.current_level_bullets) do
        local a = { x = bullet.position_x,
                    y = bullet.position_y,
                    width = bullet.width,
                    height = bullet.height }
        
        for i_i, invader_row in pairs( invaders.current_level_invaders ) do
            for i_j, invader in pairs( invader_row ) do
                local b = { x = invader.position_x,
                            y = invader.position_y,
                            width = invader.width,
                            height = invader.height }
                overlap = collisions.check_rectangles_overlap( a, b )
                if overlap then
                    invaders.destroy_invader( i_i, i_j )
                    bullets.destroy_bullet( b_i )
                end
            end
        end
    end
end


function collisions.resolve_collisions( invaders, walls )
    collisions.invaders_bullets_collision( invaders, bullets )
end

return collisions