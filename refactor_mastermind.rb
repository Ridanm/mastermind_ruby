# El computador debe adivinar el código de 4 dígitos
#    Mastermind:  para que el computador 
#    adivine el código de 4 dígitos
# 1- Player
#    Crear un código de 4 dígitos
#    seleccionado por el jugador.
# 2- Computer
#    El computador en el primer turno 
#    debe crear un código al azar 
#    de 4 dígitos para comparar con 
#    el código  del jugador. 
# 3- Feedback
#    Se debe dar retroalimentación de 
#    la comparación de los códigos 
#    Es decir graficar: los aciertos, 
#    si el número está incluido pero
#    no en esa pasición, si él número
#    no está incluido en el código del 
#    jugador.
# 4- ColorGenerator
#    Basado en la retroalimentación
#    debe devolver otro código 
#    Si el número el correcto y el 
#    índice también se debe mantener
#    dicho número.
#    Si el número está en el lugar 
#    incorrecto se debe variar su
#    índice en el próximo código
#    O sea si el número no existe dicho
#    número se debe cambiar por otro
#    que va del 1 al 6
# 5- Winner
#    Comprobar cuantos turnos por 
#    comparacionhan de colores han
#    transcurrido el máximo permitido 12
#    En caso de que todos los colores 
#    coincidan hay un ganador. 
#    En caso de llegar a los 12 turnos
#    y no adivinar: Juego terminado, 
#    preguntar si quiere volver a jugar
#    Si no hay ganador y no llegamos a 
#    los 12 turnos volver al turno 4.


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

  MARK = {
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

end


class Player 

  attr_reader :player_colors, :colors
  include Colors

  def initialize 
    @player_colors = Array.new
    @colors = ''
  end

  def select_color(color)
    Colors::COLORS[color]
  end

  def enter_colors
    @colors = gets.chomp

    if @colors.size == 4 # Verificar colores 1..6 nothing more
      @colors.split('').each do |val|
          @player_colors << select_color(val)
      end
    else
      puts 'Enter 4 colors please'
    end
    @player_colors.join(' ')
  end

end


module ColorsGenerator      

  include Colors
  #Recibe un parametro feedback     
  # debemos guardarlos para
  # comparar los colores              
  # #Generar los colores                
  # Si es correcto queda el color en  
  # dicho indice                    
  #Si esta incluido cambiar el color  
  # a otro indice que no sea correcto   
  # #Si el color no esta cambiar color

  def self.colors_generator(reference, feed)       
    @new_color = []         
    empty = ''
    o_white = ''
    o_rand = rand(1..6).to_s
    feed.each_with_index do |color, ind|
      if color == Colors::MARK['black']
        @new_color << reference.computer_colors[ind]
      elsif color == Colors::MARK['white']
        o_white = reference.computer_colors[ind]
        @new_color << Colors::COLORS[o_rand]
      elsif color == ' '
        @new_color << o_white
      end
    end                                 
    puts feed.join(' | ')
    puts @new_color.join(' ')
    puts empty
  end

  def first_guess_color
    first_guess = ''
    4.times { first_guess << rand(1..6).to_s } 
    first_guess
  end

end


class Computer < Player

  attr_reader :colors, :computer_colors
  include Colors 
  include ColorsGenerator

  def initialize
    @computer_colors = Array.new
    @colors = ''
  end

  def enter_colors
    @colors = first_guess_color
    @colors.split('').each do |col|
      @computer_colors << select_color(col)
    end
  end

end


class CompareGuess
 
  def initialize(player, computer)
    @player = player 
    @computer = computer 
    @feedback_list = Array.new(4, ' ')
  end

  def verifier_guess(to_compare, compare)
    to_compare == compare 
  end

end


class Feedback

  attr_reader :feed_colors

  def initialize(player, compare)
    @player = player
    @compare = compare
  end

  #feedback
    #Usar el array de colores ingresado
    # separa cada dato split().
    #Recorrerlo con each_with 
    # dato he indice.
    #Si el dato en el array color_comp
    # coincide con player_col[index]
    #Si el color esta include?() pero 
    # en el lugar incorrecto.
    #Por último si el color no está 
    #incluido espacio en blanco, vacio

  def feedback_colors(to_compare, compare)
    @feed_colors = Array.new
    compare.each_with_index do|data, ind| 
      if data == to_compare[ind]
        @feed_colors << 'O'.colorize(:color => :light_black)
      elsif to_compare.include?(data)
        @feed_colors << 'O'.colorize(:color => :white)
      else 
        @feed_colors << ' '
      end
    end
    "Hits: [#{@feed_colors.join('|')}]"
  end

end


class Presentation

  include Colors 

  def initialize 
    @colors = Array.new 
  end

  HEAD = 'WELCOME TO MASTERMIND'

  MSJ = """
  In this game you can choose guess the code or create the code 
  Enter number : 1 to guess the code 
  or           : 2 to create the code 

  1: Guess the secret 4 color code created by the computer...
     You have 12 turns to crack the seecret code.
     Feedback: O white the color is in the wrong place
               O black the color and place is correct 
               space the color is not found

  2: Create enter 4 consecutive numbers from 1 to 6,
     each number corresponding to its color.
     If you want to quit the game at any time type: exit 
  """

  def title(head, msj) 
    long = head.length * 2
    puts head.rjust(long)
    puts msj 
  end

  def headoard
    title(HEAD, MSJ) 
  end

end


class Main 

  attr_reader :colors, :player, :computer
  include Colors 

  def initialize(player, computer, compare, feedback) 
    @player = player 
    @computer = computer
    @compare = compare 
    @feedback = feedback 
    @colors = Array.new 
  end

  def show_colors
    Colors::COLORS.each do |key, val|
      @colors << val 
    end
    puts "\nReference colors >> #{@colors.join(' ')} <<"
  end

  def computer_game 
    @computer.enter_colors
    computer_colors = @computer.computer_colors.join(' ')
    feedback = @feedback.feedback_colors(@player.player_colors, computer.computer_colors)
    colors_generator = ColorsGenerator::colors_generator(@computer, @feedback.feed_colors)
    compare = @compare.verifier_guess

    puts "Computer: #{computer_colors} #{feedback}"
    puts @colors.join(' ')
  end

  def player_game
    turns = 0
    computer_secret_code = Array.new
    @computer.first_guess_color.split('').each { |val| computer_secret_code << @computer.select_color(val) }
    puts computer_secret_code.join(' ')  #DELETE .....................
    

    @player.enter_colors
    puts "Player: #{@player.player_colors.join(' ')} >> Feedback #{@feedback.feedback_colors(computer_secret_code, @player.player_colors)}"
    winner(@compare.verifier_guess(computer_secret_code.join(' '), @player.player_colors.join(' ')))
  end

  def winner(win)
    if win
      puts "\nCONGRATULATIONS YOU GUESSED THE CODE!!!"
      puts "Play again press yes..."
    else 
      puts "Game continue define play"
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
        print 'Enter colors: '
        player_game 
      elsif select == '2'
        puts 'You must create secret code'
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
main = Main.new(player, computer, guess_compare, feedback)
main.play 
