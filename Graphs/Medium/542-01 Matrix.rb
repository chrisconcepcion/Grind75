# Approach:
# 1. Gather zero locations and mark others as "unknown".
# 2. Using the locations of the zeros use bfs algo to transverse the matrix one set of neighbors at a time for each zero location. We determine the distance from zero for each non-zero neighbor by by using an counter value that increases each time we go through a set of zero locations.

# Time: O(|Vertices|)
# Space: O(|Vertices|)

# @param {Integer[][]} mat
# @return {Integer[][]}
def update_matrix(mat)
    zero_nebs = ZeroNeighborsAway.new(mat)
    # Gather zero locations and mark others as "unknown".
    zero_nebs.collect_zero_locations
    # Using the locations of the zeros use bfs algo to transverse the matrix one set of neighbors at a time for each zero location. We determine the distance from zero for each non-zero neighbor by by using an counter value that increases each time we go through a set of zero locations.
    zero_nebs.generate_zero_away_matrix
    # Return the updated matrix.
    zero_nebs.matrix
end

class ZeroNeighborsAway
    attr_accessor :matrix, :new_matrix

    def initialize(matrix)
        @matrix = matrix
        @matrix_size = matrix.size
        @y_max = @matrix_size - 1
        @x_max = matrix[0].size - 1
        @visited = {}
        @zero_locations = []
    end
    # Time: O(|N|)
    # Space: O(|N|)
    def collect_zero_locations
        y_index = 0
        matrix_size = @matrix.size
        while y_index < @matrix_size
            row = []
            x_index = 0
            while x_index < @matrix[0].size
                if @matrix[y_index][x_index] == 0
                    @zero_locations << [y_index, x_index]
                else
                     @matrix[y_index][x_index] = "unknown"
                end

                x_index = x_index + 1
            end
            y_index = y_index + 1
        end
    end

    # Time: O(|Vertices|)
    # Space: O(|Vertices|)
    def generate_zero_away_matrix
        # use bfs to find the closet 0 by going through one neighbor at a time searching for zero
        neighbors = []
        @zero_locations_size = @zero_locations.size
        index = 0
        while index < @zero_locations_size
            zero_coordinates = @zero_locations[index]
            y = zero_coordinates[0]
            x = zero_coordinates[1]

            if y < @y_max
                new_ele = [y+1, x, 1]
                val = @matrix[ new_ele[0] ][ new_ele[1] ]
                if val == "unknown"
                    neighbors << new_ele
                end
            end

            if y > 0
                new_ele = [y - 1, x, 1]
                val = @matrix[new_ele[0]][new_ele[1]]
                if val == "unknown"
                    neighbors << new_ele
                end
            end

            if x > 0
                new_ele = [y, x - 1, 1]
                val = @matrix[new_ele[0]][new_ele[1]]
                if val == "unknown"
                    neighbors << new_ele
                end
            end

            if x < @x_max
                new_ele = [y, x + 1, 1]
                val = @matrix[new_ele[0]][new_ele[1]]
                if val == "unknown"
                    neighbors << new_ele
                end
            end
            index = index + 1
        end


        not_found = false
        while neighbors.size > 0

            neighbor = neighbors.shift

            y = neighbor[0]
            x = neighbor[1]

            counter = neighbor[2]
            value = @matrix[y][x]


            if value == 0
                next
            else
                if value == "unknown"
                    if counter == 8
                        @matrix[neighbor[0]][neighbor[1]] = counter
                    else
                        @matrix[neighbor[0]][neighbor[1]] = counter
                    end
                else
                    if value > counter
                        @matrix[neighbor[0]][neighbor[1]] = counter
                    end
                end
            end

            new_counter = counter + 1
            if y < @y_max
                new_ele = [y + 1, x]
                val = @matrix[new_ele[0]][new_ele[1]]
                if val == "unknown"
                    neighbors << [y + 1, x, new_counter]
                end
            end

            if y > 0
                new_ele = [y - 1, x]
                val = @matrix[new_ele[0]][new_ele[1]]
                if val == "unknown"
                    neighbors << [y - 1, x, new_counter]
                end
            end

            if x > 0
                new_ele = [y, x - 1]
                val = @matrix[new_ele[0]][new_ele[1]]
                if val == "unknown"

                    neighbors << [y,x - 1, new_counter]
                end
            end

            if x < @x_max
                new_ele = [y, x + 1]
                val = @matrix[new_ele[0]][new_ele[1]]
                if val == "unknown"
                    neighbors << [y, x + 1, new_counter]
                end
            end
        end
    end
end
