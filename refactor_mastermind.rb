# El computador debe adivinar el código de 4 dígitos
#    Mastermind:  para que el computador 
#    adivine el código de 4 dígitos
# 1- Player
#    Crear un código de 4 dígitos ingresado por el jugador.
# 2- Computer
#    El computador en el primer turno debe crear un código al azar 
#    de 4 dígitos para comparar con el código del jugadorn basado en el feedback. 
# 3- Feedback
#    Se debe dar retroalimentación de la comparación de los códigos 
#    Es decir graficar: los aciertos, si el número está incluido pero
#    no en esa pasición, si él número no está incluido en el código del jugador.
# 4- ColorGenerator
#    Basado en la retroalimentación debe devolver otro código 
#    Si el número el correcto y el índice también se debe mantener dicho número.
#    Si el número está en el lugar incorrecto se debe variar su índice en el próximo código
#    O sea si el número no existe dicho número se debe cambiar por otro que va del 1 al 6
# 5- Winner
#    Comprobar cuantos turnos por comparación de colores han transcurrido el máximo permitido 12
#    En caso de que todos los colores coincidan hay un ganador. 
#    En caso de llegar a los 12 turnos y no adivinar: Juego terminado, preguntar si quiere
#    volver a jugar.
#    Si no hay ganador y no llegamos a los 12 turnos volver al turno 4.


# Para que el computador adivine el código de 4 dígitos
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

  COLORS = {
    '1' => '  1  '.colorize(:color => :white, :background => :red),
    '2' => '  2  '.colorize(:color => :white, :background => :blue),
    '3' => '  3  '.colorize(:color => :black, :background => :yellow), 
    '4' => '  4  '.colorize(:color => :black, :background => :cyan),
    '5' => '  5  '.colorize(:color => :black, :background => :green), 
    '6' => '  6  '.colorize(:color => :white, :background => :magenta)
  }

  Mark = {
    'black' => 'O'.colorize(:color => :light_black),
    'white' => 'O'.colorize(:color => :white)
  }

  def self.title(text)
    lines = '-' * text.size 
    puts "#{lines}\n#{text}\n#{lines}"
  end

  def self.msj(msj)
    puts msj
  end

  def select_color(color)
    COLORS[color]
  end

end


class Player 

  attr_reader :player_colors
  include Colors

  def initialize 
    @player_colors = Array.new
  end

  def enter_colors(color)
    arr_colors = Array.new 
    @player_colors = []

    color.split('').each { |num| arr_colors << num}
    
    if arr_colors.length == 4 && arr_colors.all? { |elem| elem.to_i.between?(1, 6) }
      arr_colors.each { |val| @player_colors << select_color(val) }
    else 
      @player_colors << 'Insert 4 consecutive colors please.....'
    end
    @player_colors 
  end
end


class Computer < Player

  attr_reader :computer_colors
  include Colors 

  def initialize
    @computer_colors = Array.new
  end

  def first_guess_color(first_guess)
    computer_secret_code = Array.new

    if first_guess == ''
      4.times { first_guess << rand(1..6).to_s } 
    else 
      first_guess
    end

    first_guess.split('').each { |val| computer_secret_code << select_color(val) }

    computer_secret_code
  end

  def colors_generator(comp_colors, feedback)    
    result = Array.new
    empty = ' '
    o_rand = rand(1..6).to_s

    feedback.each_with_index do |color, ind|
      if color == Colors::Mark['black']
        result << select_color(ind)
      elsif color == Colors::Mark['white']
        result <<  Colors::COLORS[o_rand]
      elsif color == ' '
        result << empty 
      end
    end 
    result 
  end

end


class CompareGuess
 
  def initialize(player, computer)
    @player = player 
    @computer = computer 
  end

  def verifier_guess(to_compare, compare)
    to_compare == compare 
  end

end


class Feedback

  include Colors 

  def initialize(player, compare)
    @player = player
    @compare = compare
  end

  def feedback_colors(to_compare, compare)
    back = Array.new 

    compare.each_with_index do|data, ind| 
      if data == to_compare[ind]
        back << Colors::Mark['black']
      elsif to_compare.include?(data)
        back << Colors::Mark['white']
      else 
        back << ' '
      end
    end
    back 
  end

end


