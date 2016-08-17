require_relative 'sudoku_tile'

class SudokuBoard
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def set_tile(row, col, value)
    @grid[row][col].value = value unless @grid[row][col].given
  end

  def self.from_file(filename)
    file = File.readlines(filename).map(&:chomp)
    new_grid = Array.new(9) { Array.new }
    file.each_with_index do |line, idx|
      line.each_char do |value|
        if value == " "
          given = false
          value = nil
        else
          given = true
          value = value.to_i
        end
        new_grid[idx] << SudokuTile.new(given, value)
      end
      while new_grid[idx].length < 9
        new_grid[idx] << SudokuTile.new(false, nil)
      end
    end
    new_grid
  end

  def render
    print "  "
    9.times { |i| print i.to_s.colorize(:blue) + " " }
    count = 0
    (9).times do |row|
      puts
      print row.to_s.colorize(:blue) + " "
      9.times do |col|
        print (@grid[row][col].value != nil ? @grid[row][col].to_s + " " : "- ")
      end

    end
    puts
    puts
  end

  def solved?
    solved_rows && solved_columns && solved_subsquares
  end

  def solved_rows
    @grid.each do |row|
      seen_nums = []
      row.each do |tile|
        return false if tile.value == nil
        seen_nums << tile.value
      end
      return false unless seen_nums.sort == (1..9).to_a
    end
    return true
  end

  def solved_columns
    9.times do |column_number|
      seen_nums = []
      9.times do |row_number|
        return false if @grid[row_number][column_number].value == nil
        seen_nums << @grid[row_number][column_number].value
      end
      return false unless seen_nums.sort == (1..9).to_a
    end
    return true
  end

  def solved_subsquares
    subsquare = Array.new(3) { [] }
    i = 0
    while i <= 6 do
      j = 0
      while j <= 6 do
        seen_nums = []
        row_offset = 0
        while row_offset < 3 do
          col_offset = 0
          while col_offset < 3 do
            row = i + row_offset
            col = j + col_offset
            tile = @grid[row][col]
            return false if tile.value == nil
            seen_nums << tile.value
            col_offset += 1
          end
          row_offset += 1
        end
        return false unless seen_nums.sort == (1..9).to_a
        j += 3
      end
      i += 3
    end
    true
  end
end


if $PROGRAM_NAME == __FILE__ then
  if ARGV.length != 1 then
    game = SudokuBoard.new(SudokuBoard.from_file('game2.txt'))
  else
    game = SudokuBoard.new(SudokuBoard.from_file(ARGV[0]))
  end
  game.render
  puts "Solved?: #{game.solved?}"
end
