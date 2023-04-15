class Presentation

  include ColorsMarks

  HEAD = ColorsMarks.text_color('green', 'WELCOME TO MASTERMIND')
  o_white = ColorsMarks.text_color('white', ' O ')
  o_black = ColorsMarks.text_color('black', ' O ')

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

  def show_option_one
    option_one = <<-HEREDOC

    Player: Guess the secret code...
    Enter 4 consecutive numbers from 1 to 6 to select colors."
    HEREDOC
  end

  def show_option_two
    option_two = <<-HEREDOC 

    You have chosen option number 2, 
    enter 4 numbers form 1 to 6, 
    each number corresponding to its color."
    HEREDOC
  end

  def end_of_game 
    game_over = "\nGame over, play again type yes or any key to close..."
    thanks = "Thak for playing, we hope to see you again"
    report_bugs = "Report bugs failures or possibble improvements, contact: danyfox1.dm@gmail.com"

    puts ColorsMarks.text_color('green', game_over)
    @play_again = gets().chomp.downcase
    if @play_again == 'yes'
      Main.new.play_again
    else 
      puts ColorsMarks.text_color('green', thanks)
      puts ColorsMarks.text_color('green', report_bugs)
    end
  end

end