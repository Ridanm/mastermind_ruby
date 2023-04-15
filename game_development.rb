class GameDevelopment 

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
      puts "\nComputer Colors: #{show_colors(color_transform(sort_colors))} " +
           " >> Hint: |#{@hint.feedback_colors(sort_colors, player_choose_colors).join('|')}|"
    end

    @presentation.end_of_game if @turn >= 12 || @winner == true 
  end

  def player_game
    computer_first_guess = @computer.first_guess_color!
    until @turn == 12 || @winner 
      @turn += 1
      print " \n#{@chance} turns left, enter colors: "
      enter_colors = @player.enter_colors!
      puts "Player: #{show_colors(color_transform(enter_colors))} " +
           " >> Hint |#{@hint.feedback_colors(computer_first_guess, @player.player_colors).join('|')}|"
      winner?(@compare.verifier_guess(computer_first_guess.join(' '), @player.player_colors.join(' ')))
      @chance -= 1
    end

    @presentation.end_of_game if @turn >= 12 || @winner == true 
  end

  def winner?(win)
    if win
      discover = "\nThe code has been discovered in #{@turn} turns!!!"
      puts ColorsMarks.text_color('green', discover)
      @winner = true
    end
  end

  def play 
    select = ''

    until select == '1' || select == '2' || select == 'exit'
      print ColorsMarks.text_color('light_blue', "\nEnter number: ")
      select = gets.chomp
    end
    
    if select == 'exit'
      ColorsMarks.leave_game
    else
      if select == '1'
        puts ColorsMarks.text_color('green', @presentation.show_option_one)
        all_colors
        player_game 
      elsif select == '2'
        all_colors
        puts ColorsMarks.text_color('green', @presentation.show_option_two)
        print "\nEnter secret code: "
        computer_game 
      end
    end
  end

end