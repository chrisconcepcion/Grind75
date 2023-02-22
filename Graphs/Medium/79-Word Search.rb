# Approach
# 1. Create hash containing all letters in the word and their frequency in the word.
# 2. Collect the location in the graph of all letters matching the word in the hash created on step 1.
# 3. Using dfs go through the hash data by letter of the word in either sequential or reverse order(determined by frequency) and check if each letter is a neighbor of each other(following the sequence of the spelling) to determine if the word exists.

# DFS
# Time: O(|Edges| + |Vertices|)
# Space: O(|Matched edges| * |Bonus Edges(edges unused but stored)|)


# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)
    # The general idea is we tranverse the board and collect the locations of all letters within word in a hash.

    # Then based on wether or not the starting letter or ending letter has more entries, we go backwards or forwards when checking if the word exists.

    # When checking if the word exists, we:
    # 1. keep track of visited coordinates.
    # 2. Check if our current letter can connect to the next by the current location compared to the next letters location in our array.
    board_size = board.size
    x_max = board[0].size - 1
    y_max = board_size - 1


    word_letter_information = {}
    word_size = word.size
    index = 0
    letters = []

    # Time: O(N)
    # Space: O(N)
    # Update word_letter_information a letter for a key. For each value we store another hash containing:
    # 1. frequency
    # 2. set a location array to use later.
    # While also collecting data for the letter hash we also collect each letter in letters array.
    while index < word_size
        letter = word[index]

        if word_letter_information[letter]
            word_letter_information[letter][:count] = word_letter_information[letter][:count] + 1
        else
            letters << letter
            word_letter_information[letter] = {}
            word_letter_information[letter][:count] = 1
            word_letter_information[letter][:locations] = []
        end

        index = index + 1
    end



    # If last letter of the word we are piecing together appears less frequently we
    # reverse the word to save time as there are fewer possibilities(faster).
    if word_letter_information[word[-1]][:count] < word_letter_information[word[0]][:count]
        word = word.reverse
    end


    # initalize our word checker
    checker = WordChecker.new(board, word, x_max, y_max, board_size, word_letter_information)

    # Time: O(N)
    # Space: O(N)
    # collect word letter data, essentially tranversing the arrays to find the location of each letter.

    checker.collect_word_letter_data

    # A check to determine if the letters required to complete the word are available. If not we return false.
    cancel = false
    letters.each do |letter|
        if word_letter_information[letter][:locations].size < word_letter_information[letter][:count]
            cancel =true
            break
        end
    end

    if cancel
        return false
    end

    # DFS
    # Time: O(|Edges| + |Vertices|)
    # Space: O(|Matched edges| * |Bonus Edges(edges unused but stored)|)
    # Check for the existence of the word by going through each letter in the word and then seeing if the next letter is a neighbor
    checker.check_for_existence word
    return checker.found


end

class WordChecker

    attr_accessor :found, :debug, :visited
    def initialize(board, word, x_max, y_max, board_size, word_letter_information)
        @board = board
        @word = word
        @x_max = x_max
        @y_max = y_max
        @board_size = board_size
        @word_letter_information = word_letter_information
        @visited = {}
        @found = false
        @debug = []
    end


    def collect_word_letter_data
        found = false
        y_index = 0
        x_row_length = @x_max + 1
        while y_index < @board_size
            row = @board[y_index]

            x_index = 0

            while x_index < x_row_length
                letter = @board[y_index][x_index]
                if @word_letter_information[letter]
                    @word_letter_information[letter][:locations] << [y_index,x_index]
                end

                x_index = x_index + 1
            end

            if found
                    break
                end

            y_index = y_index + 1
        end
        found
    end


    # When checking if the word exists, we:
    # 1. keep track of visited coordinates.
    # 2. Check if our current letter can connect to the next by the current location compared to the next letters location in our array.
    def check_for_existence word, current_location = nil
        if @found
            return true
        end
        letter = word[0]
        next_letter = word[1]
        success = false
        if next_letter

            if current_location
                from_locations = [current_location]
            else
                from_locations = @word_letter_information[letter][:locations]
            end
            old_visted = @visited.dup
            from_locations.each do |location_1|
                @word_letter_information[next_letter][:locations].each do |location_2|
                    found = false
                    @visited = old_visted.dup
                    if !@visited[location_2]
                        found = neighbor_exist location_1, location_2
                    end

                    if found
                        @visited[location_1] = true
                        @visited[location_2] = true
                        success = check_for_existence  word[1..-1], location_2
                        if success
                            break
                        end

                    end
                end
            end
        else

            if @word_letter_information[letter][:locations].size > 0
                @found = true
                success = true
            else
                success = false
            end
        end
        @debug << [success, word]
        return success
    end

    def neighbor_exist location_1, location_2
        neighbors = []
        y = location_1[0]
        x = location_1[1]

        neighbors = [[y + 1, x], [y, x+1], [y-1, x], [y, x-1]]
        neighbors.include? location_2
    end
end
