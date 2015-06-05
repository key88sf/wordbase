class GameBoard

  def initialize
    @width = 10
    @height = 13 # strange, right?
    @board = Array.new
  end

  attr_reader :width
  attr_reader :height

  def read_from_file(board_filename)
    File.open(board_filename).each do |line|
      line.chomp!
      line.each_char do |c|
        @board << c
      end
    end
  end

  def next_possible_coords(row, col)
    # Return array of (row,col) pairs for up to 8 possible next moves.
    possibilities = Array.new
    possibilities << [row-1, col-1] if valid_coords?(row-1, col-1)
    possibilities << [row-1, col] if valid_coords?(row-1, col)
    possibilities << [row-1, col+1] if valid_coords?(row-1, col+1)
    possibilities << [row, col-1] if valid_coords?(row, col-1)
    possibilities << [row, col+1] if valid_coords?(row, col+1)
    possibilities << [row+1, col-1] if valid_coords?(row+1, col-1)
    possibilities << [row+1, col] if valid_coords?(row+1, col)
    possibilities << [row+1, col+1] if valid_coords?(row+1, col+1)

    possibilities
  end

  def to_s
    for row in 0..@height-1
      for col in 0..@width-1
        print char_at(row, col)
      end
      puts
    end
  end

  def char_at(row, col)
    # NOTE: (0,0) is top left corner
    @board[row * @width + col]
  end

  private

  def valid_coords?(row, col)
    row >= 0 && row < @height && col >= 0 && col < @width
  end

end
