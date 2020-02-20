local normal_bullet = {}

normal_bullet.current_speed_y = -200
normal_bullet.width = 2
normal_bullet.height = 10
normal_bullet.bullets_in_shoot = 2
normal_bullet.distance_between_bullets = 4
normal_bullet.bullets_angle = 0

function normal_bullet.destroy_bullet()
end

function normal_bullet.update_bullet( dt, bullet )
    bullet.position_y = bullet.position_y + bullet.current_speed * dt
end

function normal_bullet.update( dt )
    for _, bullet in pairs(normal_bullet.current_level_normal_bullet) do
        normal_bullet.update_bullet( dt, bullet )
    end
end

return normal_bullet