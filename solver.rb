require "set"

class Solver
  def initialize(board, words)
    @game_board = board
    @word_list = words
    @visited_coords = Set.new
    @stats = {
      longest_word: nil,
      most_reaching_words: Set.new,
      all_words: Set.new,
      farthest_distance: 0,
      starting_row: nil,
      direction: 0,
      min_length: 99
    }
  end

  attr_reader :longest_word
  attr_reader :stats

  def display_stats
    puts "Longest word: #{stats[:longest_word]}"
    puts
    puts "Most Reaching Words: #{stats[:most_reaching_words].to_a.sort.join(", ")}"
    puts
    puts "All Words:"
    puts stats[:all_words].to_a.sort.join(", ")
  end

  def prepare_distance_calc(options = {})
    @stats[:starting_row] = options[:starting_row]
    @stats[:direction] = options[:direction] # +1 means going downward, -1 means upward
    @stats[:min_length] = options[:min_length]
  end

  def solve(row, col, current_stem = "")

    @visited_coords.add([row, col].to_s)

    # Add on this next char, and see if it's valid.
    current_stem << @game_board.char_at(row, col)

    word_stem = @word_list.find(current_stem)
    if word_stem

      # Check if this should be the new "best" candidate
      if word_stem.terminal
        if @stats[:longest_word].nil? || current_stem.length > @stats[:longest_word].length
          @stats[:longest_word] = current_stem
        end

        if current_stem.length >= @stats[:min_length]
          @stats[:all_words].add(current_stem)
        end

        if @stats[:starting_row]
          distance = (row - @stats[:starting_row]) * @stats[:direction]

          if distance >= @stats[:farthest_distance]
            @stats[:most_reaching_words].clear if distance > @stats[:farthest_distance]
            @stats[:farthest_distance] = distance
            @stats[:most_reaching_words].add(current_stem)
          end

        end
      end

      possible_expansion_coords = @game_board.next_possible_coords(row, col)

      possible_expansion_coords.each do |coords|
        next_row = coords[0]
        next_col = coords[1]
        solve(next_row, next_col, current_stem.dup) unless @visited_coords.include?(coords.to_s)
      end

    else
      # This stem is not for a valid word...give up on this path
    end

    # Once we've traversed through this coord, we can unwind it from the visited list
    @visited_coords.delete([row, col].to_s)
  end

end
