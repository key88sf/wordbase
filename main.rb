require_relative "word_list"
require_relative "game_board"
require_relative "solver"

# Main routine
word_list = WordList.new
word_list.build_from_file("twl06.txt")
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

puts "Compute farthest distance ? (1 = downward, -1 = upward, 0 = skip): "
directionality = gets.strip.to_i

solver = Solver.new(board, word_list)
if directionality != 0
  solver.prepare_distance_calc(starting_row: row, direction: directionality)
end

if col == "*"
  for c in 0..board.width-1
    solver.solve(row, c)
  end
else
  col = col.to_i
  solver.solve(row, col)
end

puts "Completed"
puts "Stats: "
puts solver.stats
