require_relative "word_list"
require_relative "game_board"
require_relative "solver"

# Main routine
word_list = WordList.new
word_list.build_from_file("wordlist.txt")
board = GameBoard.new

puts "Input board file: "
input_file = gets.strip
board.read_from_file(input_file)
puts "Board:"
puts board

puts "Starting row: "
row = gets.strip.to_i

puts "Starting col (use '*' for entire row): "
col = gets.strip

solver = Solver.new(board, word_list)
if col == "*"
  for c in 0..board.width-1
    solver.solve(row, c)
  end
else
  col = col.to_i
  solver.solve(row, col)
end

puts "Completed"
puts "Longest word = #{solver.longest_word}"
