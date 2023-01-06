require 'rubocop'
require 'colorize'

module Welcome 
  HEAD = ' WELCOME TO MASTERMIND '

  def self.title(text)  
    lines = '-' * text.size 
    puts "#{lines}\n#{text}\n#{lines}"
  end
end
Welcome.title(Welcome::HEAD)

class ComputerChoose 
  attr_reader :colors, :comp_random_colors
  def initialize
    colors
    @player_selected_colors = Array.new 
    @hits = Array.new 
    @turns = 0
    @guess = ''
  end

# 192 clavijas de los colores a elejir
def colors 
  @colors = [
    'ALL COLORS IN THE GAME: ',
    '  1  '.colorize(:color => :white, :background => :red),
    '  2  '.colorize(:color => :white, :background => :blue),
    '  3  '.colorize(:color => :black, :background => :green),
    '  4  '.colorize(:color => :black, :background => :yellow),
    '  5  '.colorize(:color => :white, :background => :light_magenta),
    '  6  '.colorize(:color => :black, :background => :light_cyan)
  ]
end

# Mostrar los colores 
  def show_colors
      puts @colors.join(' ')
  end

# Acceder a los colores
  def choose_color(num)
    puts @colors[num]
  end

# 60 espigas blancas y negras
  def white_spike 
    return 'O'.colorize(:color => :white)
  end

  def black_spike
    puts 'O'.colorize(:color => :light_black)
  end

# 4 espigas de tanteo 2 rojas y 2 azules
  def red_spike
    puts 'O'.colorize(:color => :red)
  end

  def blue_spike 
    puts 'O'.colorize(:color => :blue)
  end

  def white_space
    puts ' '
  end

# En inicio la computadora selecciona aleatoriamente los 4 colores secretos
  def computer_random_colors
    @comp_random_colors = Array.new
    4.times { @comp_random_colors << @colors[rand(1..6)] }
    puts "COMPUTER SELECTED COLORS: #{@comp_random_colors.join(' ')}"
  end

  def player_colors 
    "YOUR SELECTED COLORS: #{@player_selected_colors.join(' ')}"
  end

# El jugador humano tiene 12 turnos para adivinar
  def msj_for_player
    """
    The mission: 
    Gues the secret 4 color code created by the computer...
    You have 12 turns to crack the seecret code.
    Enter 4 consecutive numbers from 1 to 6, each number corresponding to its color.
    If you want to quit the game at any time type: exit 
    """
  end

# Ingresando código a verificar y restando turnos 
  def guess! 
    print "\nEnter the 4-digit code: "
    @guess = gets.chomp 
  end

  def verifier_guess
    if @guess == 'exit'
      puts 'Thanks for playin Mastermind'
      exit
    else
      if @guess.size == 4
      @enter_guess = @guess.split('')
      @player_selected_colors = []
      @hits = []

        @enter_guess.each_with_index do |number, ind|
# Por cada turno debe recibir retroalimentoción de lo supocición de colores
# comprobar si el color está lo que en el lugar incorrecto
# comprobar si el número y el índice coinciden
# Verificar si los números están entre 1 y 6
        @player_selected_colors << @colors[number.to_i]

          if number.to_i.between?(1, 6)

            if @colors[number.to_i] == @comp_random_colors[ind]
              #puts "The color: #{colors[number.to_i]} is correct"
              @hits << 'O'.colorize(:color => :light_black)
            elsif @comp_random_colors.include?(@colors[number.to_i]) 
              #puts "The color: #{colors[number.to_i]} is in the wrong place !!!"
              @hits << 'O'.colorize(:color => :white)
            else 
              #puts "The color: #{colors[number.to_i]} is wrong"
              @hits << ' ' 
            end

          else
            puts "NUMBERS MUST: be between 1 and 6..."
          end

        end
      else
        puts "\nTHE NUMBER OF COLORS: is from 1 to 6..."
        puts 'MUST BE: a 4-digit number, one number for each color.'
      end
      puts "#{player_colors}  YOUR HITS: #{hits!}" 
    end
  end

  # def repeat_turns(repeat)
  #   until @turns == 4 
  #     guess!
  #     repeat 
  #     @turns += 1
  #     winner 
  #   end
  # end

  def hits!
    "| #{@hits.join(' | ')} |"
  end

  def reference
    puts """REFERENCE HITS: 
                | #{'O'.colorize(:color => :white)} |: The white spike is in the wrong place.
                | #{'O'.colorize(:color => :light_black)} |: The black spike is in the correct place.
                |   |: The color is not included in the secret code."""
  end

  def winner
    if @player_selected_colors == @comp_random_colors
      puts "\nCONGRATUALTIONS YOU HAVE BROKEN THE SECRET CODE!!!
      "
      exit 
    end
  end

  def loose 
    puts "\nYOUR TURNS ARE OVER IN THIS GAME!!!" if @turns == 12
  end

  def turns! 
    puts "#{1 - @turns} TURNS LEFT"
  end

  def play_again 
    if @turns == 12
      puts 'IF YOU HAVE TO PLAY AGAIN WRITE: yes'
      puts 'Or any key to quit...'
      @again = gets.chomp.downcase
      if @again == 'yes'
        @turns = 0
        start_game 
      else 
        puts 'THANKS FOR PLAYING...'
        exit 
      end
    end
  end

  def start_game
    puts msj_for_player
    show_colors
    reference
    puts 
    computer_random_colors
    until @turns == 12
      guess!
      turns!
      verifier_guess 
      @turns += 1
      winner 
      loose 
      play_again
    end
  end 
