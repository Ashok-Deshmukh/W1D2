class Card
  FACE_UP = true
  FACE_DOWN = false

  attr_accessor :value, :position
  ## value tracks the card value (integer) on the face-up side
  ## position tracks whether card is face up or face down

  def initialize(value, position = FACE_DOWN)
    @value = value
    @position = position
  end

  def display
    return @value if @position ## face-up card
    nil
  end

  def display?
    return @position
  end

  def hide
    @position = FACE_DOWN
  end

  def reveal
    @position = FACE_UP
  end

  def to_s
    @value.to_s
    ## TODO once we decide how to render the Board
  end

  def ==(other_card)
    @value == other_card.value
  end
end
