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

  def self.text_color(clave, msj)
    {
      'red' => msj.colorize(:color => :red),
      'yellow' => msj.colorize(:color => :yellow),
      'blue' => msj.colorize(:color => :blue), 
      'cyan' => msj.colorize(:color => :cyan),
      'green' => msj.colorize(:color => :green), 
      'magenta' => msj.colorize(:color => :magenta),
      'white' => msj.colorize(:color => :white, :background => :black), 
      'black' => msj.colorize(:color => :black, :background => :white),
      'light_blue' => msj.colorize(:color => :light_blue)
    }[clave]
  end

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

  def self.leave_game
    close_msj = 'Thak for your visit...'
      puts ColorsMarks.text_color('green', close_msj)
      exit
  end

end