end 





 class PlayerChoose < ComputerChoose  
  def initialize 
    @computer_selected_colors = Array.new 
    @player_selected_colors = Array.new 
    @hits = Array.new 
    @save_matches = [' ', ' ', ' ', ' '] 
    @save_hits = [' ', ' ', ' ', ' ']
    @turns = 0
    @guess = ''
    @computer = ComputerChoose.new 
  end

  def sample_colors
    #El jugador debe elegir los colores del código secreto 
    puts 
    @computer.show_colors
    puts "\nEnter 4 consecutive numbers from 1 to 6"
    puts "Each number corresponding to its color."
  end

# Player selecciona los colores del código (a descifrar por el computador)
  def choose_colors
    print "\nEnter numbers of the colors: "
    @colors = gets.chomp

    if @colors.size == 4
    @colors.split('').each do |num|
        if num.to_i > 0 && num.to_i < 7
          @player_selected_colors << @computer.colors[num.to_i]
        else 
          puts "\nPLEASE SELECT NUMBERS 1 to 6"
        end
      end
      print "YOUR SELECTED COLORS: "
      puts @player_selected_colors.join(' ') if @player_selected_colors.size == 4
    else 
      puts 'Please choose 4 colors...'
    end

    def player_selected_colors
      puts @player_choose_colors
    end
  end

  # si el humano elige los colores el computador debe ser capaz de adivinar
  # Si elige modificar las reglas, puede proporcionar a la computadora información
  # adicional sobre cada suposición. Por ejemplo, puede comenzar haciendo que la 
  # computadora adivine al azar, pero mantenga las que coincidan exactamente. 
  # Puede agregar un poco más de inteligencia al reproductor de la computadora 
  # para que, si la computadora ha adivinado el color correcto pero en la posición 
  # incorrecta, su siguiente intento tendrá que incluir ese color en alguna parte.
  def computer_guess 
    print "\nCOMPUTER GUESS: "
    #4.times {  @computer_selected_colors <<  @computer.colors[rand(1..6)] }
    4.times do 
      print 'Num de prueba: '
      num = gets.chomp 
      @computer_selected_colors << @computer.colors[num.to_i]
    end
    puts @computer_selected_colors.join(' ')
  end

  # 1-Comparamos la primera selección del computador 
    #   Si coinciden en indíce y color lo agregamos a save_matches
    #   Le damos retroalimentación de si tuvo alguna coincidencia, 
    #   Si es así debemos tomar en cuenta dicha coincidencia para,
    #   el proximo turno.
  # 2-Comprobamos que no adivinno todos los colores
  # 3-Retroalimentación tomamos en cuenta los aciertos show_matches,
        # para generar el próximo código
  # 4-Computador vuelve a dor otro código de colores hasta adivinar,
  #     o en su defecto el termino de los turnos 
  def compare_colors # WORK HERE !!! change focus
    # until !@save_matches.include?(' ') || @turns == 3
    #   puts "turnos:: #{@turns}"
      @player_selected_colors.each_with_index do |player_col, pos|
      @computer_selected_colors.each_with_index do |computer_col, ind|

        if ind == pos && player_col == computer_col 
          @save_matches[ind] = 'O'.colorize(:color => :light_black)
        elsif @player_selected_colors.include?(computer_col) && @save_matches.include?(' ')
          @save_matches[ind] = 'O'.colorize(:color => :cyan)
          end

        end
      end
    #   @turns += 1
    # end
  end

  def show_hits 
    puts "SHOW HITS NOT YET: | #{@save_matches.join(' | ')} |"
  end

  def winner
    if @player_selected_colors == @computer_selected_colors
      puts "COMPUTER HAS BROKE THE CODE..."
      exit 
    end
  end

  def loose 
    puts "GAME OVER... CODE NOT CRACKED" if @turns == 2
  end

  def start_scene 
    sample_colors
    choose_colors
    player_selected_colors
    computer_guess
    compare_colors
    show_hits 
    winner 
    loose 
  end
  
end

class Main 
  def initialize 
    #select = [player_guess, computer_guess]
  end

  def player_guess 
    computer = ComputerChoose.new
    computer.start_game 
  end

  def computer_guess 
    player = PlayerChoose.new
    player.start_scene
  end

# Refactorizar el código para que el jugador decida si quiere adivinar o elejir 
# el código secreto de colores 
  def choose_player_computer
    puts """ENTER: 
       1 to guess code 
       2 to create code"""
    print 'Select number: '
    @choose = gets.chomp.downcase 

    until @choose == "1" || @choose == '2'
      puts 'Please select 1 to guess code, or 2 to create code'
      @choose = gets.chomp.downcase 
    end

    if @choose == "1"
      puts 'Computer choose colors...'
      player_guess 
    elsif @choose == '2'
      puts 'Player choose colors...'
      computer_guess 
    end
  end 
end

principal = Main.new 
principal.choose_player_computer