require 'colorize'

class SudokuTile
  attr_reader :given
  attr_accessor :value

  def initialize(given, value = nil)
    @given = given
    @value = value
  end

  def to_s
    return value.to_s.colorize(:red) if @given
    value.to_s
  end
end
