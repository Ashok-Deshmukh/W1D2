require_relative 'sudoku_board'

class SudokuGame
  attr_reader :board

  def initialize(board)
    @board = SudokuBoard.new(board)
    @board.render
    play
  end

  def play
    until solved do
      move = prompt
      @board.set_tile(move.row, move.col, move.value)
      @board.render
    end
    puts "You win!"
  end

  def solved
    @board.solved?
  end

  def prompt
    puts "Enter your move (row, col, value): "
    print "> "
    input = gets.chomp
    row = input[0].to_i
    col = input[3].to_i
    value = input[6].to_i
    Move.new(row, col, value)
  end

end


class Move
  attr_reader :row, :col, :value

  def initialize(row, col, value)
    @row = row
    @col = col
    @value = value
  end
end


if $PROGRAM_NAME == __FILE__ then
  if ARGV.length != 1 then
    SudokuGame.new(SudokuBoard.from_file('almost_won.txt'))
  else
    SudokuGame.new(SudokuBoard.from_file(ARGV[0]))
  end
end
