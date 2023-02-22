# Approach
# 1. Create a function that takes a coordinate and if that coordinate matches the color of the starting pixel, change its color and then do the same for it's neighbors in recursive fashion.
# 2. Call this function with the starting pixel/coordinate.


# DFS
# Time: O(|Edges| + |Vertices|)
# Space: O(|Matched edges| * |Bonus Edges(edges unused but stored)|)

# @param {Integer[][]} image
# @param {Integer} sr
# @param {Integer} sc
# @param {Integer} color
# @return {Integer[][]}
def flood_fill(image, sr, sc, color)
    # Get starting pixel as this is our starting location and it determines the color we are converting
    # to new color.
    starting_pixel_num = image[sr][sc]
    # Initialize flood machine.
    flood_machine = FloodMachine.new(image, starting_pixel_num, color)
    # Time: O(|Edges| + |Vertices|)
    # Space: O(|Matched edges| * |Bonus Edges(edges unused but stored)|)
    # Takes a coordinate and if that coordinate matches the color of the starting pixel, change its color and then do the same for it's neighbors in recursive fashion.
    flood_machine.flood sr, sc
    # Returns modified image
    flood_machine.image
end

class FloodMachine
    attr_accessor :image, :convert_from_color, :new_color, :y_max, :x_max

    def initialize(image, convert_from_color, new_color)
        @image = image
        @convert_from_color = convert_from_color
        @new_color = new_color
        @y_max = image.size - 1
        @x_max = image[0].size - 1
    end

    # Time: O(|Edges| + |Vertices|)
    # Space: O(|Matched edges| * |Bonus Edges(edges unused but stored)|)
    # Takes a coordinate and if that coordinate matches the color of the starting pixel, change its color and then do the same for it's neighbors in recursive fashion.
    def flood y, x

        if @convert_from_color == @new_color
            return
        end
        pixel = @image[y][x]

        if pixel == @convert_from_color
            @image[y][x] = @new_color

            # north
            if y > 0
                flood (y-1), x
            end

            # south
            if y < @y_max
                flood (y+1), x
            end

            # east
            if x > 0
                flood y, x - 1
            end

            # west
            if x < @x_max
                flood y, x + 1
            end
        end
    end
end
