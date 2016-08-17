
class ComputerPlayer
  attr_reader :revealed_cards, :matched_cards, :guessed_positions


  def initialize
    @revealed_cards = Hash.new { |h, k| h[k] = [] }
    @matched_cards = []
    @guessed_positions = []
  end

  def prompt
    @revealed_cards.each do |card, positions|
      return positions if positions.length == 2
    end

    guesses = []
    2.times do
      guess = [rand(0..3), rand(0..3)]
      while guessed_positions.include?(guess) do
        guess = [rand(0..3), rand(0..3)]
      end
      guessed_positions << guess
      guesses << guess
    end
    guesses
  end

  def receive_revealed_card(value, position)
    #@grid[position[0]][position[1]] = value
    @revealed_cards[value] << position
  end

  def receive_match(value)
    @matched_cards << value
  end
end
