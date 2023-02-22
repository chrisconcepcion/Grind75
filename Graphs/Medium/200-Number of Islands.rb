# Approach
# We go through each item in the matrix,
# 1. when the item value is 0, we set it to visited and
# 2. when the item value is 1, we set it to visited, update our island count by 1 and then we use bfs algo to find all neighbors, their children recursively and set all items whose value that equates to 1 to visited without updating the island count(as it's a single island').
# 3. Once we have visisted all items in the matrix, we return the island count.

# Time: O(|Vertices|)
# Space: O(|Vertices|)

# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
    island_finder = IslandFinder.new(grid)
    island_finder.calculate_number_of_islands
    return island_finder.number_of_islands
end


class IslandFinder
    attr_accessor :coordinate_map, :number_of_islands, :grid

    def initialize(grid)
        @number_of_islands = 0
        @grid = grid
        @x_coordinate_max = @grid[0].size - 1
        @y_coordinate_max = @grid.size - 1
    end

    def calculate_number_of_islands

        y_coordinate = 0
        grid_size = @grid.size
        while y_coordinate < grid_size
            x_coordinate = 0
            grid_x_size = @grid[0].size

            while x_coordinate < grid_x_size
                current_coordinate_val = @grid[y_coordinate][x_coordinate]

                # check if this coordinate has been explored
                if current_coordinate_val == "v"
                else
                    # check if current_coordinate_val returns an island
                    # or
                    # water.

                    # set coordinate map for this coordinate to "water"
                    if current_coordinate_val == "0"
                        current_coordinate_val = "v"
                    else
                        current_coordinate_val = "v"
                        # Update num of islands as we found a new island
                        @number_of_islands = @number_of_islands + 1
                        # find all other coordinates attached to the island
                        find_and_visit_other_parts_of_island y_coordinate, x_coordinate
                    end
                end

                x_coordinate = x_coordinate + 1
            end

            y_coordinate = y_coordinate + 1
        end
    end



    def find_and_visit_other_parts_of_island y_coordinate, x_coordinate

        to_be_tested = []
        # north
        if y_coordinate > 0
            to_be_tested << [y_coordinate - 1, x_coordinate]
        end

        # west
        if x_coordinate > 0
            to_be_tested << [y_coordinate, x_coordinate - 1]
        end

        # south
        if y_coordinate < @y_coordinate_max
            to_be_tested << [y_coordinate + 1, x_coordinate]
        end


        # east
        if x_coordinate < @x_coordinate_max
            to_be_tested << [y_coordinate, x_coordinate + 1]
        end

        while to_be_tested.size > 0
            current_coordinate = to_be_tested.shift
            current_coordinate_val = @grid[current_coordinate[0]][current_coordinate[1]]
            @grid[current_coordinate[0]][current_coordinate[1]] = "v"
            if current_coordinate_val == "1"
                find_and_visit_other_parts_of_island current_coordinate[0], current_coordinate[1]
            end
        end
    end
end
