local blast_bullet = {}

blast_bullet.current_speed_y = -200
blast_bullet.width = 5
blast_bullet.height = 15
blast_bullet.bullets_in_shoot = 1
blast_bullet.distance_between_bullets = 0
blast_bullet.bullets_angle = 0

function blast_bullet.destroy_bullet()
end

function blast_bullet.update_bullet( dt, bullet )
    bullet.position_y = bullet.position_y + bullet.current_speed * dt
end

function blast_bullet.update( dt )
    for _, bullet in pairs(blast_bullet.current_level_blast_bullet) do
        blast_bullet.update_bullet( dt, bullet )
    end
end

return blast_bullet