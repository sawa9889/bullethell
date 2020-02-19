local scout     = require 'enemies/scout'
local bombarder = require 'enemies/bombarder'
local torpedo   = require 'enemies/torpedo'
local ship      = require 'enemies/ship'
local utils = require 'utils'

local enemies = {}

enemies.current_level_enemies = {}
time = 0

local initial_speed_x = 50
local initial_direction = 'right'
enemies.speed_x_increase_on_destroying = 10

function enemies.destroy_enemy( row, enemy )
    enemies.current_level_enemies[row][enemy].type.destroy(row, enemy, enemies.current_level_enemies)
 end

function enemies.new_enemy_row( type )
    table.insert(enemies.current_level_enemies, type.new_squad())
end

function enemies.update_field( dt )
    if time - dt < 0  then
        enemies.new_enemy_row( scout )
        time = 30
    else
        time = time - dt
    end
end

function enemies.draw_enemy( enemy )
    enemy.type.draw( enemy )
end

function enemies.draw()
    for _, enemy_squad in pairs( enemies.current_level_enemies ) do
        for _, enemy in pairs( enemy_squad ) do
            enemies.draw_enemy( enemy )
        end
    end
end

function enemies.update_enemy( dt, enemy )
    enemy.type.update( dt, enemy )
end

function enemies.update( dt )
    local enemies_rows = 0
    for _, enemy_squad in pairs( enemies.current_level_enemies ) do
        for _, enemy in pairs( enemy_squad ) do
            enemies.update_enemy(dt, enemy)
        end
    end
    enemies.update_field( dt )
end

return enemies