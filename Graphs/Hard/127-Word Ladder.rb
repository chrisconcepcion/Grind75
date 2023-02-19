# Approach
# 1. Take our beginning word and generate all possible outcomes if we were to change each letter in the word with all the other letters in the alphabet but keeping the remaining letters intact.
# example:
# word = cat
# possibilities = [
    # first letter changes
    # aat, bat, dat, eat, fat, gat, hat, iat, jat, kat, lat, mat, nat, oat, pat, qat, rat, sat.
    # tat, uat, vat, wat, xat, yat, zat.
    # second letter
    # cbt, cct, cdt, etc....
#]

#2.  Using our generated outcomes, check them against words in the word_list(converted to a set for efficency, set include is much faster than array include) and add all found words to a new set

# 3. Using our new set of words from step 2, we do the process again until there is no words in the set or the end word is in the set. No words in the set means we return 0 to suggest there is no possible solution, end word in the set means we do have a solution(index + 2)


# Time: O(n)
# Space: O(n)
require 'set'
def ladder_length(begin_word, end_word, word_list)
    # Time: O(n)
    # Space: O(1)
    word_list_set = Set.new(word_list)

    # Time: O(1)
    # Space: O(1)
    # edge card where end where is not included, we return 0
    if !word_list_set.include?(end_word)
        return 0
    end

    # Time: O(1)
    # Space: O(1)
    # Creates a set from the beginning word.
    current_word_set = Set[begin_word]

    index = 0
    while current_word_set.size > 0
        # Time: O(n)
        # word is always a word that matched the previous found set of words in the word list.
        # After running the block below, we will not get our original current_word_set words in the returned set.
        current_word_set = current_word_set.inject(Set[]) do |set, word|
            # Time: O(n)
            generate_possibitites_based_on_letter_changes(word).each do |possible_word_in_word_set|
                # Add possible_word_in_word_set to the set if it can be deleted
                # from word_list_set.
                # In other words, add possible_word_in_word_set to set if it's in the
                # word list.
                set << possible_word_in_word_set unless word_list_set.delete?(possible_word_in_word_set).nil?
            end
            set
        end
        # Once we found our end_word in current_word, we know we are done.
        # we return 2 because begin_word and end_word count in how many words were
        # transversed to get the answer.
        return (index + 2) if current_word_set.include?(end_word)
        # current word is empty when there is no more matching words found and this
        # means we cannot travel from begin_word to end_word
        return 0 if current_word_set.empty?
        index = index + 1
    end
    0
end

# Time: O(1)
# Space: O(1)
# Replaces a letter at index and returns the word
def replace_at(word, letter, index)
    word = word.dup
    word[index] = letter
    word
end


# Time: O(N)
# Space: O(1)
# Essentially we are returning an array of possiblies by replaces all letters in word by all other letters in the alphabet.
def generate_possibitites_based_on_letter_changes word
        index = 0
        words = []
        word_size = word.size
        while index < word_size
            all_letters_not_at_word_index = ('a'..'z').filter do |letter|
                letter != word[index]
            end

            all_letters_not_at_word_index.each do |letter|
                words << (replace_at(word, letter, index))
            end

            index = index + 1
        end
        words
    end
