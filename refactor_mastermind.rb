# El computador debe adivinar el código 
#    de 5 dígitos
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
# 3- Hint
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

module ColorsMarks 
  
  Colors = {
    '1' => '  1  '.colorize(:color => :white, :background => :red),
    '2' => '  2  '.colorize(:color => :white, :background => :blue),
    '3' => '  3  '.colorize(:color => :black, :background => :yellow), 
    '4' => '  4  '.colorize(:color => :black, :background => :cyan),
    '5' => '  5  '.colorize(:color => :black, :background => :green), 
    '6' => '  6  '.colorize(:color => :white, :background => :magenta)
  }

  Mark = {
    'black' => ' O '.colorize(:color => :black, :background => :white),
    'white' => ' O '.colorize(:color => :white, :background => :black)
  }

  def self.title(text)
    lines = '-' * text.size 
    puts "#{lines}\n#{text}\n#{lines}"
  end

  def self.msj(msj)
    puts msj
  end

  def color_transform(color)
    getting_colors = Array.new
    color.each { |element| getting_colors << Colors[element] ||= getting_colors << element}
    getting_colors
  end

  def show_colors(arr)
    arr.join(' ')
  end

  def self.colors_generator(feed, reference)  
    @guard = 
    new_color = []         
    empty = ' '
    o_rand = rand(1..6)

    feed.each_with_index do |mark, ind|
      reference.each_with_index do |number, pos| 
        if mark == ColorsMarks::Mark['black']
          new_color << number[ind].to_i
        elsif mark == ColorsMarks::Mark['white']
          new_color = number[o_rand].to_i
        elsif mark == empty 
          new_color << o_rand[pos].to_i
        end
      end
    end    
    new_color                               
  end

end


class Player 

  attr_reader :player_colors, :check
  include ColorsMarks

  def initialize 
    @player_colors = Array.new
    @check = '' 
  end

  def enter_colors!
    arr_colors = Array.new 
    @player_colors = Array.new 
    color = gets.chomp 

    color.split('').each { |element| arr_colors << element}

    if arr_colors.count == 4 && arr_colors.all? { |elem| elem.to_i.between?(1, 6) }
      arr_colors.each { |val| @player_colors << val }
      @check = 'exit'
    else 
      msj = 'Insert four consecutive colors please... The numbers from 1 to 6'
      puts "\n#{msj}".colorize(:color => :light_red)
      enter_colors!()
    end

    @player_colors 
  end

end


class Computer < Player

  attr_reader :colors, :computer_colors
  include ColorsMarks 

  def initialize
    @computer_colors = Array.new
  end

  def enter_colors!(colors = '')
    computer_colors = Array.new 
    if colors == ''
      first_guess_color!.each {|col| computer_colors << col}
    else
      colors.each do |col|
        computer_colors << col
      end
    end
    computer_colors
  end

  def first_guess_color!
    computer_secret_code = Array.new
    first_guess = ''

    4.times { first_guess << rand(1..6).to_s } 
    first_guess.split('').each { |val| computer_secret_code << val }
    computer_secret_code
  end

  def feedback(codigo_azar, codigo_secreto)
    white = Array.new(4) {''}
    black = Array.new(4) {''}
  
    codigo_azar.each_with_index do |code, ind|
        if code == codigo_secreto[ind]
          black[ind] << code
        elsif codigo_secreto.include?(code)
          white[ind] << "it's include"
        elsif code != codigo_secreto[ind]
          white[ind] << "not include"
        end
      end
  
    return white, black
  end 

  def order_colors(white_arr, black_arr, guess)
    sort_colors = black_arr 
    all_elements = (1..6).to_a 
    posibles_numeros = guess 
  
    if black_arr.include?('') 
      sort_colors.each_with_index do |elem, ind|
        if elem == ''
          white_arr.each_with_index do |white_elem, pos|
            if white_elem == 'include' 
              sort_colors << posibles_numeros[ind] 
            elsif white_elem == 'not include'
              add_new_num =  all_elements.sample.to_s 
              sort_colors[ind] = add_new_num
            elsif white_elem == ''
              add_num = all_elements.sample.to_s 
              sort_colors[ind] = add_num
            end
          end
        end
      end
    end
    sort_colors
  end

end


class CheckWinner
 
  def initialize(player, computer)
    @player = player 
    @computer = computer 
  end

  def verifier_guess(to_compare, compare)
    to_compare == compare 
  end

end


class Hint

  def initialize(player, compare)
    @player = player
    @compare = compare
  end

    # Hint mediante el array de colores
    # separa cada dato split().
    # Recorrerlo con each_with 
    # dato he indice.
    # Si el dato en el array color_comp
    # coincide con player_col[index]
    # Si el color esta include?() pero 
    # en el lugar incorrecto.
    # Por último si el color no está 
    # incluido espacio en blanco, vacio

  def feedback_colors(to_compare, compare)
    back = Array.new 

    compare.each_with_index do|data, ind| 
      if data == to_compare[ind]
        back << ColorsMarks::Mark['black']
      elsif to_compare.include?(data)
        back << ColorsMarks::Mark['white']
      else 
        back << ' '
      end
    end
    back
  end

