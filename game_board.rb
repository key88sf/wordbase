class GameBoard

  def initialize
    @width = 10
    @height = 13 # strange, right?
    @board = Array.new
  end

  def read_from_file(board_filename)
    File.open(board_filename).each do |line|
      line.chomp!
      line.each_char do |c|
        @board << c
      end
    end
  end

  def char_at(row, col)
    # NOTE: (0,0) is top left corner
    @board[row * @width + col]
  end

  def to_s
    for row in 0..@height-1
      for col in 0..@width-1
        print char_at(row, col)
      end
      puts
    end
  end

end
