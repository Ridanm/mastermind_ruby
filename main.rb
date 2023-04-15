require 'colorize'
require './colors_marks.rb'
require './player.rb'
require './computer.rb'
require './check_winner.rb'
require './hint.rb'
require './presentation.rb'
require './game_development.rb'

class Main  
  def play_again
    presentation = Presentation.new 
    player = Player.new
    computer = Computer.new 
    guess_compare = CheckWinner.new(player,computer)
    hint = Hint.new(player, computer)

    presentation.headoard
    to_play = GameDevelopment.new(player, computer, guess_compare, hint, presentation)
    to_play.play 
  end 
end

Main.new.play_again