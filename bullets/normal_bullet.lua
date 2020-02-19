local normal_bullet = {}

normal_bullet.current_speed_y = -200
normal_bullet.width = 2
normal_bullet.height = 10

normal_bullet.current_level_normal_bullet = {}

function normal_bullet.destroy_bullet()
end

function normal_bullet.new_bullet(position_x, position_y)
    return { position_x = position_x,
             position_y = position_y,
             width = normal_bullet.width,
             height = normal_bullet.height,
             type = normal_bullet  }
end

function normal_bullet.fire( player, current_level_bullets )
    local position_x = player.position_x + player.width / 2
    local position_y = player.position_y
    local new_bullet = normal_bullet.new_bullet( position_x, position_y )
    table.insert(current_level_bullets, new_bullet)
end

function normal_bullet.draw_bullet( bullet )
    love.graphics.rectangle( 'fill',
                             bullet.position_x,
                             bullet.position_y,
                             bullet.width,
                             bullet.height
                           )
end

function normal_bullet.draw()
    for _, bullet in pairs(normal_bullet.current_level_normal_bullet) do
        normal_bullet.draw_bullet( bullet )
    end
end

function normal_bullet.update_bullet( dt, bullet )
    bullet.position_y = bullet.position_y + normal_bullet.current_speed_y * dt
    if bullet.position_y > love.graphics.getHeight() then normal_bullet.destroy_bullet (bullet_i) end
end

function normal_bullet.update( dt )
    for _, bullet in pairs(normal_bullet.current_level_normal_bullet) do
        normal_bullet.update_bullet( dt, bullet )
    end
end

return normal_bullet