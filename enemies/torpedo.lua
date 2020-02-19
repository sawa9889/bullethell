local torpedo = {}

torpedo.squad_count = 4
torpedo.squads_in_wave = 1

torpedo.top_left_position_x = 50
torpedo.top_left_position_y = 50

torpedo.invader_width = 40
torpedo.invader_height = 40

torpedo.horizontal_distance = 20
torpedo.vertical_distance = 30

torpedo.current_speed_x = 50
torpedo.current_direction = 'right'

torpedo.left_border_x = 40
torpedo.right_border_x = 10
torpedo.image = love.graphics.newImage('images/Torpedo.png')

torpedo.current_level_torpedo = {}

local initial_speed_x = 50
local initial_direction = 'right'
torpedo.speed_x_increase_on_destroying = 10

function torpedo.new_invader( position_x, position_y )
    return { position_x = position_x,
                 position_y = position_y,
                 width = torpedo.invader_width,
                 height = torpedo.invader_height,
                 image = torpedo.image}
end

function torpedo.destroy_invader( row, invader )
    torpedo.current_level_torpedo[row][invader] = nil
    local torpedo_row_count = 0
    for _, invader in pairs( torpedo.current_level_torpedo[row] ) do
        torpedo_row_count = torpedo_row_count + 1
    end
    if torpedo_row_count == 0 then
        torpedo.current_level_torpedo[row] = nil
    end
    torpedo.current_speed_x = torpedo.current_speed_x + torpedo.speed_x_increase_on_destroying
 end

function torpedo.new_row( row_index )
    local row = {}
    for col_index=1, torpedo.columns - (row_index % 2) do
        local new_invader_position_x = torpedo.top_left_position_x + torpedo.invader_width * (row_index % 2) + (col_index - 1) * (torpedo.invader_width + torpedo.horizontal_distance)
        local new_invader_position_y = torpedo.top_left_position_y + (row_index - 1) * (torpedo.invader_height + torpedo.vertical_distance)
        local new_invader = torpedo.new_invader( new_invader_position_x, new_invader_position_y )
        table.insert( row, new_invader )
    end
    return row
end

function torpedo.construct_level()
    torpedo.current_speed_x = initial_speed_x
    for row_index=1, torpedo.rows do
        local torpedo_row = torpedo.new_row( row_index )
        table.insert( torpedo.current_level_torpedo, torpedo_row )
    end
end

function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end
local scaleX, scaleY = getImageScaleForNewDimensions( torpedo.image, torpedo.invader_width, torpedo.invader_height )

function torpedo.draw_invader( single_invader )
    love.graphics.draw(single_invader.image,
                       single_invader.position_x,
                       single_invader.position_y, 
                       rotation, 
                       scaleX, 
                       scaleY )
end

function torpedo.draw()
    for _, invader_row in pairs( torpedo.current_level_torpedo ) do
        for _, invader in pairs( invader_row ) do
            torpedo.draw_invader( invader, is_miniboss )
        end
    end
end

function torpedo.descend_by_row_invader( single_invader )
    single_invader.position_y = single_invader.position_y + torpedo.vertical_distance / 2
end

function torpedo.descend_by_row()
    for _, invader_row in pairs( torpedo.current_level_torpedo ) do
        for _, invader in pairs( invader_row ) do
            torpedo.descend_by_row_invader( invader )
        end
    end
end

function torpedo.update_invader( dt, single_invader )
    single_invader.position_x = single_invader.position_x + ((torpedo.current_direction=='right') and 1 or -1) * torpedo.current_speed_x * dt

    if single_invader.position_x > torpedo.right_border_x then torpedo.right_border_x = single_invader.position_x end
    if single_invader.position_x < torpedo.left_border_x then torpedo.left_border_x = single_invader.position_x end
end

function torpedo.update( dt )
    local torpedo_rows = 0
    for _, invader_row in pairs( torpedo.current_level_torpedo ) do
        torpedo_rows = torpedo_rows + 1
    end
    if torpedo_rows == 0 then
        torpedo.no_more_torpedo = true
    else
        for _, invader_row in pairs( torpedo.current_level_torpedo ) do
            for _, invader in pairs( invader_row ) do
                torpedo.update_invader( dt, invader)
            end
        end

        if torpedo.right_border_x > ( love.graphics.getWidth() - torpedo.invader_width ) then 
            torpedo.right_border_x = 0
            torpedo.current_direction = 'left'
        elseif torpedo.left_border_x < 0 then
            torpedo.left_border_x = 0
            torpedo.current_direction = 'right'
            torpedo.descend_by_row()
        end
    end
end

return torpedo