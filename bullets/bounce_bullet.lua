local bounce_bullet = {}

bounce_bullet.current_speed_y = -200
bounce_bullet.width = 1.5
bounce_bullet.height = 7

bounce_bullet.current_level_bounce_bullet = {}

function bounce_bullet.destroy_bullet()
end

function bounce_bullet.new_bullet(position_x, position_y)
    return { position_x = position_x,
             position_y = position_y,
             width = bounce_bullet.width,
             height = bounce_bullet.height,
             type = bounce_bullet  }
end

function bounce_bullet.fire( player, current_level_bullets )
    local position_x = player.position_x + player.width / 2
    local position_y = player.position_y
    local new_bullet = bounce_bullet.new_bullet( position_x, position_y )
    table.insert(current_level_bullets, new_bullet)
end

function bounce_bullet.draw_bullet( bullet )
    love.graphics.rectangle( 'fill',
                             bullet.position_x,
                             bullet.position_y,
                             bullet.width,
                             bullet.height
                           )
end

function bounce_bullet.draw()
    for _, bullet in pairs(bounce_bullet.current_level_bullets) do
        bounce_bullet.draw_bullet( bullet )
    end
end

function bounce_bullet.update_bullet( dt, bullet )
    bullet.position_y = bullet.position_y + bounce_bullet.current_speed_y * dt
    if bullet.position_y > love.graphics.getHeight() then bounce_bullet.destroy_bullet (bullet_i) end
end

function bounce_bullet.update( dt )
    for _, bullet in pairs(bounce_bullet.current_level_bullets) do
        bounce_bullet.update_bullet( dt, bullet )
    end
end

return bounce_bullet