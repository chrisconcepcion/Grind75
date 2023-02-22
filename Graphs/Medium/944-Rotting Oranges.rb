# Approach
# 1. Get all bad oranges first
# 2. Use 4 directional bfs with a counter to figure out how many minutes it will take spoil.
# 3. Before submmiting our minute count, we check if all oranges were spoilable and if they aren't we return -1, otherwise we return the minute count.'


# Time: O(|Vertices|)
# Space: O(|Vertices|)

# @param {Integer[][]} grid
# @return {Integer}
def oranges_rotting(grid)

    q = []
    good = []
    grid_size = grid.size
    y = 0
    col_size = grid[0].size
    while y < grid_size
        row = grid[y]
        col_index = 0
        while col_index < col_size
            orange = row[col_index]
            case orange
            when 1
                good << [y, col_index]
            when 2
                q << [y, col_index]
                orange = "#"
            end
            col_index = col_index + 1
        end
        y = y + 1
    end

    if good.size == 0
        return 0
    end

    if q.size == 0
        return -1
    end

    y_max = grid_size - 1
    x_max = col_size - 1
    minutes = 0
    converted = 0


    children = []
    will_rot = false
    while q.size > 0
        coordinate = q.shift

        y = coordinate[0]
        x = coordinate[1]

        # directionally convert all good to bad

        if y < y_max
            new_y = y+1
            new_x = x
            if grid[new_y][new_x] == 1
                will_rot = true
                converted = converted + 1
                grid[new_y][new_x] = "#"
                children << [new_y, new_x]
            end
        end

        if x < x_max
            new_y = y
            new_x = x + 1
            if grid[new_y][new_x] == 1
                will_rot = true
                converted = converted + 1
                grid[new_y][new_x] = "#"
                children << [new_y, new_x]
            end
        end

        if y > 0
            new_y = y - 1
            new_x = x
            if grid[new_y][new_x] == 1
                will_rot = true
                converted = converted + 1
                grid[new_y][new_x] = "#"
                children << [new_y, new_x]
            end
        end

        if x > 0
            new_y = y
            new_x = x - 1
            if grid[new_y][new_x] == 1
                will_rot = true
                converted = converted + 1
                grid[new_y][new_x] = "#"
                children << [new_y, new_x]
            end
        end

        if q.size == 0
            if will_rot
                minutes = minutes + 1
                will_rot = false
            end
            #d << children.to_s

            q = children
            children = []
        end
    end

    if good.size == converted
        return minutes
    else
        return -1
    end
end
