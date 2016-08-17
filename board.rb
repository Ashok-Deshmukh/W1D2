require_relative "card"

class Board
  BOARD_SIZE = 4

  attr_reader :cards

  def initialize()
    populate
    render
  end

  def render
    print "  "
    BOARD_SIZE.times { |i| print i.to_s + " " }
    count = 0
    (BOARD_SIZE**2).times do |i|
      if i % BOARD_SIZE == 0 then
        puts
        print count.to_s + " "
        count += 1
      end
      print (@cards[i].display? ? @cards[i].to_s + " " : "- ")
    end
    puts
    puts
  end

  def size
    BOARD_SIZE
  end

  private

  def populate
    ## create board for card placement
    @cards = Array.new(BOARD_SIZE**2 - 1)
    ## keep track of open sites for card placement
    open_sites = (0...BOARD_SIZE**2).to_a
    ## populate at random
    ((BOARD_SIZE**2)/2).times do |value|
      ## generate two same-valued cards
      card_one = Card.new(value)
      card_two = Card.new(value)
      new_cards = [card_one, card_two]
      # new_cards = Array.new(2) { Card.new(value) }
      ## place at random open position on board
      new_cards.each do |card|

        random_site = open_sites.sample
        place_card(card, random_site)
        open_sites.delete(random_site)  ## clean up open sites
      end
    end
  end

  def place_card(card, position)
    @cards[position] = card
  end
end
