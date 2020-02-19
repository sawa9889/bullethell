local ship = {}

ship.squad_count = 2
ship.squads_in_wave = 1

ship.top_left_position_x = 50
ship.top_left_position_y = 50

ship.invader_width = 40
ship.invader_height = 40

ship.horizontal_distance = 20
ship.vertical_distance = 30

ship.current_speed_x = 50
ship.current_direction = 'right'

ship.left_border_x = 40
ship.right_border_x = 10
ship.image = love.graphics.newImage('images/Ship.png')

ship.current_level_ship = {}

local initial_speed_x = 50
local initial_direction = 'right'
ship.speed_x_increase_on_destroying = 10

function ship.new_invader( position_x, position_y )
    return { position_x = position_x,
                 position_y = position_y,
                 width = ship.invader_width,
                 height = ship.invader_height,
                 image = ship.image}
end

function ship.destroy_invader( row, invader )
    ship.current_level_ship[row][invader] = nil
    local ship_row_count = 0
    for _, invader in pairs( ship.current_level_ship[row] ) do
        ship_row_count = ship_row_count + 1
    end
    if ship_row_count == 0 then
        ship.current_level_ship[row] = nil
    end
    ship.current_speed_x = ship.current_speed_x + ship.speed_x_increase_on_destroying
 end

function ship.new_row( row_index )
    local row = {}
    for col_index=1, ship.columns - (row_index % 2) do
        local new_invader_position_x = ship.top_left_position_x + ship.invader_width * (row_index % 2) + (col_index - 1) * (ship.invader_width + ship.horizontal_distance)
        local new_invader_position_y = ship.top_left_position_y + (row_index - 1) * (ship.invader_height + ship.vertical_distance)
        local new_invader = ship.new_invader( new_invader_position_x, new_invader_position_y )
        table.insert( row, new_invader )
    end
    return row
end

function ship.construct_level()
    ship.current_speed_x = initial_speed_x
    for row_index=1, ship.rows do
        local ship_row = ship.new_row( row_index )
        table.insert( ship.current_level_ship, ship_row )
    end
end

function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end
local scaleX, scaleY = getImageScaleForNewDimensions( ship.image, ship.invader_width, ship.invader_height )

function ship.draw_invader( single_invader )
    love.graphics.draw(single_invader.image,
                       single_invader.position_x,
                       single_invader.position_y, 
                       rotation, 
                       scaleX, 
                       scaleY )
end

function ship.draw()
    for _, invader_row in pairs( ship.current_level_ship ) do
        for _, invader in pairs( invader_row ) do
            ship.draw_invader( invader, is_miniboss )
        end
    end
end

function ship.descend_by_row_invader( single_invader )
    single_invader.position_y = single_invader.position_y + ship.vertical_distance / 2
end

function ship.descend_by_row()
    for _, invader_row in pairs( ship.current_level_ship ) do
        for _, invader in pairs( invader_row ) do
            ship.descend_by_row_invader( invader )
        end
    end
end

function ship.update_invader( dt, single_invader )
    single_invader.position_x = single_invader.position_x + ((ship.current_direction=='right') and 1 or -1) * ship.current_speed_x * dt

    if single_invader.position_x > ship.right_border_x then ship.right_border_x = single_invader.position_x end
    if single_invader.position_x < ship.left_border_x then ship.left_border_x = single_invader.position_x end
end

function ship.update( dt )
    local ship_rows = 0
    for _, invader_row in pairs( ship.current_level_ship ) do
        ship_rows = ship_rows + 1
    end
    if ship_rows == 0 then
        ship.no_more_ship = true
    else
        for _, invader_row in pairs( ship.current_level_ship ) do
            for _, invader in pairs( invader_row ) do
                ship.update_invader( dt, invader)
            end
        end

        if ship.right_border_x > ( love.graphics.getWidth() - ship.invader_width ) then 
            ship.right_border_x = 0
            ship.current_direction = 'left'
        elseif ship.left_border_x < 0 then
            ship.left_border_x = 0
            ship.current_direction = 'right'
            ship.descend_by_row()
        end
    end
end

return ship