local blast_bullet = {}

blast_bullet.current_speed_y = -200
blast_bullet.width = 5
blast_bullet.height = 15

blast_bullet.current_level_blast_bullet = {}

function blast_bullet.destroy_bullet()
end

function blast_bullet.new_bullet(position_x, position_y)
    return { position_x = position_x,
             position_y = position_y,
             width = blast_bullet.width,
             height = blast_bullet.height,
             type = blast_bullet }
end

function blast_bullet.fire( player, current_level_bullets )
    local position_x = player.position_x + player.width / 2
    local position_y = player.position_y
    local new_bullet = blast_bullet.new_bullet( position_x, position_y )
    table.insert(current_level_bullets, new_bullet)
end

function blast_bullet.draw_bullet( bullet )
    love.graphics.rectangle( 'fill',
                             bullet.position_x,
                             bullet.position_y,
                             bullet.width,
                             bullet.height
                           )
end

function blast_bullet.draw()
    for _, bullet in pairs(blast_bullet.current_level_blast_bullet) do
        blast_bullet.draw_bullet( bullet )
    end
end

function blast_bullet.update_bullet( dt, bullet )
    bullet.position_y = bullet.position_y + blast_bullet.current_speed_y * dt
    if bullet.position_y > love.graphics.getHeight() then blast_bullet.destroy_bullet (bullet_i) end
end

function blast_bullet.update( dt )
    for _, bullet in pairs(blast_bullet.current_level_blast_bullet) do
        blast_bullet.update_bullet( dt, bullet )
    end
end

return blast_bullet