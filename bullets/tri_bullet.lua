local tri_bullet = {}

tri_bullet.current_speed_y = -200
tri_bullet.width = 0.5
tri_bullet.height = 5
tri_bullet.bullets_in_shoot = 3
tri_bullet.distance_between_bullets = 2
tri_bullet.bullets_angle = (1/18)*math.pi

function tri_bullet.destroy_bullet()
end

function tri_bullet.update_bullet( dt, bullet )
    bullet.position_x = bullet.position_x + bullet.current_speed * dt * math.cos(bullet.move_angle)
    bullet.position_y = bullet.position_y + bullet.current_speed * dt * math.sin(bullet.move_angle)
end

function tri_bullet.update( dt )
    for _, bullet in pairs(tri_bullet.current_level_tri_bullet) do
        tri_bullet.update_bullet( dt, bullet )
    end
end

return tri_bullet