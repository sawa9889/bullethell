local bombarder = {}

bombarder.squad_count = 3
bombarder.squads_in_wave = 2

bombarder.top_left_position_x = 50
bombarder.top_left_position_y = 50

bombarder.invader_width = 40
bombarder.invader_height = 40

bombarder.horizontal_distance = 20
bombarder.vertical_distance = 30

bombarder.current_speed_x = 50
bombarder.current_direction = 'right'

bombarder.left_border_x = 40
bombarder.right_border_x = 10
bombarder.image = love.graphics.newImage('images/Bombarder.png')

bombarder.current_level_bombarder = {}

local initial_speed_x = 50
local initial_direction = 'right'
bombarder.speed_x_increase_on_destroying = 10

function bombarder.new_invader( position_x, position_y )
    return { position_x = position_x,
                 position_y = position_y,
                 width = bombarder.invader_width,
                 height = bombarder.invader_height,
                 image = bombarder.image}
end

function bombarder.destroy_invader( row, invader )
    bombarder.current_level_bombarder[row][invader] = nil
    local bombarder_row_count = 0
    for _, invader in pairs( bombarder.current_level_bombarder[row] ) do
        bombarder_row_count = bombarder_row_count + 1
    end
    if bombarder_row_count == 0 then
        bombarder.current_level_bombarder[row] = nil
    end
    bombarder.current_speed_x = bombarder.current_speed_x + bombarder.speed_x_increase_on_destroying
 end

function bombarder.new_row( row_index )
    local row = {}
    for col_index=1, bombarder.columns - (row_index % 2) do
        local new_invader_position_x = bombarder.top_left_position_x + bombarder.invader_width * (row_index % 2) + (col_index - 1) * (bombarder.invader_width + bombarder.horizontal_distance)
        local new_invader_position_y = bombarder.top_left_position_y + (row_index - 1) * (bombarder.invader_height + bombarder.vertical_distance)
        local new_invader = bombarder.new_invader( new_invader_position_x, new_invader_position_y )
        table.insert( row, new_invader )
    end
    return row
end

function bombarder.construct_level()
    bombarder.current_speed_x = initial_speed_x
    for row_index=1, bombarder.rows do
        local bombarder_row = bombarder.new_row( row_index )
        table.insert( bombarder.current_level_bombarder, bombarder_row )
    end
end

function getImageScaleForNewDimensions( image, newWidth, newHeight )
    local currentWidth, currentHeight = image:getDimensions()
    return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end
local scaleX, scaleY = getImageScaleForNewDimensions( bombarder.image, bombarder.invader_width, bombarder.invader_height )

function bombarder.draw_invader( single_invader )
    love.graphics.draw(single_invader.image,
                       single_invader.position_x,
                       single_invader.position_y, 
                       rotation, 
                       scaleX, 
                       scaleY )
end

function bombarder.draw()
    for _, invader_row in pairs( bombarder.current_level_bombarder ) do
        for _, invader in pairs( invader_row ) do
            bombarder.draw_invader( invader, is_miniboss )
        end
    end
end

function bombarder.descend_by_row_invader( single_invader )
    single_invader.position_y = single_invader.position_y + bombarder.vertical_distance / 2
end

function bombarder.descend_by_row()
    for _, invader_row in pairs( bombarder.current_level_bombarder ) do
        for _, invader in pairs( invader_row ) do
            bombarder.descend_by_row_invader( invader )
        end
    end
end

function bombarder.update_invader( dt, single_invader )
    single_invader.position_x = single_invader.position_x + ((bombarder.current_direction=='right') and 1 or -1) * bombarder.current_speed_x * dt

    if single_invader.position_x > bombarder.right_border_x then bombarder.right_border_x = single_invader.position_x end
    if single_invader.position_x < bombarder.left_border_x then bombarder.left_border_x = single_invader.position_x end
end

function bombarder.update( dt )
    local bombarder_rows = 0
    for _, invader_row in pairs( bombarder.current_level_bombarder ) do
        bombarder_rows = bombarder_rows + 1
    end
    if bombarder_rows == 0 then
        bombarder.no_more_bombarder = true
    else
        for _, invader_row in pairs( bombarder.current_level_bombarder ) do
            for _, invader in pairs( invader_row ) do
                bombarder.update_invader( dt, invader)
            end
        end

        if bombarder.right_border_x > ( love.graphics.getWidth() - bombarder.invader_width ) then 
            bombarder.right_border_x = 0
            bombarder.current_direction = 'left'
        elseif bombarder.left_border_x < 0 then
            bombarder.left_border_x = 0
            bombarder.current_direction = 'right'
            bombarder.descend_by_row()
        end
    end
end

return bombarder