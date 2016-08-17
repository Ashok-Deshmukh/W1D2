class HumanPlayer

  def prompt
    locations = []
    puts "Choose first card (row, column):  "
    print"> "
    input = gets.chomp
    locations << [input[0].to_i, input[3].to_i]

    puts "Choose second card (row, column):  "
    print"> "
    input = gets.chomp
    locations <<  [input[0].to_i, input[3].to_i]
  end

  ## dummy methods to match computer player API
  def receive_revealed_card(l, o, lol)
  end

  def receive_match(x)
  end
end