end


class Presentation

  HEAD = 'WELCOME TO MASTERMIND'
  o_white = ' O '.colorize(:color => :white, :background => :black)
  o_black = ' O '.colorize(:color => :black, :background => :white)

  MSJ = %Q(
  In this game you can choose guess the code or create the code 
  Enter number : 1 to guess the code 
  or           : 2 to create the code 
  
  1: Guess the secret 4 color code created by the computer...
     You have 12 turns to crack the seecret code.
     Hint: #{o_white} white the color is in the wrong place
           #{o_black} black the color and place is correct 
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
    title(HEAD, MSJ) 
  end

  def show_option_two
    puts "\n  You have chosen option number 2, 
  enter 4 numbers form 1 to 6, 
  each number corresponding to its color."
  end

  def end_of_game 
    puts "\nPlay again write yes...".colorize(:color => :green)
    @play_again = gets().chomp.downcase
    if @play_again == 'yes'
      play_again
    else 
      puts "Thak for playing, we hope to see you again bye".colorize(:color => :green)
    end
  end

end


class Main 

  attr_reader :colors, :player, :computer
  include ColorsMarks 

  def initialize(player, computer, compare, hint, presentation) 
    @player = player 
    @computer = computer
    @compare = compare 
    @hint = hint 
    @presentation = presentation 
    @colors = Array.new 
    @winner = false
    @chance = 12
    @turn = 0
  end

  def all_colors
    ColorsMarks::Colors.each do |key, val|
      @colors << val 
    end
    puts "\nReference colors >> #{@colors.join(' ')} <<"
  end

  # computer_game
  # 1- The computer must be abble to choose four colors to compare whith the opponent's colors.
  # 2- Check the colors and they matches, winner_verifier
  # 3- Based on the hint return another color code.
  #  - Compare if there is a winner 
  # 4- The computer's turns must increase or decrease until the 12 turns are completed, 
  #    in which case the game ends.

  def computer_game 
    until @player.check == 'exit'
      player_choose_colors = @player.enter_colors!()
      if player_choose_colors.count != 4
        puts "PLAYER Colors: #{player_choose_colors.join(' ')}"
      else
        puts "\nPLAYER Colors:   #{show_colors(color_transform(player_choose_colors))}"
        puts 
      end
    end
    
    computer_colors = @computer.enter_colors!() 
    until @turn == 12 || @winner == true 
      @turn += 1
      white_black = @computer.feedback(computer_colors, player_choose_colors)
      white = white_black[0]
      black = white_black[1]

      sort_colors = @computer.order_colors(white, black, computer_colors)

      winner?(@compare.verifier_guess(sort_colors, player_choose_colors))
      computer_colors = sort_colors

      puts "\nComputer Colors: #{show_colors(color_transform(sort_colors))} >> Hint: |#{@hint.feedback_colors(sort_colors, player_choose_colors).join('|')}|"
    end

    @presentation.end_of_game if @turn >= 12 || @winner == true 
  end

  def player_game
    computer_first_guess = @computer.first_guess_color!
    puts computer_first_guess.join(' ') #DELETE.......PUTS

    until @turn == 12 || @winner 
      @turn += 1
      print " \n#{@chance} turns left, enter colors: "
      enter_colors = @player.enter_colors!
      puts "Player: #{show_colors(color_transform(enter_colors))} >> Hint |#{@hint.feedback_colors(computer_first_guess, @player.player_colors).join('|')}|"
      winner?(@compare.verifier_guess(computer_first_guess.join(' '), @player.player_colors.join(' ')))
      @chance -= 1
    end

    @presentation.end_of_game if @turn >= 12 || @winner == true 
  end

  def winner?(win)
    if win
      puts "\nThe code has been discovered in #{@turn} turns!!!".colorize(:color => :green)
      @winner = true
      return 
    end
  end

  def play 
    select = ''

    until select == '1' || select == '2' || select == 'exit'
      print "\nEnter number: "
      select = gets.chomp
    end
    
    if select == 'exit'
      puts 'Thak for your visit...'
      exit
    else
      if select == '1'
        puts "\nPlayer: Guess the secret code...
        Enter 4 consecutive numbers from 1 to 6 to select colors."
        all_colors
        player_game 
      elsif select == '2'
        all_colors
        @presentation.show_option_two
        print "\nEnter secret code: "
        computer_game 
      end
    end
  end

end


def play_again
  presentation = Presentation.new 
  player = Player.new
  computer = Computer.new 
  guess_compare = CheckWinner.new(player,computer)
  hint = Hint.new(player, computer)

  presentation.headoard
  main = Main.new(player, computer, guess_compare, hint, presentation)
  main.play 
end 

play_again