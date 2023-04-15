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

    if color == 'exit'
      ColorsMarks.leave_game
    else
      if arr_colors.count == 4 && arr_colors.all? { |elem| elem.to_i.between?(1, 6) }
        arr_colors.each { |val| @player_colors << val }
        @check = 'exit'
      else 
        msj = 'Insert four consecutive colors please... The numbers from 1 to 6'
        puts "\n#{msj}".colorize(:color => :light_red)
        enter_colors!()
      end
    end

    @player_colors 
  end

end