local tri_bullet = {}

tri_bullet.current_speed_y = -200
tri_bullet.width = 0.5
tri_bullet.height = 5

tri_bullet.current_level_tri_bullet = {}

function tri_bullet.destroy_bullet()
end

function tri_bullet.new_bullet(position_x, position_y)
    return { position_x = position_x,
             position_y = position_y,
             width = tri_bullet.width,
             height = tri_bullet.height,
             type = tri_bullet  }
end

function tri_bullet.fire( player, current_level_bullets )
    local position_x = player.position_x + player.width / 2
    local position_y = player.position_y
    local new_bullet = tri_bullet.new_bullet( position_x + player.width / 4, position_y )
    table.insert(current_level_bullets, new_bullet)
    new_bullet = tri_bullet.new_bullet( position_x - player.width / 4, position_y )
    table.insert(current_level_bullets, new_bullet)
    new_bullet = tri_bullet.new_bullet( position_x, position_y )
    table.insert(current_level_bullets, new_bullet)
end

function tri_bullet.draw_bullet( bullet )
    love.graphics.rectangle( 'fill',
                             bullet.position_x,
                             bullet.position_y,
                             bullet.width,
                             bullet.height
                           )
end

function tri_bullet.draw()
    for _, bullet in pairs(tri_bullet.current_level_tri_bullet) do
        tri_bullet.draw_bullet( bullet )
    end
end

function tri_bullet.update_bullet( dt, bullet )
    bullet.position_y = bullet.position_y + tri_bullet.current_speed_y * dt
    if bullet.position_y > love.graphics.getHeight() then tri_bullet.destroy_bullet (bullet_i) end
end

function tri_bullet.update( dt )
    for _, bullet in pairs(tri_bullet.current_level_tri_bullet) do
        tri_bullet.update_bullet( dt, bullet )
    end
end

return tri_bullet