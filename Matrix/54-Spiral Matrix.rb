# Approach
# 1. We simply need to follow the pattern up right, down, left, up. We start with right until we hit a visited node and a non-exist node then change direction.

# @param {Integer[][]} matrix
# @return {Integer[]}
def spiral_order(matrix)
    spiral = SpiralTheMatrix.new(matrix)
    spiral.spiral_and_record_values
    return spiral.recorded_values
end

class SpiralTheMatrix
    attr_accessor :recorded_values

    def initialize(matrix)
        @recorded_values = []
        @min_x = 0
        @min_y = 0
        @max_x = matrix[0].size - 1
        @max_y = matrix.count - 1
        # Default to right
        @current_direction = "right"
        @matrix = matrix
        @visited = Set.new
    end

    def change_direction
        case @current_direction
        when "right"
            @current_direction = "down"
        when "down"
            @current_direction = "left"
        when "left"
            @current_direction = "up"
        when "up"
            @current_direction = "right"
        end
    end

    def spiral_and_record_values coordinates = nil
        if coordinates == nil
            coordinates = [0, 0]
        end

        @visited << coordinates
        @recorded_values << @matrix[coordinates[0]][coordinates[1]]

         next_coordinates = next_spiral_destination coordinates
         if next_coordinates
            spiral_and_record_values next_coordinates
         end
    end

    def next_spiral_destination coordinates, tried_directions = Set.new
        success = false
        next_coordinates = nil

        case @current_direction
        when "right"
            next_coordinates = [coordinates[0],  (coordinates[1] + 1 )]
            if @max_x  >= next_coordinates[1] && @matrix[next_coordinates[0]][ next_coordinates[1]] && (!@visited.include? next_coordinates)
                success = true
            end
        when "down"
            next_coordinates = [(coordinates[0] - 1),  (coordinates[1] )]
            if next_coordinates[0] >= @min_y && @matrix[next_coordinates[0]][ next_coordinates[1]] && (!@visited.include? next_coordinates)
                success = true
            end
        when "left"
            next_coordinates = [coordinates[0],  (coordinates[1] - 1 )]
            if next_coordinates[1] >= @min_x && @matrix[next_coordinates[0]][ next_coordinates[1]] && (!@visited.include? next_coordinates)
                success = true
            end
        when "up"
            next_coordinates = [(coordinates[0] + 1), coordinates[1] ]
            if @max_y  >= next_coordinates[0] && @matrix[next_coordinates[0]][ next_coordinates[1]] && (!@visited.include? next_coordinates)
                success = true
            end
        end

        if success == false
            if tried_directions.size == 4
                return nil
            else
                tried_directions << @current_direction
                change_direction
                next_coordinates = next_spiral_destination coordinates, tried_directions
            end

        end

        return next_coordinates
    end
end
