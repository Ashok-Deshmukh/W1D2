# require "byebug"
require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class MemoryGame
  attr_reader :board, :num_revealed_cards, :player

  def initialize(player)
    @player = player
    @board = Board.new
    @num_revealed_cards = 0
    welcome
    @board.render
    play_round

  end

  def welcome
    puts "Welcome to MemoryGame!"
  end

  def play_round
    until won? do
      locations = @player.prompt
      card_one = card_at(locations[0])
      @player.receive_revealed_card(card_one.value, locations[0])
      card_two = card_at(locations[1])
      @player.receive_revealed_card(card_two.value, locations[1])
      card_one.reveal
      card_two.reveal
      @board.render
      #sleep(3)
      #system("clear")
      # debugger
      if card_one == card_two
        @num_revealed_cards += 2
        @player.receive_match(card_one.value)
      else
        card_one.hide
        card_two.hide
      end
      @board.render
    end
  end

  def won?
    @num_revealed_cards == @board.size**2
  end

  def card_at(position)
    ## position = [row,column]
    @board.cards[@board.size*position[0] + position[1]]
  end
end

if __FILE__ == $PROGRAM_NAME then
  MemoryGame.new(ComputerPlayer.new)
end
