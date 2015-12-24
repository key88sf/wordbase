require_relative "word_list"
require_relative "game_board"
require_relative "solver"

# Main routine
if ARGV.size < 1
  puts "Usage: main.rb <board file>"
  exit(1)
end

word_list = WordList.new
word_list.build_from_file("twl06.txt")
board = GameBoard.new

input_file = ARGV[0]
board.read_from_file(input_file)
puts "Board:"
puts board

ARGV.clear

puts "Starting row: "
row = gets.strip.to_i

puts "Starting col (use '*' for entire row): "
col = gets.strip

puts "Compute farthest distance ? (1 = downward, -1 = upward, 0 = skip): "
directionality = gets.strip.to_i

puts "Min length to store [Enter=5]: "
min_length_to_store = gets.strip.to_i
min_length_to_store = 5 if min_length_to_store <= 0

solver = Solver.new(board, word_list)
if directionality != 0
  solver.prepare_distance_calc(starting_row: row, direction: directionality, min_length: min_length_to_store)
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
puts solver.display_stats
