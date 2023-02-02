# El computador debe adivinar el código de 4 dígitos
# 1- Crear un código de 4 dígitos creado por el jugador 
# 2- El computador debe crear un código de 4 dígitos para comparar con el del jugador 
# 3- Se debe dar retroalimentación de la comparación de los códigos 
#    Es decir graficar: los aciertos, 
#                       si el número está incluido pero no en esa pasición, 
#                       si él número no está incluido en el código del jugador 
# 4- Basado en la retroalimentación debe devolver otro código 
#    Si el número el correcto y el índice también se debe mantener dicho número 
#    Si el número está en el lugar incorrecto se debe variar su índice en el próximo código
#    O sea si el número no existe dicho número se debe cambiar por otro del 1 al 6
# 5- Comprobar basados en una variable turnos cuantos han transcurrido el máximo permitido 12 
#    En caso de que todos los colores coincidan hay un ganador. 
#    En caso de llegar a los 12 turnos y no adivinar: Juego terminado, preguntar si quiere volver a jugar
#    Si no hay ganador y no llegamos a los 12 turnos volver al paso 4 
require 'colorize'

module Colors 
  HEAD = 'WELCOME TO MASTERMIND'

  MSJ = """
  The mission: 
  Gues the secret 4 color code created by the computer...
  You have 12 turns to crack the seecret code.
  Enter 4 consecutive numbers from 1 to 6, each number corresponding to its color.
  If you want to quit the game at any time type: exit 
  """

  COLORS = {
    '1' => '  1  '.colorize(:color => :white, :background => :red),
    '2' => '  2  '.colorize(:color => :white, :background => :blue),
    '3' => '  3  '.colorize(:color => :black, :background => :yellow), 
    '4' => '  4  '.colorize(:color => :black, :background => :cyan),
    '5' => '  5  '.colorize(:color => :black, :background => :green), 
    '6' => '  6  '.colorize(:color => :white, :background => :magenta)
  }

  def self.title(text)
    lines = '-' * text.size 
    puts "#{lines}\n#{text}\n#{lines}"
  end

  def self.msj(msj)
    puts msj
  end
end




class Player 
  attr_reader :player_colors, :colors
  include Colors

  def initialize 
    player_colors = Array.new
  end

  def select_color(color)
    Colors::COLORS[color]
  end

  def enter_colors
    print "Enter 4 consecutive numbers, \neach number corresponding to its color: "
    @colors = gets.chomp 
  end
end



class Computer < Player
  attr_reader :computer_colors 
  include Colors 

  def initialize
    computer_colors = Array.new
  end
end




class CompareGuess
  def initialize(player, computer) 
    @player = player 
    @computer = computer 
  end

  def verifier_guess(guess)

  end
end



class Main 
  attr_reader :colors, :player, :computer
  include Colors 

  def initialize(player, computer) 
    @player = player 
    @computer = computer
    @colors = []
  end

  def show_colors
    Colors::COLORS.each do |key, val|
      @colors << val 
    end
    puts @colors.join(' ')
  end

  def computer_game 

  end

  def player_game
    @player.enter_colors
  end


end

player = Player.new
computer = Computer.new 


main = Main.new(player, computer)
main.show_colors
main.player_game


