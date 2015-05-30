require_relative "word_list"
require_relative "game_board"

# Main routine
w = WordList.new("wordlist.txt")
g = GameBoard.new
g.read_from_file("board1.txt")
puts g
