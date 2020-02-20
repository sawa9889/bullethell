local bounce_bullet = {}

bounce_bullet.current_speed_y = -200
bounce_bullet.width = 1.5
bounce_bullet.height = 7
bounce_bullet.bullets_in_shoot = 1
bounce_bullet.distance_between_bullets = 0
bounce_bullet.bullets_angle = 0

function bounce_bullet.destroy_bullet()
end

function bounce_bullet.update_bullet( dt, bullet )
    bullet.position_y = bullet.position_y + bullet.current_speed * dt
end

function bounce_bullet.update( dt )
    for _, bullet in pairs(bounce_bullet.current_level_bullets) do
        bounce_bullet.update_bullet( dt, bullet )
    end
end

return bounce_bullet