class CheckWinner
 
  def initialize(player, computer)
    @player = player 
    @computer = computer 
  end

  def verifier_guess(to_compare, compare)
    to_compare == compare 
  end

end