class Presentation

  Title = 'WELCOME TO MASTERMIND'

  Msj = %Q(
  In this game you can choose guess the code or create the code 
  Enter number : 1 to guess the code 
  or           : 2 to create the code 

  1: Guess the secret 4 color code created by the computer...
     You have 12 turns to crack the seecret code.
     Feedback: O white the color is in the wrong place
               O black the color and place is correct 
               space the color is not found in the code to guess

  2: Create enter 4 consecutive numbers from 1 to 6,
     each number corresponding to its color.
     If you want to quit the game at any time type: exit 
)

  def title(head, msj) 
    long = head.length * 2
    puts head.rjust(long)
    puts msj 
  end

  def headoard
    title(Title, Msj) 
  end

  def show_option_two
    puts "\n  You have chosen option number 2, 
  enter 4 numbers form 1 to 6, 
  each number corresponding to its color."
  end

end


class Main 

  attr_reader :colors, :player, :computer
  include Colors 

  def initialize(player, computer, compare, feedback, presentation) 
    @player = player 
    @computer = computer
    @compare = compare 
    @feedback = feedback 
    @presentation = presentation 
    @colors = Array.new 
    @winner = false
    @chance = 12
  end

  def show_colors
    Colors::COLORS.each do |key, val|
      @colors << val 
    end
    puts "\nReference colors >> #{@colors.join(' ')} <<"
  end

  # computer_game
  # 1= The computer must be abble to choose four colors to compare whith the opponent's colors.
  # 2= Check the colors and they matches, winner_verifier
  # 3- Based on the feedback return another color code.
  # 4- The computer's turns must increase or decrease until the 12 turns are completed, 
  # in which case the game ends.

  def computer_game 
    turn = 0
    color = gets.chomp
    player_choose_colors = @player.enter_colors(color)
    puts "PLAYER COLORS: #{player_choose_colors.join(' ')}"  # DELETE.......
    
    print 'Computer ingrese los colores :) '
    int_colors = gets.chomp # DELETE..........................
    puts computer_colors = @computer.first_guess_color(int_colors) 
    

# until turn == 12 || @winner
    feedback = @feedback.feedback_colors(player_choose_colors, computer_colors)

    puts "\nTurn_#{turn+1}  Computer: #{computer_colors.join(' ')} Hits: [#{feedback.join('|')}]"

    compare = @compare.verifier_guess(player_choose_colors, computer_colors)
    
      turn += 1
# end

    if compare # turn >= 12 # MODIFI THIS ................
      puts "\n  Congratulations you have won...\n  The code could not be broken."
    else 
      puts "\n  The code has broken...\n  Play again write yes..." # IMPLEMENT THIS...........
    end
  end

  def player_game
    turn = 0
    computer_first_guess = @computer.first_guess_color
    puts computer_first_guess.join(' ') #DELETE.......PUTS

    until turn == 12 || @winner 
      print " \n#{@chance} opportunities, enter colors: "
      ingresa_color = gets.chomp
      @player.enter_colors(ingresa_color)
      puts "Player: #{@player.player_colors.join(' ')} >> Feedback #{@feedback.feedback_colors(computer_first_guess, @player.player_colors)}"

      winner(@compare.verifier_guess(computer_first_guess.join(' '), @player.player_colors.join(' ')))
      turn += 1
      @chance -= 1
    end
  end

  def winner(win)
    if win
      puts "\nCONGRATULATIONS YOU GUESSED THE CODE!!!"
      puts "Play again write yes..."  # IMPLEMENT THIS........
      @winner = true
    end
  end

  def play 
    select = ''

    until select == '1' || select == '2' || select == 'exit'
      print "\nEnter number: "
      select = gets.chomp
    end
    
    if select == 'exit'
      puts 'Thaks for your visit...'
      exit
    else
      if select == '1'
        puts "\nPlayer: Guess the secret code...
        Enter 4 consecutive numbers from 1 to 6 to select colors."
        show_colors
        player_game 
      elsif select == '2'
        show_colors
        @presentation.show_option_two
        print "\nEnter secret code: "
        computer_game 
      end
    end
  end

end


presentation = Presentation.new 
player = Player.new
computer = Computer.new 
guess_compare = CompareGuess.new(player,computer)
feedback = Feedback.new(player, computer)

presentation.headoard
main = Main.new(player, computer, guess_compare, feedback, presentation)
main.play 
